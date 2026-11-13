---@meta _
-- local squassets
-- local assetPath = "./SquAssets"
-- if pcall(require, assetPath) then squassets = require(assetPath) end
-- assert(squassets, "§4The randimation module requires SquAssets, which was not found!§c")


---@class randimation
local randimation = {}
randimation.all = {}

---*CONSTRUCTOR
---@param animation Animation The animation to play.
---@param minTime? number Defaults to `100`, the loweest time in ticks the anim will play(randomly between this and maxTime).
---@param maxTime? number Defaults to `300`, the highest time in ticks the anim will play(randomly between minTime and this).
---@param stopOnSleep? boolean Defaults to `false`, if this is for blinking set this to true so that it doesn't blink while sleeping.
---@return SquAPI.Randimation
function randimation:new(animation, minTime, maxTime, stopOnSleep)
    ---@class SquAPI.randimation
    local self = setmetatable({}, {__index = randimation})
    self.stopOnSleep = stopOnSleep
    self.animation = animation
    self.minTime = minTime or 100
    self.maxTime = maxTime or 300

    self.timer = math.random(self.minTime, self.maxTime)

    self.enabled = true

    table.insert(randimation.all, self)
    return self
end


--*CONTROL FUNCTIONS

---randimation enable handling
function randimation:disable() self.enabled = false return self end
function randimation:enable() self.enabled = true return self end
function randimation:toggle() self.enabled = not self.enabled return self end

---@param bool boolean
function randimation:setEnabled(bool)
    self.enabled = bool or false
    return self
end


--*UPDATE FUNCTIONS

function randimation:tick()
    if self.enabled and (not self.stopOnSleep or player:getPose() ~= "SLEEPING") and self.animation:isStopped() then
      if self.timer <= 0 then
        self.animation:play()
        self.timer = math.random(self.minTime, self.maxTime)
      else
        self.timer = self.timer - 1
      end
    end
end


return randimation