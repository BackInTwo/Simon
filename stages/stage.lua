local class = require "lib/lua-oop"

local Color = require "util/color"

local Stage = class "Stage"

function Stage:constructor()

    self.v.firstUpdate = true

end

function Stage:update(dt) end

function Stage:_update(dt)

    if self.v.firstUpdate then

        self:init()

        print("Init " .. self.__className .. " stage")

        self.v.firstUpdate = false

    end

    self:update(dt)

end

function Stage:init()

    love.graphics.setBackgroundColor(0, 0, 0)

end

function Stage:draw()

    local textColor = Color.fromBackgroundColor()

    textColor:invert():toDecimal()

    love.graphics.setColor(textColor.v.r, textColor.v.g, textColor.v.b, 255)
    love.graphics.print("Superclass draw method called, override draw(dt) from your stage class")

end

return Stage
