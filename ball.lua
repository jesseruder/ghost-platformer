Ball = {
    dx = 0,
    dy = 0,
    x = 0,
    y = 0,
    radius = 10,
    gravity = 2,
}

function Ball:reset()
    self.dx = 0
    self.dy = 0
    self.x = 0
    self.y = 0
end

function Ball:draw()
    love.graphics.translate(self.x, self.y)
    love.graphics.scale(1, 1)
    love.graphics.circle("line", 0, 0, self.radius)
end

function Ball:keypressed(key, scancode, isrepeat)
    if key == "space" then
        self.dy = -1
    elseif key == "left" then
        self.dx = -1
    elseif key == "right" then
        self.dx = 1
    end
end

function Ball:keyreleased(key, scancode, isrepeat)
    if key == "space" then
  
    elseif key == "left" then
        if self.dx == -1 then
            self.dx = 0
        end
    elseif key == "right" then
        if self.dx == 1 then
            self.dx = 0
        end
    end
end

function Ball:update(dt, platforms)
    self.x = self.x + (self.dx * dt * 100);
    self.y = self.y + (self.dy * dt * 100);
    self.dy = self.dy + self.gravity * dt;

    for k, platform in pairs(platforms) do
        if platform.intersects
    end
end

return Ball