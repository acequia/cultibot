id  = 0
sda = 3 -- GPIO 0
scl = 4 -- GPIO 2

sensor = 0x5C -- 7bit address
reles  = 0x20

uart.setup(0,115200,8,0,1,1)
i2c.setup(id, sda, scl, i2c.SLOW)

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

tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()
  sntp.sync('pool.ntp.org')
end)

dofile('settings.lua')
dofile('am2320.lua')
dofile('sensors.lua')
dofile('actuators.lua')
dofile('time_control.lua')
dofile('sensor_control.lua')
dofile('relay_control.lua')

-- Enable network configuration within time window
--dofile('config.lua')
