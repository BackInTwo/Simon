local class = require "lib.lua-oop"

require "util.math.vector"

require "engine.core"
require "engine.stage"
require "engine.objects.basic"
require "util.timer"
require "util.color"

local initial_stage = class("Stage-Initial", Stage)

function initial_stage:constructor()

    Stage.constructor(self) -- don't forget to call superclass constructor

end

function initial_stage:init()

    love.window.setTitle("Simon")

    setBackgroundColor(0, 0, 0, 255)

    self.sndBell = love.audio.newSource("game/assets/snd_bell.ogg", "stream")

    self.maigamesSprObj = StaticSpriteObj:new(Vector2:new(200, 200), nil, Color:new(255, 255, 255, 0), "game/assets/img_logo_maigames.png")
    self:addObject(self.maigamesSprObj)

    self.maigamesSprObj:setOriginalDimensions()
    local x = (love.graphics.getWidth() / 2) - (self.maigamesSprObj.size.x / 2)
    local y = (love.graphics.getHeight() / 2) - (self.maigamesSprObj.size.y / 2)

    self.maigamesSprObj.position:set(x, y)

    self.timerAppear = Timer:new(3, true, true) -- 3 secs
    self.timerDisappear = Timer:new(4, true, false) -- 4 secs
    self.timerChangeStage = Timer:new(2, true, false) -- 2 secs

    self.timerAppear:onTimeout(function()
        self.maigamesSprObj.color:set(255, 255, 255, 255)
        self.sndBell:play()
        self.timerDisappear:start() -- start another timer for disappear
    end)

    self.timerDisappear:onTimeout(function()
        self.maigamesSprObj.color:set(255, 255, 255, 0)
        self.timerChangeStage:start() -- start another timer for change stage
    end)

    self.timerChangeStage:onTimeout(function()
        self.stageManager:changeStage(require("game.stages.simon_stage"):new())
    end)

end

function initial_stage:update(dt)

    self.timerAppear:update() -- update the timers
    self.timerDisappear:update()
    self.timerChangeStage:update()

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
