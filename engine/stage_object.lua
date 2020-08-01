local class = require "lib/lua-oop"

StageObject = class "StageObject"

function StageObject:constructor()

    self.isFirstUpdate = true

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

return StageObject
