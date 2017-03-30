MINS  = 60
HOURS = 60 * MINS
DAYS  = 24 * HOURS

settings = {
  timezone = -3 * HOURS,
  start    = 1490199534, -- 2017/03/22 13:18
  lighting = {
    --repeat = 'daily',
    each =  1 * DAYS,
    at   = 18 * HOURS + 30 * MINS,
    run  = 12 * HOURS
  },
  watering = {
    --repeat = 'daily',
    each =  3 * DAYS,
    at   = 12 * HOURS,
    run  =  5 * MINS
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
