local class = require "lib/lua-oop"

Vector2 = class "Vector2"

Vector2.static.fromOther = function(vector)

    return Vector2:new(nil, nil, vector)

end

function Vector2:constructor(x, y, other)

    if other then
        self.x = other.x
        self.y = other.y
        return
    end

    if x then
        assert(type(x) == "number", "x is not a number")
        self.x = x
    end

    if y then
        assert(type(y) == "number", "y is not a number")
        self.y = y
    end

end

function Vector2:multiply(by)

    if type(by) == "number" then
        self.x = self.x * by
        self.y = self.y * by
    elseif type(by) == "table" then
        self.x = self.x * by.x
        self.y = self.y * by.y
    end

    return self

end

function Vector2:toArray()

    return { self.x, self.y }

end

function Vector2:toString()

    return "Vector2(" .. tostring(self.x) .. ", " .. tostring(self.y) .. ")"

end
