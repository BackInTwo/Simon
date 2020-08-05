local class = require "lib.lua-oop"

require "engine.core"
require "engine.stage"
require "engine.stage.object"
require "engine.objects.basic"

require "util.color"
require "util.math.vector"

local initial_stage = class("Stage-Initial", Stage)

function initial_stage:constructor()

    Stage.constructor(self)

    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())
    self:addObject(FpsObj:new())

end

function initial_stage:init() -- All game initialization stuff will happen here

    setBackgroundColor(Color:new(0, 0, 0, 255):toDecimal()) -- better look

    love.window.setTitle("project_maistronaut")

    self.fpsObj = self:getObject("Obj-FpsObject")

end

function initial_stage:update()

    self.fpsObj.setColor(Color.fromBackgroundColor():invert():toDecimal())

end

function initial_stage:draw()

end

return initial_stage
