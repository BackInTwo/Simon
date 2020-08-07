-- el codigo es un desastre, lo se, sorry :c
-- pero funciona :)

local class = require "lib.lua-oop"

require "engine.core"
require "engine.stage"
require "engine.stage.object"
require "engine.objects.basic"

require "util.color"
require "util.math.vector"

require "util/util"

local SimonRectangleObj = class("Obj-SimonRectangle", RectangleObj)

function SimonRectangleObj:constructor(position, size, color, clickColor, mouseObj)

    self.mouseObj = mouseObj

    self.defColor = color:set(color.r, color.g, color.b, 255)
    self.clickColor = clickColor

    self.doHighlight = false
    self.highlightFrames = 0
    self.highlightFramesC = 0

    self.onClick = function() end

    RectangleObj.constructor(self, position, size, color)

end

function SimonRectangleObj:update(dt)

    -- separating conditions into different variables for better readbility
    local a = self:isHitting(self.mouseObj) -- if mouse hitbox is inside the rectangle
    local ab = a and self.parentStage.mouseIsPrimaryDown -- if mouse is inside the rectangle and mouse primary is clicked
    local cd = self.parentStage.isClickEnabled and not self.parentStage.alreadyClickedOne -- better look stuff

    -- highlighting the rectangle
    if ab and cd or self.doHighlight then
        self.color = self.clickColor
        self.parentStage.alreadyClickedOne = true
    else
        self.color = self.defColor
        self.parentStage.alreadyClickedOne = false
    end

    -- highlighting without clicking (specific no. of frames)
    -- done with the highlight() function
    if self.doHighlight then
        self.highlightFramesC = self.highlightFramesC + 1
        self.doHighlight = self.highlightFramesC <= self.highlightFrames
    end

    -- playing sound and calling click function
    if a and cd and self.parentStage.mousePrimaryClicked then
        self.snd:stop()
        self.snd:play()
        self.onClick()
    end

end

function SimonRectangleObj:highlight(frames, playSound)

    if playSound == nil or playSound then
        self.snd:stop()
        self.snd:play()
    end

    self.doHighlight = true
    self.highlightFrames = frames
    self.highlightFramesC = 0

end

local simon_stage = class("Stage-Simon", Stage)

function simon_stage:constructor()

    Stage.constructor(self)

    self.lives = 5
    self.score = 0

    self.mousePrimaryDownC = 0
    self.mouseIsPrimaryDown = false
    self.mousePrimaryClicked = false

    self.alreadyClickedOne = false
    self.isClickEnabled = true

    self.order = nil
    self.orderSize = 4
    self.plays = 0

    self.clickOrder = nil

    self.memorizeOrderCurrentI = 0
    self.memorizeNextFrame = 0

    -- states: memorize, play, wait
    self.state = "memorize"
    self.beforeState = ""
    self.framesCurrentState = 0
    self.stateChange = false

end

function simon_stage:init()

    setBackgroundColor(0, 0, 0, 255) -- better look

    self.mouseObj = MouseObj:new()
    self:addObject(self.mouseObj)

    self.statsTxtObj = TextObj:new(nil, Color:new(255, 255, 255, 255), "", 20)
    self:addObject(self.statsTxtObj)

    self.stateTxtObj = TextObj:new(Vector2:new((love.graphics.getWidth() / 2) - 50, 20), Color:new(255, 255, 255, 255), "Memorize", 20)
    self:addObject(self.stateTxtObj)

    local winW = love.graphics.getWidth()
    local winH = love.graphics.getHeight()

    local size = Vector2:new(winW / 4, winW / 4)
    local clickColor = Color:new(255, 255, 255, 255)

    -- simon rectangles setup

    local posA = Vector2:new(winW / 4, winH / 6)
    self.rectA = SimonRectangleObj:new(posA, size, Color:new(255, 0, 0, 255), clickColor, self.mouseObj)
    self:addObject(self.rectA)

    self.rectA.snd = love.audio.newSource("game/assets/snd_rectA.ogg", "static")
    self.rectA.onClick = function()
        table.insert(self.clickOrder, 1)
    end

    local posB = Vector2:new(winW / 4 + size.x + 10, winH / 6)
    self.rectB = SimonRectangleObj:new(posB, size, Color:new(0, 255, 0, 255), clickColor, self.mouseObj)
    self:addObject(self.rectB)

    self.rectB.snd = love.audio.newSource("game/assets/snd_rectB.ogg", "static")
    self.rectB.onClick = function()
        table.insert(self.clickOrder, 2)
    end

    local posC = Vector2:new(winW / 4, winH / 6 + 212)
    self.rectC = SimonRectangleObj:new(posC, size, Color:new(0, 0, 255, 255), clickColor, self.mouseObj)
    self:addObject(self.rectC)

    self.rectC.snd = love.audio.newSource("game/assets/snd_rectC.ogg", "static")
    self.rectC.onClick = function()
        table.insert(self.clickOrder, 3)
    end

    local posD = Vector2:new(winW / 4 + size.x + 10, winH / 6 + 212)
    self.rectD = SimonRectangleObj:new(posD, size, Color:new(21, 189, 21, 255), clickColor, self.mouseObj)
    self:addObject(self.rectD)

    self.rectD.snd = love.audio.newSource("game/assets/snd_rectD.ogg", "static")
    self.rectD.onClick = function()
        table.insert(self.clickOrder, 4)
    end

