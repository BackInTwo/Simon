local class = require "lib/lua-oop"
local template_stage = require "game/stages/template_stage"

require "engine/stage"
require "engine/stage_object"
require "util/math/vector"

local FpsObj = class("Obj-FpsObject", StageObject)

function FpsObj:constructor()

    StageObject.constructor(self, Vector2:new(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2))

end

function FpsObj:draw()

    local dt = love.timer.getDelta()

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print(tostring(love.timer.getFPS() .. " " .. tostring(dt)), self.position.x, self.position.y)

    print(self.position:toString())

end

function FpsObj:update()

end

function FpsObj:firstUpdate()

    print "firstUpdate"

end

local maigames_stage = class("Stage-MaiGames", Stage)

function maigames_stage:constructor()

    Stage.constructor(self)

    self:addObject(FpsObj:new())

end

function maigames_stage:init()

    love.graphics.setBackgroundColor(0, 125, 125)

end

function maigames_stage:update(dt)

    if love.keyboard.isDown("f1") then
        self.stageManager:changeStage(template_stage:new())
    end

end

function maigames_stage:draw()

end

return maigames_stage
