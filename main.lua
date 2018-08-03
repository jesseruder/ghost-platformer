Ball = require 'ball'
Platform = require 'platform'
Goal = require 'goal'

function love.load()
    local width, height, flags = love.window.getMode()
    screenWidth = width
    screenHeight = height
    level = 2

    reset()
end

function add(x, y, static)
    static = static or false
    platforms[platformCount] = Platform:new(world, x, y, static)
    platformCount = platformCount + 1
end

function reset()
    platforms = {}
    platformCount = 0
    world = love.physics.newWorld(0, 500, false)

    math.randomseed(os.time())

    if level == 0 then
        add(50, 100, true)
        add(250, 200)
        Goal:reset(world, 500, 400)
    elseif level == 1 then
        add(50, 100, true)
        add(250, 200)
        add(450, 300)
        add(650, 250)
        Goal:reset(world, 800, 200)

    elseif level == 2 then
        add(50, 100, true)
        add(400, 300)
        add(50, 500)
        add(400, 750)

        add(400, 400, true)
        add(600, 430, true)
        Goal:reset(world, 550, 650)


        
    else
        Goal:reset(world, 50, 600)
    end

    Ball:reset(world)

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

    if Ball.body:isTouching(Goal.body) then
        level = level + 1
        reset()
    end

    if Ball:needsReset(screenHeight) then
        reset()
    end
end