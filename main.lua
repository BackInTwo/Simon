require "oop"

require "maigames_screen"

lastdt = 0

newTestClass = testclass:new("hola!")

function love.load()
    
   love.graphics.setBackgroundColor(255,255,255)
   love.window.setTitle("Maistronaut")

end

function love.update(dt)

    lastdt = dt

end

function love.draw()

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print(tostring(testclass:sayHi()), 600, 300)

end

function love.keypressed (key, scancode, isrepeat)

    if key == "f11" and not isrepeat then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
    
end