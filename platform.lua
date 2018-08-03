Platform = {}

function Platform:new(world, x, y, isFixed)
    o = {
        x = x,
        y = y,
        length = 200,
        depth = 20,
    }
    setmetatable(o, self)
    self.__index = self;

    o.body = love.physics.newBody(world, x, y, isFixed and "kinematic" or "dynamic")
    o.body:setAngularDamping(0.05)
    rotationShape = love.physics.newPolygonShape(-o.length / 2.0, 0, o.length / 2.0, 0, o.length/ 2.0, o.depth, -o.length / 2.0, o.depth)
    rotationFixture = love.physics.newFixture(o.body, rotationShape)

    fixedBody = love.physics.newBody(world, x, x, "kinematic")
    fixedShape = love.physics.newPolygonShape(-1, -1, 1, -1, 1, 1, -1, 1)
    fixedFixture = love.physics.newFixture(fixedBody, fixedShape)

    love.physics.newRevoluteJoint(o.body, fixedBody, x, y)

    return o
end

function Platform:draw()
    x = math.cos(self.body:getAngle()) * self.length / 2.0
    y = math.sin(self.body:getAngle()) * self.length / 2.0
    depthX = math.cos(self.body:getAngle() + math.pi / 2.0) * self.depth;
    depthY = math.sin(self.body:getAngle() + math.pi / 2.0) * self.depth;

    love.graphics.scale(1, 1)
    love.graphics.polygon('fill', self.x - x, self.y - y, self.x + x, self.y + y, self.x + x + depthX, self.y + y + depthY, self.x - x + depthX, self.y - y + depthY)
end

return Platform