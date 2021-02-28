
Player = {
	x = 20,
	y = 530,
	dx = 5
}

Sans = {
	image = love.graphics.newImage("sans.png"),
	x = 0,
	y = 0,
	dx = 2
}

Bullet = {
	x = 0,
	y = 530;
	dy = 2;
	bullets = false
}

function sans()
	love.graphics.draw(Sans.image, Sans.x, Sans.y, 0, 0.1, 0.1)
	Sans.x = Sans.x + Sans.dx
	if Sans.x == 0 or Sans.x == 700 then
		Sans.dx = -Sans.dx
	end
end

function player()
	love.graphics.setColor({255, 0, 0})
	love.graphics.rectangle("fill", Player.x, Player.y, 50, 50)
	love.graphics.setColor({255, 255, 255})
end

function movement()
	if keys["left"] and Player.x ~= 20 then
		Player.x = Player.x - Player.dx
	end
	if keys["right"] and Player.x ~= 730 then
		Player.x = Player.x + Player.dx
	end
end

function shoot()
	love.graphics.rectangle("fill", Bullet.x, Bullet.y, 5, 20)
	Bullet.y = Bullet.y - Bullet.dy
	if Bullet.y < 0 then Bullet.bullets = false end
end

function love.load()
	keys = {}
	distance = 0
	game_over = false
end

function love.update(dt)
	movement()
	if Bullet.bullets == True then
		distance = math.sqrt((Sans.y - Bullet.y)^2 + (Sans.x - Bullet.x)^2)
		print(distance)
	end
end

function love.draw()
	if not game_over then
		sans()
		player()
		if Bullet.bullets == True then shoot() end
	end
	if distance < 100 and Bullet.bullets == True then
		love.graphics.clear()
		love.graphics.print("A winner is you! :)", 400, 300)
		game_over = true
	end
end

function love.keypressed(key)
	keys[key] = true
	if key == "space" and Bullet.bullets == false then
		Bullet.bullets =  True
		Bullet.x = Player.x
		Bullet.y = Player.y
	end
end

function love.keyreleased(key)
	keys[key] = false
end
