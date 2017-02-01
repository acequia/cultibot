r = {}
r.mode = 'variables'

r.line = function()
  local  line = file.readline()
  return line and r[r.mode](line)
end

r.variables = function(line)
  local token = line:match('{#(.-)}')

  if token then
    token = loadstring('return ' .. token)()

    if type(token) == 'table' and next(token) then
      r.mode  = 'non_empty_list'
      r.pos   = file.seek()
      r.table = token
      r.index = next(token)
    elseif type(token) ~= 'table' and token then
      r.mode  = 'non_false_value'
    else
      r.mode  = 'false_value_or_empty_list'
    end

    line = r.line()
  else
    for token in line:gmatch('{(.-)}') do
      line = line:gsub('{' .. token .. '}', loadstring('return ' .. token), 1)
    end
  end

  return line
end

r.non_false_value = function(line)
  if line:match('{/(.-)}') then
    r.mode = 'variables'
    return r.line()
  end

  for token in line:gmatch('{(.-)}') do
    line = line:gsub('{' .. token .. '}', loadstring('return ' .. token), 1)
  end

  return line
end
