function relay_logic()
  sensors.update()

  for _, circuit in pairs(conf.circuits) do
    local module = conf[circuit.module]

    if circuit.mode == 'auto' then
      if module.var == 'time' then -- it is a time-controlled module
        circuit.state = time_condition(circuit)
      else -- it is a sensor-controlled module
        circuit.state = sensor_condition(circuit)
      end
    end
  end

  io.update()
end

-- automatically repeating alarm every 1000 milliseconds
loop = tmr.create()
loop:register(1000, tmr.ALARM_AUTO, relay_logic)
loop:start()
