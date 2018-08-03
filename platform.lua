Platform = {}

function Platform:new(x, y)
    o = {
        x = x,
        y = y,
        length = 200,
    }
    setmetatable(o, self)
    self.__index = self;
    return o
end

function Platform:draw()
    local radius = 100
    love.graphics.scale(1, 1)
    love.graphics.line(self.x - self.length / 2.0, self.y, self.x + self.length / 2.0, self.y)
end

return Platform