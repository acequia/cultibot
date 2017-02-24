-- Manages the time window during which bot configuration is posible.

-- Configure AP with default SSID, password and IPs
wifi.ap.config({
  ssid = "CultiBot AP",
  pwd = "12345678"
})

wifi.ap.setip({
  ip = "10.0.0.1",
  netmask = "255.255.255.0",
  gateway = "10.0.0.1"
})

-- Start wifi module as both AP and Client
wifi.setmode(wifi.STATIONAP)

-- Wait 10 minutes from boot, and stop related proceses
local config_window = tmr.create()

config_window:register(600000, tmr.ALARM_SINGLE, function(timer)
  -- Set wifi on client mode only
  wifi.setmode(wifi.STATION)
  -- Stop the webserver
  http_server:close()
end)

-- Start web server and alarm
config_window:start()
dofile('http.lua')
