---@meta _
local vanillaElement
local assetPath = "./VanillaElement"
if pcall(require, assetPath) then vanillaElement = require(assetPath) end
assert(vanillaElement, "§4The arm module requires VanillaElement, which was not found!§c")


---@class Arm
local arm = {}
setmetatable(arm, {__index = vanillaElement})
arm.all = {}

---*CONSTRUCTOR
---@param element ModelPart The element you want to apply the movement to.
---@param strength? number Defaults to `1`, how much it rotates.
---@param isRight? boolean Defaults to `false`, if this is the right arm or not.
---@param keepPosition? boolean Defaults to `true`, if you want the element to keep it's position as well.
---@return SquAPI.Arm
function arm:new(element, strength, isRight, keepPosition)
    ---@class SquAPI.arm
    local self = vanillaElement:new(element, strength, keepPosition)

    

    if isRight == nil then isRight = false end
    self.isRight = isRight
  
    setmetatable(self, {__index = arm})
    table.insert(arm.all, self)

    return self
end


--*CONTROL FUNCTIONS

--inherits functions from VanillaElement

--*UPDATE FUNCTIONS

---Returns the vanilla arm rotation and position vectors
---@return Vector3 #Vanilla arm rotation
function arm:getVanilla()
    if self.isRight then
        self.rot = vanilla_model.RIGHT_ARM:getOriginRot()
    else
        self.rot = vanilla_model.LEFT_ARM:getOriginRot()
    end
    self.pos = -vanilla_model.LEFT_ARM:getOriginPos()
    return self.rot, self.pos
end

return arm