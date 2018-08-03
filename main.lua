Ball = require 'ball'
Platform = require 'platform'
Goal = require 'goal'

function love.load()
    local width, height, flags = love.window.getMode()
    screenWidth = width
    screenHeight = height

    reset()
end

function reset()
    platforms = {}
    world = love.physics.newWorld(0, 500, false)

    math.randomseed(os.time())
    for i=1, 10 do
        platforms[i] = Platform:new(world, math.random() * screenWidth, math.random() * screenHeight, false)
    end

    Ball:reset(world)
    Goal:reset(world, 300, 300)

    love.graphics.setLineWidth(5)
end

function love.draw()
    love.graphics.setColor(0, 1, 0, 1)

    love.graphics.push()
    Goal:draw()
    love.graphics.pop()

    love.graphics.setColor(1, 1, 1, 1)

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
    world:update(dt)
    Ball:update(dt, platforms)

    if Ball:needsReset(screenHeight) then
        reset()
    end
end