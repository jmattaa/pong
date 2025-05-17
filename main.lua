local Paddle = require("paddle")

---@type Paddle
local player

---@type Paddle
local opp

function love.load()
    player = Paddle.new(0, 0)
    player.y = (love.graphics.getHeight() / 2) - (player.h / 2)

    opp = Paddle.new(0, 0)
    opp.x = love.graphics.getWidth() - opp.w
    opp.y = (love.graphics.getHeight() / 2) - (opp.h / 2)
end

function love.update(dt)
    player:update(dt)
    opp:update(dt)
end

function love.draw()
    player:draw()
    opp:draw()
end
