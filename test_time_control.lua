dofile('time_control.lua')

MINS  = 60
HOURS = 60 * MINS
DAYS  = 24 * HOURS

wednesday = {
  midnight = 1490756400, -- 2017/03/29 00:00 GMT-03:00
  morning  = 1490770800, -- 2017/03/29 04:00 GMT-03:00
  noon     = 1490799600, -- 2017/03/29 12:00 GMT-03:00
  evening  = 1490828400, -- 2017/03/29 20:00 GMT-03:00
}

thursday = {
  midnight = 1490842800, -- 2017/03/30 00:00 GMT-03:00
  morning  = 1490857200, -- 2017/03/30 04:00 GMT-03:00
  noon     = 1490886000, -- 2017/03/30 12:00 GMT-03:00
  evening  = 1490914800, -- 2017/03/30 20:00 GMT-03:00
}

saturday = {
  midnight = 1491015600, -- 2017/04/01 00:00 GMT-03:00
  morning  = 1491030000, -- 2017/04/01 04:00 GMT-03:00
  noon     = 1491058800, -- 2017/04/01 12:00 GMT-03:00
  evening  = 1491087600, -- 2017/04/01 20:00 GMT-03:00
}

-- Lighting (case 1)

lighting = {
  each   =  1 * DAYS,  -- daily
  at     = 12 * HOURS, -- start 12:00
  run    = 12 * HOURS, -- stop  00:00
  offset =  0,
}

assert(not time_condition(lighting, wednesday.morning) )
assert(    time_condition(lighting, wednesday.noon)    )
assert(    time_condition(lighting, wednesday.evening) )
assert(not time_condition(lighting, thursday.midnight) )
assert(    time_condition(lighting, thursday.noon)     )

-- Lighting (case 2)

lighting = {
  each   =  1 * DAYS,  -- daily
  at     = 20 * HOURS, -- start 20:00
  run    = 12 * HOURS, -- stop  08:00
  offset =  0,
}

assert(    time_condition(lighting, wednesday.morning) )
assert(not time_condition(lighting, wednesday.noon)    )
assert(    time_condition(lighting, wednesday.evening) )
assert(    time_condition(lighting, thursday.midnight) )
assert(not time_condition(lighting, thursday.noon)     )

-- Irrigation

irrigation = {
  each   =  3 * DAYS,  -- each 3 days
  at     = 12 * HOURS, -- start 12:00
  run    = 15 * MINS,  -- stop  12:15
  offset = -5 * DAYS,
}

assert(    time_condition(irrigation, wednesday.noon) )
assert(not time_condition(irrigation, thursday.noon)  )
assert(    time_condition(irrigation, saturday.noon)  )
