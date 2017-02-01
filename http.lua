routes = {}

dofile('encoding.lua')
dofile('mostacholes.a.lua')
dofile('mostacholes.b.lua')
dofile('controllers.lua')

function send(socket)
  local line = r.line()

  if line then
    socket:send(line)
  else
    socket:close()
    file.close()
  end
end

function render(socket, filename)
  local header = 'HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n'

  file.open(filename, 'r')

  socket:on('sent', send)
  socket:send(header)
end

function error_404(socket)
  socket:send('error 404')
  socket:close()
end

http_server = net.createServer(net.TCP, 30)

http_server:listen(80, function(socket)
  socket:on('receive', function(socket, request)
    print(request)

    local uri = request:match('%S+ %S+')
    local body = request:match('\r\n\r\n(.*)')
    local params = decode(body)

    if routes[uri] then routes[uri](socket, params) else error_404(socket) end
  end)
end)
