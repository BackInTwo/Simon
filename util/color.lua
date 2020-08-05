local class = require "lib.lua-oop"

require "util/math/util"

Color = class "Color"

Color.static.fromBackgroundColor = function() -- LOVE2D framework

    local r, g, b, a = love.graphics.getBackgroundColor()

    return Color:new(r*255, g*255, b*255, a*255)

end

Color.static.fromRandom = function() -- LOVE2D framework

    return Color:new(math.random()*255, math.random()*255, math.random()*255, math.random()*255)

end

function Color:constructor(r, g, b, a)

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

    self.isDecimal = false

    self:clip()

end

function Color:invert()

    if self.isDecimal then
      return self:invertDecimal()
    end

    self.r = 255 - self.r

    self.g = 255 - self.g

    self.b = 255 - self.b

    return self:clip()

end


function Color:invertDecimal()

    if not self.isDecimal then
      return self:invert()
    end

    self.r = 1 - self.r

    self.g = 1 - self.g

    self.b = 1 - self.b

    return self:clip()

end

function Color:plus(other)

    local o = other:clone()

    if self.isDecimal and not o.isDecimal then
        o:toDecimal()
    elseif not self.isDecimal and o.isDecimal then
        o:toNormal()
    end

    self.r = self.r + o.r
    self.g = self.g + o.g
    self.b = self.b + o.b
    self.a = self.a + o.a

    self:clip()

end

function Color:minus(other)

    local o = other:clone()

    if self.isDecimal and not o.isDecimal then
        o:toDecimal()
    elseif not self.isDecimal and o.isDecimal then
        o:toNormal()
    end

    self.r = self.r - o.r
    self.g = self.g - o.g
    self.b = self.b - o.b
    self.a = self.a - o.a

    self:clip()

end

function Color:multiply(other)

    local o = other:clone()

    if self.isDecimal and not o.isDecimal then
        o:toDecimal()
    elseif not self.isDecimal and o.isDecimal then
        o:toNormal()
    end

    self.r = self.r * o.r
    self.g = self.g * o.g
    self.b = self.b * o.b
    self.a = self.a * o.a

    self:clip()

end

function Color:divide(other)

    local o = other:clone()

    if self.isDecimal and not o.isDecimal then
        o:toDecimal()
    elseif not self.isDecimal and o.isDecimal then
        o:toNormal()
    end

    self.r = self.r / o.r
    self.g = self.g / o.g
    self.b = self.b / o.b
    self.a = self.a / o.a

    self:clip()

end

function Color:clip()

    if self.isDecimal then
        self.r = clip(self.r, 0, 1)
        self.g = clip(self.g, 0, 1)
        self.b = clip(self.b, 0, 1)
        self.a = clip(self.a, 0, 1)
    else
        self.r = clip(self.r, 0, 255)
        self.g = clip(self.g, 0, 255)
        self.b = clip(self.b, 0, 255)
        self.a = clip(self.a, 0, 255)
    end

    return self

end

function Color:clone()

    local newColor = Color:new(self.r, self.g, self.b, self.a)
    newColor.isDecimal = self.isDecimal

    return newColor

end

function Color:toDecimal()

    if self.isDecimal then
      return self
    end

    self.r = self.r / 255

    self.g = self.g / 255

    self.b = self.b / 255

    self.isDecimal = true

    return self:clip()

end

function Color:toNormal()

    if not self.isDecimal then
      return self
    end

    self.r = self.r * 255

    self.g = self.g * 255

    self.b = self.b * 255

    self.isDecimal = false

    return self:clip()

end

function Color:toArray()

    return { self.r, self.g, self.b, self.a }

end

function Color:toDecimalArray()

    if self.isDecimal then
      return self:toArray()
    end

    return { self.r / 255, self.g / 255, self.b / 255, self.a / 255 }

end

function Color:toString()

    local str = "(" .. tostring(self.r) .. ", " .. tostring(self.g) .. ", " .. tostring(self.b) .. ", " .. tostring(self.a) .. ")"

    if self.isDecimal then
        return "DecimalColor" .. str
    else
        return "Color" .. str
    end

end

return Color
