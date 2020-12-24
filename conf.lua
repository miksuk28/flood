--window dims
SCR_W=1000
SCR_H=1000

function love.conf(t)
	--Screen conf
	io.stdout:setvbuf("no")
	t.window.title = "Flood"
	t.window.height = SCR_H
	t.window.width = SCR_W
end