Goal = {
    body = nil,
    radius = 50,
}

function Goal:reset(world, x, y)
    self.body = love.physics.newBody(world, x, y, "kinematic")
    shape = love.physics.newCircleShape(self.radius)
    fixture = love.physics.newFixture(self.body, shape)
end

function Goal:draw()
    love.graphics.translate(self.body:getX(), self.body:getY())
    love.graphics.scale(1, 1)
    love.graphics.circle("fill", 0, 0, self.radius)
end

return Goal