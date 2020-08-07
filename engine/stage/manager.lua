local class = require "lib.lua-oop"

StageManager = class "StageManager"

function StageManager:constructor(initialStage)

    self.currentStage = initialStage

    self.currentStage.stageManager = self

    self.currentStage:_init()

end

function StageManager:changeStage(stage)

    if type(stage) == "string" then
        stage = require(stage):new()
    end

    assert(type(stage) == "string" or type(stage) == "table", "Stage is not a string path or an object (StageManager)")

    if self.currentStage then
        self.currentStage:_beforeChange(nextStage)
    end

    self.currentStage = stage

    print("Change stage to " .. self.currentStage.class.name)

    self.currentStage.stageManager = self

    self.currentStage:_init()

end

function StageManager:getCurrentStage()

    return self.currentStage

end

return StageManager
