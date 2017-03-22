SECS_HOUR = 3600
SECS_MIN  = 60

settings = {
  timezone = -3,
  start  = 1490199534, -- 2017/03/22 13:18
  lighting = {
    repeat = 'daily',
    each   =  1,
    at     =  8 * SECS_HOUR + 30 * SECS_MIN,
    for    = 18 * SECS_HOUR
  },
  watering = {
    repeat = 'daily',
    each   = 3,
    at     = {hour=0},
    for    = {mins=15}
  }
}

-- repeat
  -- every day
    -- each N days
  -- every week
    --  each N weeks
    --  day(s) of the week
  -- every month
    -- each N months
    -- day of the month
