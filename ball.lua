---@class Ball
---@field x number
---@field y number
---@field speed number
---@field size number
---@field _startx number
---@field _starty number
---@field dir {x: number, y: number}
Ball = {}
Ball.__index = Ball

local MAX_SPEED = 840

---Creates a new ball object
---@param x number
---@param y number
---@return Ball
function Ball.new(x, y)
    ---@type Ball
    local self = setmetatable({}, Ball)
    self.x = x
    self.y = y
    self.speed = 300
    self.size = 10
    self.dir = { x = 1, y = 1 }
    self._startx = x
    self._starty = y
    return self
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.size)
end

function Ball:reset()
    self.x = self._startx
    self.y = self._starty
    self.dir = {
        x = math.random() > 0.5 and 1 or -1,
        y = math.random() > 0.5 and 1 or -1
    }
end

---@param dt number
---@param player Paddle
---@param opp Paddle
function Ball:update(dt, player, opp)
    -- basically clamping the dir to -1 and 1
    self.dir.x = math.min(math.max(self.dir.x, -1), 1)
    self.dir.y = math.min(math.max(self.dir.y, -1), 1)

    self.x = self.x + self.speed * self.dir.x * dt
    self.y = self.y + self.speed * self.dir.y * dt

    -- so speed go brrrrr
    self.speed = self.speed + (10 * dt)
    self.speed = math.min(self.speed, MAX_SPEED)

    local w, h = love.graphics.getDimensions()

    self.dir.y = self.y <= 0 and 1 or
        self.y >= h and -1 or
        self.dir.y


    ---@param paddle Paddle
    local function handle_paddle_collision(paddle)
        self.dir.x = self.dir.x * -1
        self.dir.y = (self.y < paddle.y + paddle.h / 2) and -1 or 1
    end

    if self:collides(player) then
        handle_paddle_collision(player)
    elseif self:collides(opp) then
        handle_paddle_collision(opp)
    end

    if self.x < -2 then
        opp.score = opp.score + 1
        self:reset()
    elseif self.x > w + 2 then
        player.score = player.score + 1
        self:reset()
    end
end

--- the other should be like a vec2 or somth but we don do that shi
--- or yk what it could be a game object thingy that has x and y and w and h
---@param other Paddle
function Ball:collides(other)
    return self.x < other.x + other.w and
        self.x + self.size > other.x and
        self.y < other.y + other.h and
        self.y + self.size > other.y
end

return Ball
