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

        print("First update of " .. self.class.name .. " (stage)")

        self.v.firstUpdate = false

    end

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        if obj.enabled then
            obj:_update()
        end
    end

    self:update(dt)

end

function Stage:firstUpdate() end

function Stage:_firstUpdate()

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        if obj.enabled then
            obj:firstStageUpdate()
        end
    end

    self:firstUpdate()

end

function Stage:init()

    love.graphics.setBackgroundColor(0, 0, 0)

end

function Stage:_init()

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        if obj.enabled then
            obj:stageInit()
        end
    end

    self:init()

end

function Stage:draw()

    local textColor = Color.fromBackgroundColor()

    textColor:invert():toDecimal()

    love.graphics.setColor(textColor.r, textColor.g, textColor.b, 1)
    love.graphics.print("Superclass draw method called, override " .. self.class.name .. " draw(dt) from your stage class")

end

function Stage:_draw()

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        if obj.enabled then
            obj:draw()
        end
    end

    self:draw()

end

function Stage:beforeChange(nextStage)

    print("Default beforeChange of " .. self.class.name .. " (stage)")

end

function Stage:_beforeChange(nextStage)

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        if obj.enabled then
            obj:beforeChange()
        end
    end

    self:beforeChange(nextStage)

end

function Stage:addObject(stageObject)

    stageObject.parentStage = self

    stageObject:init()

    table.insert(self.objects, stageObject)

end

function Stage:getObject(className)

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        if obj.class.name == className then
            return obj
        end
    end

    return nil

end

function Stage:getObjects(className)

    local objects = {}

    for i, obj in ipairs(self.objects) do
        obj.parentStage = self
        if obj.class.name == className then
            table.insert(objects, obj)
        end
    end

    return objects

end
