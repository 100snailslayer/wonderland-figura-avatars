---@class vanillaElement
local vanillaElement = {}
vanillaElement.all = {}

---*CONSTRUCTOR
---@param element ModelPart The elements model path
---@param strength? number How much the element rotates relative to 
function vanillaElement:new(element, strength, keepPosition)
    ---@class SquAPI.vanillaElement
    local self = {}

    self.keepPosition = keepPosition 
	if keepPosition == nil then self.keepPosition = true end
    assert(element, "§4The first vanilla Element's model path is incorrect.§c")
	self.element = element
	self.element:setParentType("NONE")
    self.strength = strength or 1

	self.rot = vec(0,0,0)
	self.pos = vec(0,0,0)
    self.frozen = false

	self.enabled = true
	
    self = setmetatable(self, {__index = vanillaElement})
    --table.insert(vanillaElement.all, self)

    return self
end

--*CONTROL FUNCTIONS

---vanillaElement enable handling
function vanillaElement:disable() self.enabled = false return self end
function vanillaElement:enable() self.enabled = true return self end
function vanillaElement:toggle() self.enabled = not self.enabled return self end

---@param bool boolean
function vanillaElement:setEnabled(bool)
    self.enabled = bool or false
    return self
end

--freezes the element where it is
function vanillaElement:freeze()
	self.frozen = true
end
function vanillaElement:unfreeze()
	self.frozen = false
end

--returns it to normal attributes
function vanillaElement:zero()
    self.element:setOffsetRot(0, 0, 0)
	self.element:setPos(0, 0, 0)
end
	
--get the current rot/pos
function vanillaElement:getPos()
	return self.pos
end
function vanillaElement:getRot()
	return self.rot
end


--*UPDATE FUNCTIONS

function vanillaElement:render(dt, _)
	
    if not self.frozen then
		if self.enabled then
			local rot, pos = self:getVanilla()
			self.element:setOffsetRot(rot*self.strength)
			if self.keepPosition then
				self.element:setPos(pos)
			end
		else
			self.element:setOffsetRot(math.lerp(
				self.element:getOffsetRot(), 0, dt	
			))
			self.rot = math.lerp(self.rot, 0, dt)
			self.pos = math.lerp(self.pos, 0, dt)
		end
    end
end

function vanillaElement:getVanilla()
    error("§4vanillaElement has been instatiated even though it is abstract, please use sublclass§c")
end

return vanillaElement


