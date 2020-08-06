require "util.color"

function getBackgroundColor()

    return Color.fromBackgroundColor()

end

function setBackgroundColor(r, g, b, a)

    if type(r) == "table" then
        r, g, b, a = color.getDecimal()
    end

    love.graphics.setBackgroundColor(r, g, b, a)

end
