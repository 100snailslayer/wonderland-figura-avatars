---@meta _
local squassets
local assetPath = "./SquAssets"
if pcall(require, assetPath) then squassets = require(assetPath) end
assert(squassets, "§4The bewb module requires SquAssets, which was not found!§c")


---@class bewb
local bewb = {}
bewb.all = {}

---*CONSTRUCTOR
---@param element ModelPart The bewb element that you want to affect (models.[modelname].path).
---@param bendability? number Defaults to `2`, how much the bewb should move when you move.
---@param stiff? number Defaults to `0.05`, how stiff the bewb should be.
---@param bounce? number Defaults to `0.9`, how bouncy the bewb should be.
---@param doIdle? boolean Defaults to `true`, whether or not the bewb should have an idle sway (like breathing).
---@param idleStrength? number Defaults to `4`, how much the bewb should sway when idle.
---@param idleSpeed? number Defaults to `1`, how fast the bewb should sway when idle.
---@param downLimit? number Defaults to `-10`, the lowest the bewb can rotate.
---@param upLimit? number Defaults to `25`, the highest the bewb can rotate.
function bewb:new(element, bendability, stiff, bounce, doIdle, idleStrength, idleSpeed,
                         downLimit, upLimit)
    ---@class SquAPI.bewb
    local self = {}

    assert(element, "§4Your model path for bewb is incorrect.§c")
    self.element = element
    if doIdle == nil then doIdle = true end
    self.doIdle = doIdle
    self.bendability = bendability or 2
    self.bewby = squassets.BERP:new(stiff or 0.05, bounce or 0.9, downLimit or -10, upLimit or 25)
    self.idleStrength = idleStrength or 4
    self.idleSpeed = idleSpeed or 1
    self.target = 0

    self.enabled = true

    self.oldPose = "STANDING"


    self = setmetatable(self, {__index = bewb})
    table.insert(bewb.all, self)
    return self
end


--*CONTROL FUNCTIONS

---bewb enable handling
function bewb:disable() self.enabled = false return self end
function bewb:enable() self.enabled = true return self end
function bewb:toggle() self.enabled = not self.enabled return self end

---@param bool boolean
function bewb:setEnabled(bool)
    self.enabled = bool or false
    return self
end



--*UPDATE FUNCTIONS

function bewb:tick()
    if self.enabled then
      local vel = squassets.forwardVel()
      local yvel = squassets.verticalVel()
      local worldtime = world.getTime()

      if self.doIdle then
        self.target = math.sin(worldtime / 8 * self.idleSpeed) * self.idleStrength
      end

      --physics when crouching/uncrouching
      local pose = player:getPose()
      if pose == "CROUCHING" and self.oldpose == "STANDING" then
        self.bewby.vel = self.bewby.vel + self.bendability
      elseif pose == "STANDING" and self.oldpose == "CROUCHING" then
        self.bewby.vel = self.bewby.vel - self.bendability
      end
      self.oldpose = pose

      --physics when moving
      self.bewby.vel = self.bewby.vel - yvel * self.bendability
      self.bewby.vel = self.bewby.vel - vel * self.bendability
    else
      self.target = 0
    end
end

---@param dt number Tick delta
function bewb:render(dt, _)
    self.element:setOffsetRot(self.bewby:berp(self.target, dt), 0, 0)
end

return bewb