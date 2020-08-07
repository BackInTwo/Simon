local class = require "lib.lua-oop"

Timer = class("Timer")

function Timer:constructor(timeOutSecs, oneShoot, start)

    self.timeOutSecs = timeOutSecs
    self.oneShoot = oneShoot

    self.started = false
    self.hasTimeOuted = false
    self.timeout = false

    self.onTimeouts = {}

    self.resetRequested = false

    if start then
        self:start()
    end

end

function Timer:start()

    if not (self.started) then
        self.started = true
        self.endSecs = os.time() + self.timeOutSecs
    end

end

function Timer:update(dt)

    if not self.started then
        return
    end

    -- check if reset is requested (for security)
    if self.resetRequested then
        self.resetRequested = false
        self:reset(self.reqResetStart)
    end

    if os.time() >= self.endSecs then

        if self.oneShoot then
            if self.hasTimeOuted then
                self.timeout = false;
            else
                self.timeout = true;
                self:executeOnTimeouts()
            end
        else
            self.timeout = true;
            self:executeOnTimeouts()
        end

        self.hasTimeOuted = true;

    end

end

function Timer:doTimer(dt)

    self:start()
    self:update(dt)

end

function Timer:onTimeout(func)

    assert(type(func) == "function", "Parameter is not a function (Timer)")
    table.insert(self.onTimeouts, func)

end

function Timer:reset(start)

    if start == nil then
        start = true
    end

    self.started = false
    self.hasTimeOuted = false
    self.timeout = false

    if start then
        self:start()
    end

end

function Timer:requestReset(start)

    self.resetRequested = true
    self.reqResetStart = start

end

function Timer:executeOnTimeouts()

    for key, func in pairs(self.onTimeouts) do
        func()
    end

end

return Timer
