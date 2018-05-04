sensors = {}

sensors.update = function()
  sensors.humidity, sensors.temperature = humidity_temperature()

  -- Time is in seconds since the epoch, which is UTC so we make
  -- a timezone correction in seconds.
  sensors.time = rtctime.get() + conf.time.timezone
end

sensors.update()
