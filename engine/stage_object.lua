local class = require "lib/lua-oop"

require "util/math/vector"

StageObject = class "StageObject"

function StageObject:constructor(position)

    self.isFirstUpdate = true

    self:setPosition(position)

end

function StageObject:init() end

function StageObject:stageInit() end

function StageObject:firstUpdate() end

function StageObject:firstStageUpdate() end

function StageObject:update(dt) end

function StageObject:_update(dt)

    if self.isFirstUpdate then

        print("First update of " .. self.parentStage.class.name .. "/" .. self.class.name .. " obj")

        self:firstUpdate()

        self.isFirstUpdate = false

    end

    self:update(dt)

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

return StageObject
