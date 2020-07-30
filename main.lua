local class = require "lib/lua-oop"

function love.load()

    love.graphics.setBackgroundColor(0, 0, 0)
    love.window.setTitle("Maistronaut")

    current_stage = require("stages/maigames_stage"):new()

end

function love.update(dt)

    current_stage:_update(dt)

end

function love.draw()

    current_stage:draw()

end

function love.keypressed(key, scancode, isrepeat)

    -- Toggle fullscreen with F11 key
    if key == "f11" and not isrepeat then
        love.window.setFullscreen(not love.window.getFullscreen())
    end

end
