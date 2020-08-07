local class = require "lib.lua-oop"

require "util.math.vector"
require "util.color"
require "engine.stage.hitbox"

StageObject = class "StageObject"

function StageObject:constructor(position, size, color)

    self.isFirstUpdate = true
    self.enabled = true
    self.visible = true

    self.hitbox = Hitbox:new(position, size)

    self:setColor(color)
    self:setPosition(position)
    self:setSize(size)

end

function StageObject:init() end

function StageObject:stageInit() end

function StageObject:firstUpdate() end

function StageObject:firstStageUpdate() end

function StageObject:update(dt) end

function StageObject:_update(dt)

    if self.isFirstUpdate then

        print("First update of " .. self.parentStage.class.name .. "/" .. self.class.name .. " (object)")

        self:firstUpdate()

        self.isFirstUpdate = false

    end

    self:update(dt)

    self:updateHitbox()

end

function StageObject:draw() end

function StageObject:beforeChange(nextStage) end

function StageObject:setPosition(position)

        if position then
            assert(type(position) == "table", "Position is not an object (StageObject)")
            self.position = position
        else
            self.position = Vector2:new(0, 0)
        end

end

function StageObject:setSize(size)

        if size then
            assert(type(size) == "table", "Size is not an object (StageObject)")
            self.size = size
        else
            self.size = Vector2:new(0, 0)
        end

end

function StageObject:setColor(color)

    if color then
        self.color = color
    else
        self.color = Color:new(255, 255, 255, 255)
    end

end

function StageObject:updateHitbox()

    self.hitbox.position = self.position
    self.hitbox.size = self.size

end

function StageObject:isHitting(otherObject)

    return self.hitbox:isHitting(otherObject.hitbox)

end

return StageObject
