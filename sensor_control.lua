function sensor_condition(module)
  local measure = sensors[module.var]()

  if type(measure) ~= 'number' then return module.status end

  local high    = module.set + module.hist / 2
  local low     = module.set - module.hist / 2

  -- Sensor control features a simple hysteresis cycle for two use cases:
  --
  -- The first one for ventilation, where an actuator must be activated
  -- when the temperature rises above the high threshold level and deactivated
  -- when the temperature falls below the low threshold level.
  --
  -- The second one is the inverse one, for heating. The actuator must go off
  -- above the high threshold and go on below the low threshold.

  if module.effect == 'decrease' then
    if module.status then -- on
      if measure < low  then module.status = false end
    else -- off
      if measure > high then module.status = true  end
    end
  else -- effect == 'increase'
    if module.status then -- on
      if measure > high then module.status = false end
    else -- off
      if measure < low  then module.status = true  end
    end
  end

  return module.status
end
