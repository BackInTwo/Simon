local class = require "lib/lua-oop"
local Stage = require "stages/stage"

local maigames_stage = class("Stage-MaiGames", Stage)

function maigames_stage:constructor()

    Stage.constructor(self)

end

function maigames_stage:init()

    love.graphics.setBackgroundColor(0, 125, 125)

end

function maigames_stage:update(dt)


end

function maigames_stage:draw()

    local dt = love.timer.getDelta()

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print(tostring(love.timer.getFPS() .. " " .. tostring(dt)), 5, 5)

end

return maigames_stage
