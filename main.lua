require "engine.stage.manager"

local stageManager = nil

profilerEnabled = false -- toggle on or off the profiler (wont work changing it on runtime)

function love.load()

    love.window.setTitle("")

    -- profiling stuff, attaches to love module
    love.profiler = require('lib/profile')
    love.profiler.start()
    love.frame = 0

    math.randomseed(os.time() * 1000)

    stageManager = StageManager:new("game.stages.initial_stage")

end

function love.update(dt)

    math.randomseed((os.time() * 1000) * (math.random(0, os.time() * 1000)))

    stageManager:getCurrentStage():_update(dt)

    -- profiling stuff
    love.frame = love.frame + 1
    if love.frame%100 == 0 and profilerEnabled then
        love.report = love.profiler.report(30)
        print(love.report or "Please wait...")
        love.profiler.reset()
    elseif not profilerEnabled then
        love.profiler.stop()
    end

end

function love.draw()

    stageManager:getCurrentStage():_draw()

    love.graphics.setColor(1, 1, 1, 1)

end

function love.keypressed(key, scancode, isrepeat)

    -- Toggle fullscreen with F11 key
    if key == "f11" and not isrepeat then
        --love.window.setFullscreen(not love.window.getFullscreen())
    end

end
