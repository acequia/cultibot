function relay_logic()
  sensors.update()

  for _, circuit in pairs(settings.circuits) do
    local module = settings[circuit.module]

    if circuit.mode == 'auto' then
      if module.each then -- it is a time-controlled module
        io.set(circuit.output, time_condition(module))
      else -- it is a sensor-controlled module
        io.set(circuit.output, sensor_condition(module))
      end
    elseif circuit.mode == 'on' then -- manual ON
      io.set(circuit.output, true)
    else -- manual OFF
      io.set(circuit.output, false)
    end
  end

  io.update()
end

-- automatically repeating alarm every 1000 milliseconds
loop = tmr.create()
loop:register(1000, tmr.ALARM_AUTO, relay_logic)
loop:start()
