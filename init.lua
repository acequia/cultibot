uart.setup(0, 115200, 8, 0, 1, 1)

dofile('wifi_event_monitor.lua')
dofile('settings.lua')
dofile('i2c.lua')
dofile('am2320.lua')
dofile('sensors.lua')
dofile('time_control.lua')
dofile('sensor_control.lua')
dofile('relay_logic.lua')

test = tmr.create()
test:register(2000, tmr.ALARM_AUTO, function()
  print(now())
end)

-- Enable network configuration within time window
--dofile('config.lua')
