function relay_logic()
  local now = now()

  for i, circuit in ipairs(settings.circuits) do
    local module    = settings[circuit.module]
    local condition = false

    if module.mode == 'auto' then
      if module.each then -- it is a time-controlled module
        condition = time_condition(module, now)
      else -- it is a sensor-controlled module
        condition = sensor_condition(module)
      end
    elseif module.mode == 'on' then -- manual ON
      condition = true
    end

    if condition then
      actuators[i]:on()
    else
      actuators[i]:off()
    end
  end
end

-- automatically repeating alarm every 500 milliseconds
loop = tmr.create()
loop:register(500, tmr.ALARM_AUTO, relay_logic)
loop:start()
