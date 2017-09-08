wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
  sntp.sync('pool.ntp.org',
            function(sec, usec, server, info)
              print('Synced', sec, usec, server)
            end,
            function()
              print('Sync failed!')
            end,
            'autorepeat')

  m:connect('conejo.mauriciopasquier.com.ar')
end)
