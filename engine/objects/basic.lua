local class = require "lib.lua-oop"

require "util.color"
require "util.math.vector"
require "engine.stage.object"

-- BASIC SHAPES

RectangleObj = class("Obj-Rect", StageObject)

function RectangleObj:constructor(position, size, color)

    StageObject.constructor(self, position, size, color)

end

function RectangleObj:draw()

    local r, g, b, a = self.color:getDecimal()

    love.graphics.setColor(r, g, b, a)
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)

end

-- MISCELANEOUS

FpsObj = class("Obj-Fps", StageObject)

function FpsObj:constructor(position, color)

    StageObject.constructor(self, position, nil, color)

end

function FpsObj:draw()

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.print(tostring(love.timer.getFPS()), self.position.x, self.position.y)

end

MouseObj = class("Obj-Mouse", StageObject)

function MouseObj:constructor()

    StageObject.constructor(self, nil, Vector2:new(12, 12), nil)

end

function MouseObj:update()
    self.position:set(love.mouse.getX(), love.mouse.getY())
end
