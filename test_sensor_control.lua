dofile('sensor_control.lua')

sensors = {}

-- Ventilation (case 1)

ventilation = {
  var    = 'temperature',
  set    = 24,
  hist   =  2, -- histeresis
  effect = 'decrease',
}


sensors.temperature = 'error'
assert(not sensor_condition(ventilation) )

sensors.temperature = 24
assert(not sensor_condition(ventilation) )

sensors.temperature = 25
assert(not sensor_condition(ventilation) )

sensors.temperature = 26
assert(    sensor_condition(ventilation) )

sensors.temperature = 25
assert(    sensor_condition(ventilation) )

sensors.temperature = 24
assert(    sensor_condition(ventilation) )

sensors.temperature = 23
assert(    sensor_condition(ventilation) )

sensors.temperature = 22
assert(not sensor_condition(ventilation) )

sensors.temperature = 23
assert(not sensor_condition(ventilation) )

sensors.temperature = 24
assert(not sensor_condition(ventilation) )

-- Heating (case 2)

heating = {
  var    = 'temperature',
  set    = 24,
  hist   =  2, -- histeresis
  effect = 'increase',
}

sensors.temperature = 24
assert(not sensor_condition(heating) )

sensors.temperature = 25
assert(not sensor_condition(heating) )

sensors.temperature = 26
assert(not sensor_condition(heating) )

sensors.temperature = 25
assert(not sensor_condition(heating) )

sensors.temperature = 24
assert(not sensor_condition(heating) )

sensors.temperature = 23
assert(not sensor_condition(heating) )

sensors.temperature = 22
assert(    sensor_condition(heating) )

sensors.temperature = 23
assert(    sensor_condition(heating) )

sensors.temperature = 24
assert(    sensor_condition(heating) )
