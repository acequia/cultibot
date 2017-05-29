-- MQTT Client configuration
-- TODO Extract connection options

-- Create a client with client_id, keep_alive, user and password
m = mqtt.Client('test_client_123', 120, 'test', 'test')

m:on('connect', function(client)
  print('Connected!')

  client:subscribe('test_client_123', 0, function(client)
    print('Suscribed!')
  end)

  local _, reset_reason = node.bootreason()
  client:publish('test_client_123/reset_reason', reset_reason, 1, 0)

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
  m:publish('test_client_123/temperature', sensors.temperature, 1, 0)
  m:publish('test_client_123/humidity',    sensors.humidity   , 1, 0)
  m:publish('test_client_123/io',          io.state           , 1, 0)
end)
