local class = require "lib/lua-oop"

local Color = require "util/color"

Stage = class "Stage"

function Stage:constructor()

    self.v.firstUpdate = true
    self.objects = {}

end

function Stage:update(dt) end

function Stage:_update(dt)

    if self.v.firstUpdate then

        self:firstUpdate()

        print("First update of " .. self.class.name .. " stage")

        self.v.firstUpdate = false

    end

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        obj:_update()
    end

    self:update(dt)

end

function Stage:firstUpdate() end

function Stage:_firstUpdate()

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        obj:firstStageUpdate()
    end

    self:firstUpdate()

end

function Stage:init()

    love.graphics.setBackgroundColor(0, 0, 0)

end

function Stage:_init()

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        obj:stageInit()
    end

    self:init()

end

function Stage:draw()

    local textColor = Color.fromBackgroundColor()

    textColor:invert():toDecimal()

    love.graphics.setColor(textColor.v.r, textColor.v.g, textColor.v.b, 255)
    love.graphics.print("Superclass draw method called, override " .. self.class.name .. " draw(dt) from your stage class")

end

function Stage:_draw()

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        obj:draw()
    end

    self:draw()

end

function Stage:beforeChange(nextStage)

    print("Default beforeChange of " .. self.class.name)

end

function Stage:_beforeChange(nextStage)

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        obj:beforeChange()
    end

    self:beforeChange(nextStage)

end

function Stage:addObject(stageObject)

    stageObject.parentStage = self

    stageObject:init()

    table.insert(self.objects, stageObject)

    print(stageObject.class.name)

end
