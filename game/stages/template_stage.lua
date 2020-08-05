local class = require "lib.lua-oop"

require "engine.core"
require "engine.stage"
require "util.color"

local template_stage = class("Stage-Template", Stage)

function template_stage:constructor()

    Stage.constructor(self) -- don't forget to call superclass constructor

end

function template_stage:init()

    setBackgroundColor(Color:new(255, 255, 255, 255)) -- recommended to set bg color here

end

function template_stage:update(dt)

    -- update code here

end

function template_stage:draw()

    -- draw code here

end

function template_stage:beforeChange()

    -- code to be executed before changing to another stages
    -- this method is called by the StageManager

end

return template_stage -- don't forget to return the stage class
