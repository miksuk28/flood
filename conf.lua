--window dims
SCR_W=700
SCR_H=700

function love.conf(t)
	--Screen conf
	io.stdout:setvbuf("no")
	t.window.title = "Flood"
	t.window.height = SCR_H
	t.window.width = SCR_W
	t.modules.joystick = false

	-- CHANGE 
	t.window.icon = "troll.png"
end