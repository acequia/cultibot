uart.setup(0,115200,8,0,1,1)

tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()
  sntp.sync('pool.ntp.org')
end)

dofile('settings.lua')
dofile('i2c.lua')
dofile('am2320.lua')
dofile('time_control.lua')
dofile('sensor_control.lua')
dofile('relay_control.lua')

-- Enable network configuration within time window
--dofile('config.lua')
