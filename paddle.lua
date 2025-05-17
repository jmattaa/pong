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
function Paddle:update(dt)
    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end

    if self.y < 0 then self.y = 0 end
    if self.y + self.h > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.h
    end
end

return Paddle
