math.randomseed(os.time())

function love.load()
	require "functions"
	colors = {"red", "orange", "yellow", "green", "blue", "purple"}
	field = {}
	field_w = 12
	field_h = 12
	cell_space = 0
	cell_dim = 50
	x_start = (SCR_W / 2) - (((cell_dim + cell_space) * field_w) / 2)
	y_start = (SCR_H / 2) - (((cell_dim + cell_space) * field_h) / 2)
	generate_field()
end

function love.update(dt)

end

function love.draw()
	love.graphics.setBackgroundColor(1, 1, 1)
	draw_field()
end