Ball = require 'ball'
Platform = require 'platform'

function love.load()
    local width, height, flags = love.window.getMode()
    screenWidth = width
    screenHeight = height
    platforms = {}
    world = love.physics.newWorld(0, 2, false)

    math.randomseed(os.time())
    for i=1, 10 do
        platforms[i] = Platform:new(math.random() * screenWidth, math.random() * screenHeight)
    end

    Ball:reset(world)

    love.graphics.setLineWidth(5)
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    local centerX = screenWidth * 0.5
    local centerY = screenHeight * 0.5
    love.graphics.print(tostring(3), centerX, centerY)

    love.graphics.push()
    Ball:draw()
    love.graphics.pop()

    for k, platform in pairs(platforms) do
        love.graphics.push()
        platform:draw()
        love.graphics.pop()
    end
end

function love.keypressed(key, scancode, isrepeat)
    Ball:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    Ball:keyreleased(key, scancode)
end

function love.update(dt)
    world.update(dt)
    Ball:update(dt, platforms)
end