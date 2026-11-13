---@meta _
local vanillaElement
local assetPath = "./VanillaElement"
if pcall(require, assetPath) then vanillaElement = require(assetPath) end
assert(vanillaElement, "§4The leg module requires VanillaElement, which was not found!§c")


---@class Leg
local leg = {}
setmetatable(leg, {__index = vanillaElement})
leg.all = {}

---*CONSTRUCTOR
---@param element ModelPart The element you want to apply the movement to.
---@param strength? number Defaults to `1`, how much it rotates.
---@param isRight? boolean Defaults to `false`, if this is the right leg or not.
---@param keepPosition? boolean Defaults to `true`, if you want the element to keep it's position as well.
---@return SquAPI.Leg
function leg:new(element, strength, isRight, keepPosition)
    ---@class SquAPI.leg
    local self = vanillaElement:new(element, strength, keepPosition)
    setmetatable(self, {__index = leg})

    if isRight == nil then isRight = false end
    self.isRight = isRight


    table.insert(leg.all, self)
    return self
end


--*CONTROL FUNCTIONS

--inherits functions from VanillaElement

--*UPDATE FUNCTIONS

---Returns the vanilla leg rotation and position vectors
---@return Vector3 #Vanilla leg rotation
---@return Vector3 #Vanilla leg position
function leg:getVanilla()
    if self.isRight then
      self.rot = vanilla_model.RIGHT_LEG:getOriginRot()
      self.pos = vanilla_model.RIGHT_LEG:getOriginPos()
    else
      self.rot = vanilla_model.LEFT_LEG:getOriginRot()
      self.pos = vanilla_model.LEFT_LEG:getOriginPos()
    end
    return self.rot, self.pos
end

return leg