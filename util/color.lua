local class = require "lib/lua-oop"

local Color = class "Color"

Color.static.fromBackgroundColor = function() -- LOVE2D framework

    print("a")

    local r, g, b, a = love.graphics.getBackgroundColor()

    return Color:new(r, g, b, a)

end

function Color:constructor(r, g, b, a)

    if r then
        self.v.r = r
    else
        self.v.r = 0
    end

    if g then
        self.v.g = g
    else
        self.v.g = 0
    end

    if b then
        self.v.b = b
    else
        self.v.b = 0
    end

    if a then
        self.v.a = a
    else
        self.v.a = 255
    end

    self.v.isDecimal = false

end

function Color:invert()

    if self.v.isDecimal then
      return self:invertDecimal()
    end

    self.v.r = 255 - self.v.r

    self.v.g = 255 - self.v.g

    self.v.b = 255 - self.v.b

    return self

end


function Color:invertDecimal()

    self.v.r = 1 - self.v.r

    self.v.g = 1 - self.v.g

    self.v.b = 1 - self.v.b

    return self

end

function Color:toDecimal()

    if self.v.isDecimal then
      return self
    end

    self.v.r = self.v.r / 255

    self.v.g = self.v.g / 255

    self.v.b = self.v.b / 255

    return self

end

function Color:toArray()

    return { self.v.r, self.v.g, self.v.b, self.v.a }

end

function Color:toDecimalArray()

    if self.v.isDecimal then
      return self:toArray()
    end

    return { self.v.r / 255, self.v.g / 255, self.v.b / 255, self.v.a / 255 }

end

return Color
