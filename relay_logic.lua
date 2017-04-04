function relay_logic()
  for i,relay in ipairs(settings.relays) do
    local module    = settings[relay.module]
    local condition = false

    if     module.mode == 'auto' and module.each   then
      condition = time_condition(module, now())
    elseif module.mode == 'auto' and module.sensor then
      condition = sensor_condition(module)
    elseif module.mode == 'on' then
      condition = true
    end

    if condition then on(i) else off(i) end

  end
end

-- automatically repeating alarm every 500 milliseconds
loop = tmr.create()
loop:register(500, tmr.ALARM_AUTO, relay_logic)
loop:start()
