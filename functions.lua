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
		if k == "f" then update_flood_map() end
		--picking colors
		if k == "1" then current_color = "red"; 	moves = moves + 1; --[[update_flood_map()--]] end
		if k == "2" then current_color = "orange"; 	moves = moves + 1; --[[update_flood_map()--]] end
		if k == "3" then current_color = "yellow"; 	moves = moves + 1; --[[update_flood_map()--]] end
		if k == "4" then current_color = "green"; 	moves = moves + 1; --[[update_flood_map()--]] end
		if k == "5" then current_color = "blue"; 	moves = moves + 1; --[[update_flood_map()--]] end
		if k == "6" then current_color = "purple"; 	moves = moves + 1; --[[update_flood_map()--]] end
	end
end

function generate_field()
	field = {}
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

function generate_flood_map()
	flood_map = {}
	for i = 1, field_h, 1 do
		local x = {}
		for i = 1, field_w do
			table.insert(x, 0)
			print(x[i])
		end
		table.insert(flood_map, x)
	end
	flood_map[1][1] = 1
	print(flood_map[1][1])
end

function update_flood_map()
	--[[
	if moves == 0 then
		current_color = field[1][1]
	end --]]

	for y = 1, field_h, 1 do
		for x = 1, field_w, 1 do
			if flood_map[y][x] == 1 then
				if y >= 2 then
					if field[(y-1)][x] == current_color then
						field[(y-1)][x] = current_color
						flood_map[(y-1)][x] = 1
					end
				end
				if y < field_h then
					if field[(y+1)][x] == current_color then
						field[(y+1)][x] = current_color
						flood_map[(y+1)][x] = 1
					end
				end
				if x >= 2 then
					if field[y][(x-1)] == current_color then
						field[y][(x-1)] = current_color
						flood_map[y][(x-1)] = 1
					end
				end
				if x < field_w then
					if field[y][(x+1)] == current_color then
						field[y][(x+1)] = current_color
						flood_map[y][(x+1)] = 1
					end
				end
			end
		end
		table.insert(flood_map, x)
	end
	apply_flood_map(current_color)
	--debugging
	if debug then
		for y = 1, field_h, 1 do
			for x = 1, field_w, 1 do
				io.write(flood_map[y][x] .. " ")
			end
			io.write("\n")
		end
	end
end

function apply_flood_map(current_color)
	for y = 1, field_h, 1 do
		for x = 1, field_w, 1 do
			if flood_map[y][x] == 1 then
				field[y][x] = current_color
			end
		end
	end
end