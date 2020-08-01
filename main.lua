local class = require "lib/lua-oop"

local maigames_stage = require "game/stages/maigames_stage"

require "engine/stage_manager"

local stageManager = nil

function love.load()

    love.graphics.setBackgroundColor(0, 0, 0)
    love.window.setTitle("Maistronaut")

    stageManager = StageManager:new(maigames_stage:new())

end

function love.update(dt)

    stageManager:getCurrentStage():_update(dt)

end

function love.draw()

    stageManager:getCurrentStage():_draw()

end

function love.keypressed(key, scancode, isrepeat)

    -- Toggle fullscreen with F11 key
    if key == "f11" and not isrepeat then
        love.window.setFullscreen(not love.window.getFullscreen())
    end

end
