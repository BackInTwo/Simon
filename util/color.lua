local class = require "lib.lua-oop"

require "util/math"

Color = class "Color"

Color.static.fromBackgroundColor = function() -- LOVE2D framework

    local r, g, b, a = love.graphics.getBackgroundColor()

    return Color:new(r*255, g*255, b*255, a*255)

end

Color.static.fromRandom = function()

    return Color:new(math.random()*255, math.random()*255, math.random()*255, math.random()*255)

end

function Color:constructor(r, g, b, a)

    self:set(r, g, b, a)

    self.isDecimal = false

    self:clip()

end

function Color:invert()

    self.r = 255 - self.r

    self.g = 255 - self.g

    self.b = 255 - self.b

    return self:clip()

end

function Color:plus(other)

    self.r = self.r + o.r
    self.g = self.g + o.g
    self.b = self.b + o.b
    self.a = self.a + o.a

    self:clip()

end

function Color:minus(other)

    self.r = self.r - o.r
    self.g = self.g - o.g
    self.b = self.b - o.b
    self.a = self.a - o.a

    self:clip()

end

function Color:multiply(other)

    self.r = self.r * o.r
    self.g = self.g * o.g
    self.b = self.b * o.b
    self.a = self.a * o.a

    self:clip()

end

function Color:divide(other)

    self.r = self.r / o.r
    self.g = self.g / o.g
    self.b = self.b / o.b
    self.a = self.a / o.a

    self:clip()

end

function Color:clip()

    self.r = clip(self.r, 0, 255)
    self.g = clip(self.g, 0, 255)
    self.b = clip(self.b, 0, 255)
    self.a = clip(self.a, 0, 255)

    return self

end

function Color:set(r, g, b, a)

    if r then
        self.r = r
    else
        self.r = 0
    end

    if g then
        self.g = g
    else
        self.g = 0
    end

    if b then
        self.b = b
    else
        self.b = 0
    end

    if a then
        self.a = a
    else
        self.a = 255
    end

    return self

end

function Color:setFromBackground()

    local r, g, b, a = love.graphics.getBackgroundColor()

    self:set(r*255, g*255, b*255, a*255)

    return self

end

function Color:clone()

    local newColor = Color:new(self.r, self.g, self.b, self.a)

    return newColor

end


function Color:get()

    return { self.r, self.g, self.b, self.a }

end

function Color:getDecimal()

    return { self.r / 255, self.g / 255, self.b / 255, self.a / 255 }

end

function Color:toString()

    local str = "(" .. tostring(self.r) .. ", " .. tostring(self.g) .. ", " .. tostring(self.b) .. ", " .. tostring(self.a) .. ")"

    return "Color" .. str

end

return Color
