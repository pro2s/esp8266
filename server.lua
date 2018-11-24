-- a simple HTTP server
srv = net.createServer(net.TCP)
pin = "OFF"
gpio.mode(0, gpio.OUTPUT)
gpio.write(0, gpio.HIGH)
srv:listen(80, function(conn)
	conn:on("receive", function(sck, request)
    print(request)
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if (method == nil) then
      _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    path = string.lower(path)
    empty = false
    if (path == "/on") then
      gpio.write(0, gpio.LOW)
      pin = "ON"
    elseif (path == "/off") then
      gpio.write(0, gpio.HIGH)
      pin = "OFF"
    elseif (path == "/favicon.ico") then
      sck:send("HTTP/1.0 301 Moved Permanently\r\nLocation: \r\n\r\n" .. response)
    else
      empty = true
    end
    
    if (empty) then
      response = ""
    else
      response = "<h1> Hello, NodeMCU is " .. pin .. "</h1>"
    end
    
		sck:send("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n" .. response)
    
	end)
	conn:on("sent", function(sck) sck:close() end)
end)