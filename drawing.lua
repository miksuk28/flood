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
	for y = 1, #colors do
		if colors[y][1] == tile then
			rgb_color(colors[y][2], colors[y][3], colors[y][4])
		end
	end
end
