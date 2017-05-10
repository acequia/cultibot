dofile('sensor_control.lua')

sensors = {}
sensors.temperature = function() return t end

-- Ventilation (case 1)

ventilation = {
  var    = 'temperature',
  set    = 24,
  hist   =  2, -- histeresis
  effect = 'decrease',
}


t = 'error'
assert(not sensor_condition(ventilation) )

t = 24
assert(not sensor_condition(ventilation) )
t = 25
assert(not sensor_condition(ventilation) )
t = 26
assert(    sensor_condition(ventilation) )
t = 25
assert(    sensor_condition(ventilation) )
t = 24
assert(    sensor_condition(ventilation) )
t = 23
assert(    sensor_condition(ventilation) )
t = 22
assert(not sensor_condition(ventilation) )
t = 23
assert(not sensor_condition(ventilation) )
t = 24
assert(not sensor_condition(ventilation) )

-- Heating (case 2)

heating = {
  var    = 'temperature',
  set    = 24,
  hist   =  2, -- histeresis
  effect = 'increase',
}

t = 24
assert(not sensor_condition(heating) )
t = 25
assert(not sensor_condition(heating) )
t = 26
assert(not sensor_condition(heating) )
t = 25
assert(not sensor_condition(heating) )
t = 24
assert(not sensor_condition(heating) )
t = 23
assert(not sensor_condition(heating) )
t = 22
assert(    sensor_condition(heating) )
t = 23
assert(    sensor_condition(heating) )
t = 24
assert(    sensor_condition(heating) )
