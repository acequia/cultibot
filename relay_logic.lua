function relay_logic()
  local now = now()

  for _, circuit in pairs(settings.circuits) do
    local module    = settings[circuit.module]
    local condition = false

    if circuit.mode == 'auto' then
      if module.each then -- it is a time-controlled module
        condition = time_condition(module, now)
      else -- it is a sensor-controlled module
        condition = sensor_condition(module)
      end
    elseif circuit.mode == 'on' then -- manual ON
      condition = true
    end

    if condition then io.on(circuit.output) else io.off(circuit.output) end
  end
end

-- automatically repeating alarm every 1000 milliseconds
loop = tmr.create()
loop:register(1000, tmr.ALARM_AUTO, relay_logic)
loop:start()
