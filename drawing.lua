function draw_field()
	space_x = x_start
	space_y = y_start

	for i = 1, field_h do
		y = i
		for i = 1, field_w do
			x = i
			get_block_color(x, y)
			love.graphics.rectangle("fill", space_x, space_y, cell_dim, cell_dim)
			space_x = x_start + (cell_dim + cell_space) * i
		end
		space_y = y_start + (cell_dim + cell_space) * i
		space_x = x_start
	end
end

function get_block_color(x, y)
	tile = field[y][x]
	--print("Coloring tile: " .. x .. ", " .. y)
	if tile == "red" then
		rgb_color(255, 0, 0)
	elseif tile == "orange" then
		rgb_color(255, 165, 0)
	elseif tile == "yellow" then
		rgb_color(255, 255 ,0)
	elseif tile == "green" then
		rgb_color(0, 255, 0)
	elseif tile == "blue" then
		rgb_color(0, 0, 255)
	elseif tile == "purple" then
		rgb_color(255, 0, 255)
	end
end
