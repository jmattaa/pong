---@class Paddle
---@field x number
---@field y number
---@field w number
---@field h number
---@field speed number
Paddle = {}
Paddle.__index = Paddle

---Creates a new paddle object
---@param x number
---@param y number
---@return Paddle
function Paddle.new(x, y)
    ---@type Paddle
    local self = setmetatable({}, Paddle)
    self.x = x
    self.y = y
    self.w = 10
    self.h = 100
    self.speed = 400
    return self
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

---@param dt number
---@param opp? boolean
function Paddle:update(dt, opp)
    if opp then goto checkedge end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end

    ::checkedge::
    local h = love.graphics.getHeight()
    self.y = math.min(math.max(self.y, 0), h - self.h)
end

---@param dt number
---@param ball Ball
function Paddle:follow(dt, ball)
    if ball.y > self.y + self.h / 2 then
        self.y = self.y + self.speed * dt
    end
    if ball.y < self.y + self.h / 2 then
        self.y = self.y - self.speed * dt
    end
    self:update(dt, true)
end

return Paddle
