debug = false

--setColor, except it's not stupid
function rgb_color(r, g, b)
	love.graphics.setColor(r/255, g/255, b/255)
end

--quits if esc pressed
function love.keypressed(k)
	if k == "escape" then love.event.quit() end
end

--
function love.mousepressed(x, y, button, isTouch)
	if mouseX <= field_w and mouseX >= 1 and mouseY <= field_h and mouseY >= 1 and flood_map[mouseY][mouseX] ~= 1 then
		if field[mouseY][mouseX] ~= current_color then
			current_color = field[mouseY][mouseX]
			moves = moves + 1
		end
	end
end

function generate_field()
	field = {}
	for i = 1, field_h, 1 do
		local x = {}
		for i = 1, field_w do
			table.insert(x, colors[math.random(1, color_ammount)][1])
			if debug then print(x[i]) end
		end
		table.insert(field, x)
	end
end

function generate_flood_map()
	flood_map = {}
	for i = 1, field_h, 1 do
		local x = {}
		for i = 1, field_w do
			table.insert(x, 0)
			if debug then print(x[i]) end
		end
		table.insert(flood_map, x)
	end
	flood_map[1][1] = 1
	if debug then print(flood_map[1][1]) end
end

function update_flood_map()
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

function check_win()
	local fills = 0
	for y = 1, field_h, 1 do
		for x = 1, field_w, 1 do
			if flood_map[y][x] == 1 then
				fills = fills + 1
			end
		end
	end
	if fills == (field_w * field_h) then
		won_game = true
		love.load()
	end
end

--linear interpolation for rgb fading
function interpolate(startVal, endVal, frames)
	return startVal + ((endVal - startVal) / frames)
end