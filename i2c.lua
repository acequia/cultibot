id  = 0
sda = 3 -- GPIO 0
scl = 4 -- GPIO 2

-- 7bit addresses
am2320  = 0x5C -- humidity and temperature sensor
pcf8574 = 0x20 -- I/O expander

i2c.setup(id, sda, scl, i2c.SLOW)

io       = {}
io.map   = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80}
io.state = 0xFF -- off

io.write = function(value)
  i2c.start(id)
  i2c.address(id, pcf8574, i2c.TRANSMITTER)
  i2c.write(id, value)
  i2c.stop(id)
end

io.read = function()
  i2c.start(id)
  i2c.address(id, pcf8574, i2c.RECEIVER)
  local data = i2c.read(id, 1)  -- reads one byte
  i2c.stop(id)
  return data
end

io.on = function(output)
  io.state = bit.clear(io.state, output)
  io.write(io.state)
end

io.off = function(output)
  io.state = bit.set(io.state, output)
  io.write(io.state)
end

io.set = function(output, state)
  if state then -- ON
    io.state = bit.clear(io.state, output)
  else -- OFF
    io.state = bit.set(io.state, output)
  end
end

io.update = function()
  io.write(io.state)
end
