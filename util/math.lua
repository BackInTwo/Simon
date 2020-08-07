function clip(value, min, max)

    if value > max then
        return max
    elseif value < min then
        return min
    end

    return value

end

function round(value)
    math.floor((self.orderSize * 1.7)+0.5)
end
