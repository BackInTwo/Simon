local class = require "lib.lua-oop"

require "engine.core"
require "engine.stage"
require "engine.stage.object"
require "engine.objects.basic"

require "util.color"
require "util.math.vector"

local LocalRectangleObj = class("Obj-RectLocal", RectangleObj)

function LocalRectangleObj:constructor(position, size, rectObj)

    self.rectObj = rectObj

    RectangleObj.constructor(self, position, size, Color:new(127, 127, 127, 255))

end

function LocalRectangleObj:update(dt)

    self.position:set(love.mouse.getX(), love.mouse.getY())

    if self:isHitting(self.rectObj) then
        self.color:set(50, 50, 127, 255)
    else
        self.color:set(127, 127, 127, 255)
    end

end

local initial_stage = class("Stage-Initial", Stage)

function initial_stage:constructor()

    Stage.constructor(self)

    local rectObj = RectangleObj:new(Vector2:new(250, 300), Vector2:new(200, 100))

    self:addObject(rectObj)
    self:addObject(FpsObj:new())
    self:addObject(LocalRectangleObj:new(Vector2:new(250, 300), Vector2:new(200, 100), rectObj))

end

function initial_stage:init() -- All game initialization stuff will happen here

    setBackgroundColor(0, 0, 0, 255) -- better look

    love.window.setTitle("project_maistronaut")

    self.fpsObj = self:getObject("Obj-Fps")

end

function initial_stage:update()

    self.fpsObj.color:setFromBackground():invert()

end

function initial_stage:draw()

end

return initial_stage
