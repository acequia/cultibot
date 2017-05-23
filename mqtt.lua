-- MQTT Client configuration
-- TODO Extract connection options

-- Create a client with cliendid, keepalive, user and password
m = mqtt.Client('test_client_123', 120, 'test', 'test')

m:on('connect', function(client)
  print ('Connected!')

  -- publish a message with topic name, message, QoS = 1, retain = 0
  client:publish('test_topic', 'hello from bot', 1, 0,
    function(client) print('Message sent')

    client:close()
  end)
end)

m:on('offline', function(client)
  print ('Disconnected!')
end)

m:connect('conejo.mauriciopasquier.com.ar')
