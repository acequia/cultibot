function read_reg(dev_addr, reg_addr)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, reg_addr)
    i2c.stop(id)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    c = i2c.read(id, 1)
    i2c.stop(id)
    return c
end

relay = {}

relay.on = function(output)
  print('Relay '..output..' ON')
end

relay.off = function(output)
  print('Relay '..output..' OFF')
end

relay.control = function(output, condition)
  if condition then
    relay.on(output)
  else
    relay.off(output)
  end
end

-- automatically repeating alarm every 500 milliseconds
outputs = tmr.create()

outputs:register(500, tmr.ALARM_AUTO, function()
  relay.control(1, time_condition( settings.lighting))
  --relay.control(2, time_condition( settings.watering))
  --relay.control(3, event_condition(settings.ventilation))
end)

-- should be a callback of sntp.sync()
outputs:start()
