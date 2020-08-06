local class = require "lib.lua-oop"

require "engine.core"
require "engine.stage"
require "engine.stage.object"
require "engine.objects.basic"

require "util.color"
require "util.math.vector"

local SimonRectangleObj = class("Obj-SimonRectangle", RectangleObj)

function SimonRectangleObj:constructor(position, size, color, clickColor, mouseObj)

    self.mouseObj = mouseObj

    self.defColor = color:set(color.r, color.g, color.b, 255)
    self.clickColor = clickColor

    self.highlight = false

    RectangleObj.constructor(self, position, size, color)

end

function SimonRectangleObj:update(dt)

    if (self:isHitting(self.mouseObj) and self.parentStage.mouseIsPrimaryDown and self.parentStage.isClickEnabled) or self.highlight then
        self.color = self.clickColor
    else
        self.color = self.defColor
    end

end

local simon_stage = class("Stage-Simon", Stage)

function simon_stage:constructor()

    Stage.constructor(self)

    self.mousePrimaryDownC = 0
    self.mouseIsPrimaryDown = false
    self.mousePrimaryClicked = false

    self.isClickEnabled = true

end

function simon_stage:init() -- All game initialization stuff will happen here

    setBackgroundColor(0, 0, 0, 255) -- better look

    self.mouseObj = MouseObj:new()
    self.fpsObj = FpsObj:new()

    self:addObject(self.mouseObj)
    self:addObject(self.fpsObj)

    local winW = love.graphics.getWidth()
    local winH = love.graphics.getHeight()

    local size = Vector2:new(winW / 4, winW / 4)
    local clickColor = Color:new(255, 255, 255, 255)

    local posA = Vector2:new(winW / 4, winH / 6)
    self:addObject(SimonRectangleObj:new(posA, size, Color.fromRandom(), clickColor, self.mouseObj))

    local posB = Vector2:new(winW / 4 + size.x + 10, winH / 6)
    self:addObject(SimonRectangleObj:new(posB, size, Color.fromRandom(), clickColor, self.mouseObj))

    local posC = Vector2:new(winW / 4, winH / 6 + 212)
    self:addObject(SimonRectangleObj:new(posC, size, Color.fromRandom(), clickColor, self.mouseObj))

    local posD = Vector2:new(winW / 4 + size.x + 10, winH / 6 + 212)
    self:addObject(SimonRectangleObj:new(posD, size, Color.fromRandom(), clickColor, self.mouseObj))

end

function simon_stage:update()

    self.fpsObj.color:setFromBackground():invert()

    if love.mouse.isDown(1) then
        self.mouseIsPrimaryDown = self.mousePrimaryDownC <= 10
        self.mousePrimaryClicked = self.mousePrimaryDownC == 0
        self.mousePrimaryDownC = self.mousePrimaryDownC + 1
    else
        self.mousePrimaryDownC = 0
        self.mouseIsPrimaryDown = false
        self.mousePrimaryClicked = false
    end

end

function simon_stage:draw()

end

return simon_stage
