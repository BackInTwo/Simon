function clip(value, min, max)

    if value > max then
        return max
    elseif value < min then
        return min
    end

    return value

end
