math.randomseed(os.time())

function love.load()
	require "updates"
	require "drawing"
	require "colors"
	field = {}
	flood_map = {}
	field_w = 12
	field_h = 12
	cell_space = 0
	cell_dim = 50
	x_start = (SCR_W / 2) - (((cell_dim + cell_space) * field_w) / 2)
	y_start = (SCR_H / 2) - (((cell_dim + cell_space) * field_h) / 2)
	moves = 0
	color_ammount = 6
	generate_field()
	generate_flood_map()

	won_game = false
	current_color = field[1][1]
end

function love.update(dt)
	fps = love.timer.getFPS()
	mouseX = math.floor(((love.mouse.getX() - x_start) / cell_dim) + 1)
	mouseY = math.floor(((love.mouse.getY() - y_start) / cell_dim) + 1)

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