---@class Ball
---@field x number
---@field y number
---@field speed number
---@field size number
---@field dir {x: number, y: number}
Ball = {}
Ball.__index = Ball

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
    return self
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.size)
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

    local h = love.graphics.getHeight()

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
