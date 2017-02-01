utf8_encoding = {['%C3%B1']='ñ'}

function unescape(s)
  s = s:gsub('%%%x%x%%%x%x', function(h)
    return utf8_encoding[h]
  end)
  s = s:gsub('+', ' ')
  s = s:gsub('%%(%x%x)', function(h)
    return string.char(tonumber(h, 16))
  end)
  return s
end

function decode(s)
  local cgi = {}
  for name, value in s:gmatch('([^&=]+)=([^&=]+)') do
    name = unescape(name)
    value = unescape(value)
    cgi[name] = value
  end
  return cgi
end
