local class = require "lib.lua-oop"

Hitbox = class("Hitbox")

function Hitbox:constructor(position, size, type)

    self.position = position
    self.size = size

    if type then
        self.type = type
    else
        self.type = "boundingbox"
    end

end

function Hitbox:isHitting(other)

    if string.lower(self.type) == "boundingbox" then
        return self.position.x < other.position.x + other.size.x and
               other.position.x < self.position.x + self.size.x and
               self.position.y < other.position.y + other.size.y and
               other.position.y < self.position.y + self.size.y
    end

end
