---@meta _
local squassets
local assetPath = "./SquAssets"
if pcall(require, assetPath) then squassets = require(assetPath) end
assert(squassets, "§4The taur module requires SquAssets, which was not found!§c")


---@class taur
local taur = {}
taur.all = {}

---*CONSTRUCTOR
---@param taurBody ModelPart The group of the body that contains all parts of the actual centaur part of the body, pivot should be placed near the connection between body and taurs body.
---@param frontLegs? ModelPart The group that contains both front legs.
---@param backLegs? ModelPart The group that contains both back legs.
---@return SquAPI.Taur
function taur:new(taurBody, frontLegs, backLegs)
    ---@class SquAPI.taur
    local self = {}

    assert(taurBody, "§4Your model path for the body in taurPhysics is incorrect.§c")
    self.taurBody = taurBody
    self.frontLegs = frontLegs
    self.backLegs = backLegs
    self.taur = squassets.BERP:new(0.01, 0.5)
    self.target = 0

    self.enabled = true

    self = setmetatable(self, {__index = taur})
    table.insert(taur.all, self)
    return self
end


--*CONTROL FUNCTIONS

---taur enable handling
function taur:disable() self.enabled = false return self end
function taur:enable() self.enabled = true return self end
function taur:toggle() self.enabled = not self.enabled return self end

---@param bool boolean
function taur:setEnabled(bool)
    self.enabled = bool or false
    return self
end



--*UPDATE FUNCTIONS

function taur:tick()
    if self.enabled then
      self.target = math.min(math.max(-30, squassets.verticalVel() * 40), 45)
    end
end

function taur:render(dt, _)
    if self.enabled then
      self.taur:berp(self.target, dt / 2)
      local pose = player:getPose()

      if pose == "FALL_FLYING" or pose == "SWIMMING" or (player:isClimbing() and not player:isOnGround()) or player:riptideSpinning() then
        self.taurBody:setRot(80, 0, 0)
        if self.backLegs then
          self.backLegs:setRot(-50, 0, 0)
        end
        if self.frontLegs then
          self.frontLegs:setRot(-50, 0, 0)
        end
      else
        self.taurBody:setRot(self.taur.pos, 0, 0)
        if self.backLegs then
          self.backLegs:setRot(self.taur.pos * 3, 0, 0)
        end
        if self.frontLegs then
          self.frontLegs:setRot(-self.taur.pos * 3, 0, 0)
        end
      end
    end
end

return taur