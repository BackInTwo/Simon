require "util.color"

function getBackgroundColor()

    return Color.fromBackgroundColor()

end

function setBackgroundColor(color)

    local c = nil

    if color.isDecimal then
        c = color
    else
        c = color:clone():toDecimal()
    end

    love.graphics.setBackgroundColor(c.r, c.g, c.b, c.a)

end
