-- MQTT client configuration

-- create a client with client_id, keep_alive, user and password
m = mqtt.Client(node.chipid(), 120, 'test', 'test')

m:on('connect', function(client)
  print('Connected!')

  client:subscribe('bots/'..node.chipid(), 0, function(client)
    print('Suscribed!')
  end)

  local _, reset_reason = node.bootreason()
  client:publish('bots/'..node.chipid()..'/reset_reason', reset_reason, 1, 0)

  pub:start()
end)

m:on('message', function(client, topic, message)
  print(topic)
  print(message)
end)

m:on('offline', function(client)
  print('Disconnected!')
end)

-- automatically repeating alarm every minute
pub = tmr.create()
pub:register(60000, tmr.ALARM_AUTO, function()
  -- publish a message with topic name, message, QoS = 1, retain = 0
  m:publish('bots/'..node.chipid()..'/temperature', sensors.temperature, 1, 0)
  m:publish('bots/'..node.chipid()..'/humidity',    sensors.humidity   , 1, 0)
  m:publish('bots/'..node.chipid()..'/io',          io.state           , 1, 0)
end)
