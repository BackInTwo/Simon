require "util.color"

function getBackgroundColor()

    return Color.fromBackgroundColor()

end

function setBackgroundColor(r, g, b, a)

    if type(r) == "table" then
        r, g, b, a = color.get()
    end

    love.graphics.setBackgroundColor(r/255, g/255, b/255, a/255)

end