end

function simon_stage:update()

    self.statsTxtObj.color:setFromBackground():invert()

    self.statsTxtObj.text = "Lives: " .. tostring(self.lives) .. "\n" .. "Plays: " .. tostring(self.plays) .. "\n" .. "Score: " .. tostring(self.score)

    -- primary mouse boolean handling
    if love.mouse.isDown(1) then
        self.mouseIsPrimaryDown = self.mousePrimaryDownC <= 5
        self.mousePrimaryClicked = self.mousePrimaryDownC == 0
        self.mousePrimaryDownC = self.mousePrimaryDownC + 1
    else
        self.mousePrimaryDownC = 0
        self.mouseIsPrimaryDown = false
        self.mousePrimaryClicked = false
    end

    -- state handling
    if self.state == "memorize" then

        self.stateTxtObj.text = "Memorize"

        -- executed once
        if self:stateChanged() then

            self.order = {} -- create a new random order
            for i = 1, self.orderSize do
                self.order[i] = math.random(1, 4)
            end

            self.memorizeNextFrame = self.framesCurrentState + 80
            self.memorizeOrderCurrentI = 0
            self.stateChange = false

        end

        -- highlighting the next simon rect every 60 frames
        if self.framesCurrentState >= self.memorizeNextFrame then

            local toHighlightRect = self.order[self.memorizeOrderCurrentI]

            if toHighlightRect == 1 then
                self.rectA:highlight(40)
            elseif toHighlightRect == 2 then
                self.rectB:highlight(40)
            elseif toHighlightRect == 3 then
                self.rectC:highlight(40)
            elseif toHighlightRect == 4 then
                self.rectD:highlight(40)
            end

            if self.memorizeOrderCurrentI > #self.order then
                self.plays = self.plays + 1
                if self.plays % 4 == 0 then -- every two plays there will be +1 rectangle to click
                    self.orderSize = self.orderSize + 1
                end
                self:setState("repeat")
            end

            self.memorizeNextFrame = self.framesCurrentState + 60
            self.memorizeOrderCurrentI = self.memorizeOrderCurrentI + 1

        end

        self.isClickEnabled = false

    elseif self.state == "repeat" then

        self.stateTxtObj.text = "Repeat"

        -- executed once
        if self:stateChanged() then
            self.clickOrder = {}
            self.stateChange = false
        end

        local i = #self.clickOrder
        if not (i == 0) then -- at least 1 rectangle clicked
            if self.order[i] == self.clickOrder[i] then -- currently success
                if i == #self.order then -- all clicked successfully
                    self.score = self.score + (50 * self.orderSize) -- add +50 score for each rectangle clicked
                    self:setState("memorize") -- sucess, memorize again
                end
            else -- failed
                self:setState("minusonelive") -- wrong clicked
            end
        end

        self.isClickEnabled = true

    elseif self.state == "minusonelive" then

        -- executed once
        if self:stateChanged() then
            self.lives = self.lives - 1
            self.framesMemorizeState = self.framesCurrentState + 100
            self.stateChange = false
        end

        if self.lives == 0 then
            self:setState("gameover")
        else
            self.stateTxtObj.text = "Wrong!"
        end

        if self.framesCurrentState >= self.framesMemorizeState then
            self:setState("memorize")
        end

        self.isClickEnabled = false

    elseif self.state == "gameover" then

        self.stateTxtObj.text = "Game Over"

        -- executed once
        if self:stateChanged() then
            self.stateChange = false
        end

        self.isClickEnabled = false

    else
        self.state = "memorize"
    end

    self.framesCurrentState = self.framesCurrentState + 1
    self.beforeState = self.state

end

function simon_stage:draw()

end

function simon_stage:stateChanged()

    return not (self.state == self.beforeState) or self.stateChange

end

function simon_stage:setState(state)

    self.framesCurrentState = 0
    self.stateChange = true
    self.state = state

    print("Change state to " .. state)

end

return simon_stage
