debug = true

--setColor, except it's not stupid
function rgb_color(r, g, b)
	love.graphics.setColor(r/255, g/255, b/255)
end

--quits if esc pressed
function love.keypressed(k)
	if k == "escape" then
		love.event.quit()
	end
	if debug then
		if k == "r" then generate_field() end
	end
end

function generate_field()
	for i = 1, field_h, 1 do
		local x = {}
		for i = 1, field_w do
			table.insert(x, colors[math.random(#colors)])
			print(x[i])
		end
		table.insert(field, x)
	end
end

function draw_field()
	space_x = x_start
	space_y = y_start

	rgb_color(0,0,0)
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