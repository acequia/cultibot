routes['GET /'] = function(socket, params)
  local function list_ap(t) -- (BSSID : SSID, RSSI, auth mode, channel)
    redes = {}

    for bssid, v in pairs(t) do
      local ssid, rssi, auth_mode, channel =
        string.match(v, '([^,]+),([^,]+),([^,]+),([^,]*)')
      table.insert(redes, {bssid=bssid, ssid=ssid, rssi=rssi})
    end

    table.sort(redes, function(a, b) return a.rssi < b.rssi end)

    status_map = {
      [0]='disponible',
      [1]='conectando...',
      [2]='contraseña inválida',
      [3]='red no encontrada',
      [4]='fallo',
      [5]='conectado'
    }

    status = status_map[wifi.sta.status()]

    render(socket, 'index.html')
  end

  wifi.sta.getap(1, list_ap)
end

routes['POST /'] = function(socket, params)
  wifi.sta.config(params)

  --print(params['red'], params['contraseña'], wifi.sta.getip())
  routes['GET /'](socket, params)
end
