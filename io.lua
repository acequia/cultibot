io = {}

io.update = function()
  for _, circuit in pairs(conf.circuits) do
    -- Relay outputs are open drain; relays are active
    -- whenever output state is low.
    if circuit.state then -- ON
      gpio.write(circuit.output, gpio.LOW)
    else -- OFF
      gpio.write(circuit.output, gpio.HIGH)
    end
  end
end
