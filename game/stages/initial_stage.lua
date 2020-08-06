local class = require "lib.lua-oop"

require "engine.core"
require "engine.stage"
require "util.color"

local initial_stage = class("Stage-Initial", Stage)

function initial_stage:constructor()

    Stage.constructor(self) -- don't forget to call superclass constructor

end

function initial_stage:init()

    setBackgroundColor(0, 0, 0, 255)

    love.window.setTitle("Simon")

end

function initial_stage:update(dt)

    if love.keyboard.isDown("return") then
        self.stageManager:changeStage(require("game.stages.simon_stage"):new())
    end

end

function initial_stage:draw()

    -- draw code here

end

function initial_stage:beforeChange()

    -- code to be executed before changing to another stages
    -- this method is called by the StageManager

end

return initial_stage -- don't forget to return the stage class
