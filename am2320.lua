-- Based on a file written by Álvaro Valdebenito.
-- More info at https://github.com/avaldebe/AQmon.

function crc(c)
  local s = 0xFFFF
  local l, i

  for l = 1, #c do
    s = bit.bxor(s, c:byte(l))

    for i = 1, 8 do
      if bit.band(s, 1) ~= 0 then
        s = bit.rshift(s, 1)
        s = bit.bxor(s, 0xA001)
      else
        s = bit.rshift(s, 1)
      end
    end
  end

  return s
end

function sensor_read()
  -- Wakeup.
  i2c.start(id)
  i2c.address(id, sensor, i2c.TRANSMITTER)
  tmr.delay(800)
  i2c.stop(id)

  -- Request 0x00 to 0x03.
  i2c.start(id)
  i2c.address(id, sensor, i2c.TRANSMITTER)
  -- Write 3 bytes: function code,
  -- initial address, data length.
  i2c.write(id, 0x03, 0x00, 0x04)
  i2c.stop(id)
  tmr.delay(1500)

  -- Read 0x00 to 0x03.
  i2c.start(id)
  i2c.address(id, sensor, i2c.RECEIVER)
  tmr.delay(30)
  -- Read 8 bytes in total: function code, data length,
  -- humidity MSB, humidity LSB, temperature MSB,
  -- temperature LSB, checksum LSB, checksum MSB.
  local c = i2c.read(id, 8)
  i2c.stop(id)

  local h, t

  if crc(c:sub(1, 6)) == c:byte(8) * 256 + c:byte(7) then
    h = c:byte(3) * 256 + c:byte(4)
    t = c:byte(5) * 256 + c:byte(6)

    -- Handle negative temperature.
    if bit.isset(t, 15) then
      t = -bit.band(t, 0x7FFF)
    end

    h = h / 10
    t = t / 10
  else
    h = 'error'
    t = 'error'
  end

  return h, t
end
