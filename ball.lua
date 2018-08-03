Ball = {
    radius = 10,
    body = nil,
    dx = 0,
    speed = 200,
    jumpAmount = 150,
    isTouching = false,
    currentPlatform = nil,
}

function Ball:reset(world)
    self.body = love.physics.newBody(world, 50, 50, "dynamic")
    self.body:setLinearDamping(0.5)
    shape = love.physics.newCircleShape(self.radius)
    fixture = love.physics.newFixture(self.body, shape)
end

function Ball:draw()
    love.graphics.translate(self.body:getX(), self.body:getY())
    love.graphics.scale(1, 1)
    love.graphics.circle("line", 0, 0, self.radius)
end

function Ball:keypressed(key, scancode, isrepeat)
    _x, y = self.body:getLinearVelocity()
    if key == "space" and self.isTouching then
        --self.body:applyLinearImpulse(0, -self.jumpAmount)
    elseif key == "left" then
        self.dx = -1
        if self.isTouching then
            angle = self.currentPlatform:getAngle() - math.pi
            self.body:setLinearVelocity(math.cos(angle) * self.speed, math.sin(angle) * self.speed - 0.01)
        else
            --self.body:setLinearVelocity(-self.speed, y)
        end
    elseif key == "right" then
        self.dx = 1
        if self.isTouching then
            angle = self.currentPlatform:getAngle()
            self.body:setLinearVelocity(math.cos(angle) * self.speed, math.sin(angle) * self.speed - 0.01)
        else
            --self.body:setLinearVelocity(self.speed, y)
        end
    end
end

function Ball:keyreleased(key, scancode, isrepeat)
    _x, y = self.body:getLinearVelocity()
    if key == "space" then
 
    elseif key == "left" then
        if self.dx < 0 then
            self.dx = 0
            --self.body:setLinearVelocity(0, y)
        end
    elseif key == "right" then
        if self.dx > 0 then
            self.dx = 0
            --self.body:setLinearVelocity(0, y)
        end
    end
end

function Ball:update(dt, platforms)
    self.isTouching = false
    for k, platform in pairs(platforms) do
        if self.body:isTouching(platform.body) then
            self.isTouching = true
            self.currentPlatform = platform.body
        end
    end
end

function Ball:needsReset(screenHeight)
    if self.body:getY() > screenHeight then
        return true
    end

    return false
end

return Ball