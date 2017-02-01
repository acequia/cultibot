r.non_empty_list = function(line)
  local token = line:match('{/(.-)}')

  if token then
    r.index = next(r.table, r.index)

    if r.index then
      file.seek('set', r.pos)
    else
      r.mode  = 'variables'
      r.pos   = nil
      r.table = nil
    end

    line = r.line()
  else
    for token in line:gmatch('{(.-)}') do
      line =
        token == '.' and
        line.gsub('{.}', loadstring('return r.table[r.index]'), 1) or
        line:gsub('{' .. token .. '}',
          loadstring('return r.table[r.index][\'' .. token .. '\']'), 1)
    end
  end

  return line
end

r.false_value_or_empty_list = function(line)
  if line:match('{/(.-)}') then r.mode = 'variables' end
  return r.line()
end
