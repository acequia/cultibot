id  = 0
sda = 3 -- GPIO 0
scl = 4 -- GPIO 2

sensor = 0x5C -- 7bit address
reles  = 0x20

uart.setup(0,115200,8,0,1,1)
i2c.setup(id, sda, scl, i2c.SLOW)

tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()
  sntp.sync('pool.ntp.org')
end)

--dofile('sensor.lua')
--dofile('reles.lua')
--dofile('telnet.lua')

-- Enable network configuration within time window
dofile('config.lua')
