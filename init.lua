wifi.setmode(wifi.STATION)
wifi.sta.config{ssid="Velcom-68", pwd="85425392"}
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
	if wifi.sta.getip() == nil then
		print("IP unavaiable, Waiting...")
	else
		tmr.stop(1)
		print("ESP8266 mode is: " .. wifi.getmode())
		print("The module MAC address is: " .. wifi.ap.getmac())
		print("Config done, IP is "..wifi.sta.getip())
		dofile ("server.lua")
	end
end)