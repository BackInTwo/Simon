local class = require "lib/lua-oop"

StageManager = class "StageManager"

function StageManager:constructor(initialStage)

    self.currentStage = initialStage

    self.currentStage.stageManager = self

    self.currentStage:_init()

end

function StageManager:changeStage(stage)

    if self.currentStage then
        self.currentStage:_beforeChange(nextStage)
    end

    self.currentStage = stage

    self.currentStage.stageManager = self

    self.currentStage:_init()

end

function StageManager:getCurrentStage()

    return self.currentStage

end

return StageManager
