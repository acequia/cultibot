-- MQTT client configuration

-- There is a current callbacks issue:
-- https://github.com/nodemcu/nodemcu-firmware/issues/2109

-- create a client with client_id, keep_alive, user, password
m = mqtt.Client(node.chipid(), 120, settings.mqtt.token)

function mqtt_success(client)
  print('Connected!')
  settings.mqtt.status = mqtt.CONNACK_ACCEPTED

  -- subscribe to commands from server; topic, qos, callback
  client:subscribe(settings.mqtt.topics.rpc..'request/+', 0, function(client)
    print('SUBSCRIBED', settings.mqtt.topics.rpc..'/request/+')
  end)

  local _, reset_reason = node.bootreason()
  local message = '{"reset_reason":'..reset_reason..'}'

  client:publish(settings.mqtt.topics.attr, message, 0, 0, function(client)
    -- TODO: take care of simple MQTT reconnections,
    -- which aren't resets but are being logged as suches
    print('SENT', settings.mqtt.topics.attr, message)
  end)

  pub:start()
end

function mqtt_failure(client, reason)
  print('Disconnected!')
  settings.mqtt.status = reason
  pub:stop()
end

-- triggered by wifi event monitor after wifi connection
function mqtt_connect()
  -- host, port, secure, autoreconnect, callbacks
  m:connect(settings.mqtt.host, settings.mqtt.port, 0, 0,
    mqtt_success, mqtt_failure)
end

m:on('message', function(client, topic, message)
  print('RECV', topic, message)

  -- publish RPC responses to
  -- v1/devices/me/rpc/response/$request_id
end)

-- automatically repeating alarm every minute
pub = tmr.create()
pub:register(60000, tmr.ALARM_AUTO, function()
  local message = '{"temperatura":'..sensors.temperature..',"humedad":'..sensors.humidity..'}'
  -- publish a message with topic name, message, qos, retain, callback
  m:publish(settings.mqtt.topics.tele, message, 0, 0, function(client)
    print('SENT', settings.mqtt.topics.tele, message)
  end)
end)
