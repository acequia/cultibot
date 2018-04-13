MINS  = 60
HOURS = 60 * MINS
DAYS  = 24 * HOURS
WEEKS =  7 * DAYS

settings = {
  mqtt = {
    token = 'P90XTznXr5qUKbGlisrL',
    host  = 'demo.thingsboard.io',
    port  = 1883,
    topics = {
      tele = 'v1/devices/me/telemetry',
      attr = 'v1/devices/me/attributes',
      rpc  = 'v1/devices/me/rpc',
    },
  },
  wifi = {
    ssid = 'Patria si colonia no',
    pwd  = 'mochila propulsora',
  },
  timezone = -3 * HOURS,
  start    = 1490199534, -- 2017/03/22 13:18 GMT-03:00
  lighting = {
    each   =  1 * DAYS,
    at     =  9 * HOURS + 0 * MINS,
    run    = 12 * HOURS,
    offset =  0,
  },
  irrigation = {
    each   =  1 * DAYS,
    at     = 18 * HOURS,
    run    =  5 * MINS,
    offset =  0,
  },
  ventilation = {
    var    = 'temperature',
    set    = 24,
    hist   =  2,
    effect = 'decrease',
  },
  circuits = {
    {module = 'lighting',    mode = 'auto', output=4},
    {module = 'irrigation',  mode = 'auto', output=5},
    {module = 'lighting',    mode = 'auto', output=6},
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
