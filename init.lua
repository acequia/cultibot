uart.setup(0, 115200, 8, 0, 1, 1)

dofile('settings.lua')

i2c.setup(conf.i2c.id, conf.i2c.sda, conf.i2c.scl, i2c.SLOW)

-- 7bit addresses
am2320  = 0x5C -- humidity and temperature sensor
pcf8574 = 0x20 -- I/O expander

dofile('am2320.lua')
dofile('sensors.lua')
dofile('time_control.lua')
dofile('sensor_control.lua')

gpio.mode(5, gpio.OPENDRAIN)
gpio.mode(6, gpio.OPENDRAIN)
gpio.mode(7, gpio.OPENDRAIN)

dofile('io.lua')
dofile('relay_logic.lua')

dofile('mqtt.lua')
dofile('wifi_event_monitor.lua')

-- Enable network configuration within time window

dofile('wifi.lua')
--dofile('http.lua')
--dofile('encoding.lua')
--dofile('mostacholes.lua')
--dofile('controllers.lua')
--dofile('telnet.lua')

test = tmr.create()
test:register(10000, tmr.ALARM_AUTO, function()
  local sec, usec, rate = rtctime.get()
  print(sec)
end)
