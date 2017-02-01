telnet_server = net.createServer(net.TCP, 180)

telnet_server:listen(23, function(socket)
  node.output(function(output) socket:send(output) end, 1)

  socket:on('receive', function(socket, input)
    node.input(input)
  end)

  socket:send('Bienvenido.\n> ')
end)
