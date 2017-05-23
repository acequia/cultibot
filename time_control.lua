function time_condition(module)
  if sensors.time < 0 then return false end

  local base  = module.each -- time block to repeat in seconds
  local now   = sensors.time % base + module.offset -- seconds from midnight
  local start = module.at -- from 00:00:00 to 23:59:59
  local stop  = start + module.run -- must not last longer than the time block

  -- First group corresponds to a task starting and ending the same day,
  -- the second one manages the case of the task going through midnight,
  -- ending the next day.
  --
  -- First  case:
  --                00:00 __|°°°°°°|____ 23:59
  -- Second case:
  --                00:00 °°°°|______|°° 23:59
  --
  --                ° means ON     _ means OFF
  return (start <= now and now < stop) or (now < stop - base)
end
