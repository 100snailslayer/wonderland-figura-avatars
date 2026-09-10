---@class FPHand
local FPHand = {}
FPHand.all = {}

---*CONSTRUCTOR
--Make sure the setting for modifying first person hands is enabled in the Figura settings for this to work properly!!**
---@param element ModelPart The actual hand element to change.
---@param position? Vector3 Defaults to `vec(0,0,0)`, the position of the hover point relative to you.
---@param scale? number Defaults to `1`, this will multiply the size of the element by this size.
---@param onlyVisibleInFP? boolean Defaults to `false`, this will make the element invisible when not in first person if true.
---@return SquAPI.FPHand
function FPHand:new(element, position, scale, onlyVisibleInFP)
    ---@class SquAPI.FPHand
    local self = {}

    assert(element, "Your First Person Hand path is incorrect")
    element:setParentType("RightArm")
    self.element = element
    self.position = position or vec(0,0,0)
    self.scale = scale or 1
    self.onlyVisibleInFP = onlyVisibleInFP


    self = setmetatable(self, {__index = FPHand})
    table.insert(FPHand.all, self)
    return self
end


--*CONTROL FUNCTIONS

--*UPDATE FUNCTIONS

---@param context Event.Render.context
function FPHand:render(_, context)
    if context == "FIRST_PERSON" then
      if self.onlyVisibleInFP then
        self.element:setVisible(true)
      end
      self.element:setPos(self.position)
      self.element:setScale(self.scale, self.scale, self.scale)
    else
      if self.onlyVisibleInFP then
        self.element:setVisible(false)
      end
      self.element:setPos(0, 0, 0)
    end
end

return FPHand