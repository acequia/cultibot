wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
  sntp.sync('pool.ntp.org', nil, nil, 'autorepeat')
end)
