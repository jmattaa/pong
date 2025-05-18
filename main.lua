local Paddle = require("paddle")
local Ball = require("ball")

---@type Paddle
local player
---@type Paddle
local opp
---@type Ball
local ball

local paused = false

function love.load()
    local w, h = love.graphics.getDimensions()

    player = Paddle.new(0, 0)
    player.y = (h / 2) - (player.h / 2)

    opp = Paddle.new(0, 0)
    opp.x = w - opp.w
    opp.y = (h / 2) - (opp.h / 2)

    ball = Ball.new(w / 2, h / 2)
end

function love.resize(w, _)
    opp.x = w - opp.w
end

function love.keypressed(key)
    if key == "space" or key == "p" then
        paused = not paused
    end
end

function love.update(dt)
    if paused then
        return
    end

    player:update(dt)
    opp:follow(dt, ball)
    ball:update(dt, player, opp)
end

function love.draw()
    player:drawscore()
    opp:drawscore()

    if paused then
        love.graphics.printf(
            "PAUSED",
            0,
            love.graphics.getHeight() / 2,
            love.graphics.getWidth(),
            "center"
        )
        return
    end

    player:draw()
    opp:draw()
    ball:draw()
end
