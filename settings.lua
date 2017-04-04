MINS  = 60
HOURS = 60 * MINS
DAYS  = 24 * HOURS
WEEKS =  7 * DAYS

settings = {
  timezone = -3 * HOURS,
  start    = 1490199534, -- 2017/03/22 13:18 GMT-03:00
  lighting = {
    each   =  1 * DAYS,
    at     = 18 * HOURS + 30 * MINS,
    run    = 12 * HOURS,
    offset =  0,
  },
  irrigation = {
    each   =  3 * DAYS,
    at     = 12 * HOURS,
    run    =  5 * MINS,
    offset =  0,
  },
  ventilation = {
    sensor = 'temperature',
    on     = 26,
    off    = 22,
  },
  relays = {
    {module = 'lighting',    mode = 'auto'},
    {module = 'irrigation',  mode = 'auto'},
    {module = 'ventilation', mode = 'auto'},
  }
}

-- mode
  -- manual
  -- semi-auto
  -- auto

-- repeat
  -- every day
    -- each N days
  -- every week
    --  each N weeks
    --  day(s) of the week
  -- every month
    -- each N months
    -- day of the month
