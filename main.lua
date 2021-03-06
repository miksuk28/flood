math.randomseed(os.time())

function love.load()
	require "updates"
	require "drawing"
	colors = {"red", "orange", "yellow", "green", "blue", "purple"}
	field = {}
	flood_map = {}
	field_w = 12
	field_h = 12
	cell_space = 0
	cell_dim = 50
	x_start = (SCR_W / 2) - (((cell_dim + cell_space) * field_w) / 2)
	y_start = (SCR_H / 2) - (((cell_dim + cell_space) * field_h) / 2)
	moves = 0
	generate_field()
	generate_flood_map()

	won_game = false
	current_color = field[1][1]
end

function love.update(dt)
	mouse_posX = love.mouse.getX()
	mouse_posY = love.mouse.getY()
	mouseX = math.floor(((mouse_posX - x_start) / cell_dim) + 1)
	mouseY = math.floor(((mouse_posY - y_start) / cell_dim) + 1)

	if not won_game then
		update_flood_map()
		check_win()
	end
end

function love.draw()
	love.graphics.setBackgroundColor(1, 1, 1)
	draw_field()
	rgb_color(0,0,0)
	love.graphics.print("X: " .. mouseX, 0, 0)
	love.graphics.print("Y: " .. mouseY, 0, 10)
	love.graphics.print("Moves: " .. moves, 0, 20)
end