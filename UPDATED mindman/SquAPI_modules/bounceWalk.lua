---@meta _
-- local squassets
-- local assetPath = "./SquAssets"
-- if pcall(require, assetPath) then squassets = require(assetPath) end
-- assert(squassets, "§4The bounceWalk module requires SquAssets, which was not found!§c")


---@class bounceWalk
local bounceWalk = {}
bounceWalk.all = {}

---*CONSTRUCTOR
---@param model ModelPart The path to your model element.
---@param bounceMultiplier? number Defaults to `1`, this multiples how much the bounce occurs.
---@return SquAPI.BounceWalk
function bounceWalk:new(model, bounceMultiplier)
    ---@class SquAPI.bounceWalk
    local self = {}

    assert(model, "Your model path is incorrect for bounceWalk")
    self.model = model
    self.bounceMultiplier = bounceMultiplier or 1
    self.target = 0

    self.enabled = true

    self = setmetatable(self, {__index = bounceWalk})
    table.insert(bounceWalk.all, self)
    return self
end


--*CONTROL FUNCTIONS

---bounceWalk enable handling
function bounceWalk:disable() self.enabled = false return self end
function bounceWalk:enable() self.enabled = true return self end
function bounceWalk:toggle() self.enabled = not self.enabled return self end

---@param bool boolean
function bounceWalk:setEnabled(bool)
    self.enabled = bool or false
    return self
end


--*UPDATE FUNCTIONS

function bounceWalk:render(dt, _)

  local pose = player:getPose()

  if self.enabled and (pose == "STANDING" or pose == "CROUCHING") then
    local leftlegrot = vanilla_model.LEFT_LEG:getOriginRot()[1]
    local bounce = self.bounceMultiplier
    if pose == "CROUCHING" then
      bounce = bounce / 2
    end
    self.target = math.abs(leftlegrot) / 40 * bounce
  else
    self.target = 0
  end

  self.model:setPos(0, math.lerp(self.model:getPos()[2], self.target, dt), 0)
end

return bounceWalk