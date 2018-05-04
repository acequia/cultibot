wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
  local ip = wifi.sta.getip()
  print('Got IP', ip)

  sntp.sync('pool.ntp.org',
            function(sec, usec, server, info)
              -- print('Synced', sec, usec, server)
            end,
            function()
              print('Sync failed!')
            end,
            'autorepeat')

  mqtt_connect()
end)
