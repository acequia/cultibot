wifi.sta.config(settings.wifi)

-- manages the time window during which bot configuration is posible


-- configure AP with default SSID, password and IPs
--wifi.ap.config({
  --ssid = 'Cultibot ' .. node.chipid(),
  --pwd  = '12345678'
--})

--wifi.ap.setip({
  --ip      = '10.0.0.1',
  --netmask = '255.255.255.0',
  --gateway = '10.0.0.1'
--})

-- start WiFi module as both AP and client
-- wifi.setmode(wifi.STATIONAP)
--wifi.setmode(wifi.STATION)

-- wait 5 minutes from boot, and stop related processes
config_window = tmr.create()

config_window:register(300000, tmr.ALARM_SINGLE, function()
  -- set WiFi on client mode only
  wifi.setmode(wifi.STATION)
  -- stop the webserver
  http_server:close()
end)

-- config_window:start()
