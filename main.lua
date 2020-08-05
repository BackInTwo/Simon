local initial_stage = require "game.stages.initial_stage"

require "engine.stage.manager"

local stageManager = nil

function love.load()

    love.profiler = require('lib/profile')
    love.profiler.start()

    stageManager = StageManager:new(initial_stage:new())

end

love.frame = 0
function love.update(dt)

    stageManager:getCurrentStage():_update(dt)

    love.frame = love.frame + 1
      if love.frame%100 == 0 then
        love.report = love.profiler.report(30)
        print(love.report or "Please wait...")
        love.profiler.reset()
     end

end

function love.draw()

    stageManager:getCurrentStage():_draw()

    love.graphics.setColor(1, 1, 1, 1)

end

function love.keypressed(key, scancode, isrepeat)

    -- Toggle fullscreen with F11 key
    if key == "f11" and not isrepeat then
        love.window.setFullscreen(not love.window.getFullscreen())
    end

end
