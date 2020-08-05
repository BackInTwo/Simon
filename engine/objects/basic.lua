local class = require "lib.lua-oop"

require "util.color"
require "engine.stage.object"

FpsObj = class("Obj-FpsObject", StageObject)

function FpsObj:constructor(position, color)

    StageObject.constructor(self, position, color)

end

function FpsObj:draw()

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.print(tostring(love.timer.getFPS()), self.position.x, self.position.y)
    
end
