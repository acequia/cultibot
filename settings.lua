MINS  = 60 -- seconds
HOURS = 60 * MINS
DAYS  = 24 * HOURS
WEEKS =  7 * DAYS

conf = {
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
  i2c = {
    id  = 0,
    sda = 3, -- GPIO 0
    scl = 4, -- GPIO 2
  },
  wifi = {
    ssid = 'La Patria es el otro',
    pwd  = 'mochila propulsora',
  },
  time = {
    timezone = -3 * HOURS,
    start    = 1490199534, -- 2017/03/22 13:18 GMT-03:00
  },
  vegetative = {
    var    = 'time',
    each   =  1 * DAYS,
    at     = 18 * HOURS,
    run    = 18 * HOURS,
  },
  flowering = {
    var    = 'time',
    each   =  1 * DAYS,
    at     =  0 * HOURS,
    run    = 12 * HOURS,
  },
  irrigation = {
    var    = 'time',
    each   =  1 * DAYS,
    at     = 18 * HOURS,
    run    =  5 * MINS,
  },
  ventilation = {
    var    = 'temperature',
    set    = 24,
    hist   =  2,
    effect = 'decrease',
  },
  circuits = {
    {module = 'vegetative',  mode = 'auto',   state = false, output = 5},
    {module = 'irrigation',  mode = 'manual', state = false, output = 6},
    {module = 'ventilation', mode = 'auto',   state = false, output = 7},
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
