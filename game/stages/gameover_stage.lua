local class = require "lib.lua-oop"

require "engine.core"
require "engine.stage"
require "engine.objects.basic"
require "util.color"

local gameover_stage = class("Stage-GameOver", Stage)

function gameover_stage:constructor(plays, score)

    Stage.constructor(self) -- don't forget to call superclass constructor

    self.plays = plays
    self.score = score

end

function gameover_stage:init()

    setBackgroundColor(0, 0, 0, 255) -- recommended to set bg color here

    self.statsTxtObj = TextObj:new(nil, Color:new(255, 255, 255, 255), "", 20)
    self:addObject(self.statsTxtObj)

    self.stateTxtObj = TextObj:new(nil, Color:new(255, 255, 255, 255), "", 50)
    self:addObject(self.stateTxtObj)

    local restartTxtObj = TextObj:new(Vector2:new((love.graphics.getWidth() / 2) - 160, (love.graphics.getHeight() / 2) + 60), Color:new(255, 255, 255, 255), "Press ENTER to play a new game", 20)
    self:addObject(restartTxtObj)

    self.stateTxtObj.fontSize = 50 -- gameover text in this case
    self.statsTxtObj.fontSize = 20

    self.stateTxtObj.position:set((love.graphics.getWidth() / 2) - 145, (love.graphics.getHeight() / 2) - 100) -- gameover text here
    self.statsTxtObj.position:set((love.graphics.getWidth() / 2) - 40, (love.graphics.getHeight() / 2) - 15)

    love.audio.newSource("game/assets/mus_gameover.ogg", "stream"):play()

end

function gameover_stage:update(dt)


    self.stateTxtObj.text = "Game Over"
    self.statsTxtObj.text = "Plays: " .. tostring(self.plays) .. "\n" .. "Score: " .. tostring(self.score)

    if love.keyboard.isDown("return") then
        self.stageManager:changeStage("game.stages.simon_stage")
    end

end

function gameover_stage:draw() end

return gameover_stage -- don't forget to return the stage class
