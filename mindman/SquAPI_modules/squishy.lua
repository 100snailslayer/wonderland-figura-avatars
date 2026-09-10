---@class squishy
local squishy = {}
squishy.all = {}

---*CONSTRUCTOR
---@param model ModelPart The model to squish
---@param dampening? number Defaults to `0.3`, how much the movement is dampened(like air resistance)
---@param spingStrength? number Defaults to `0.3`, how strongly the model will return to its original scale.
---@param crouchBounce? number Defaults to `-0.5`, when crouching/uncrouching, the model will bounce by this factor. Negative values squish down while positive up.
---@param lowerLimit? Vector3 Defaults to `vec(0.6, 0.5, 0.6)`, the minimum scale the model can be squished to.
---@param upperLimit? Vector3 Defaults to `vec(1.25, 1.5, 1.25)`, the maximum scale the model can be squished to.
function squishy:new(model, spingStrength, dampening, crouchBounce, lowerLimit, upperLimit)
    ---@class SquAPI.squishy
    local self = {}

    assert(model, "§4The squishy model path is incorrect.§c")
    self.model = model
    self.springStrength = spingStrength or 0.3
    self.dampening = dampening or 0.3
    self.crouchBounce = crouchBounce or -0.5
    self.lowerLimit = lowerLimit or vec(0.6, 0.5, 0.6)
    self.upperLimit = upperLimit or vec(1.25, 1.5, 1.25)

    self.scale = vec(1,1,1)
    self.oldScale = vec(1,1,1)

    self.scaleVel = vec(0,0,0)

    self = setmetatable(self, {__index = squishy})
    table.insert(squishy.all, self)
    return self
end


--*CONTROL FUNCTIONS

---squishy enable handling
function squishy:disable() self.enabled = false return self end
function squishy:enable() self.enabled = true return self end
function squishy:toggle() self.enabled = not self.enabled return self end

---@param bool boolean
function squishy:setEnabled(bool)
    self.enabled = bool or false
    return self
end


--*UPDATE FUNCTIONS

---@param force Vector3 The force vector to apply to the model
function squishy:applyForce(force)
    self.scaleVel = vec(
        self.scaleVel.x + force.x - force.y/2 - force.z/2,
        self.scaleVel.y + force.y - force.x/2 - force.z/2,
        self.scaleVel.z + force.z - force.x/2 - force.y/2
    )
end

squishy.oldPose = "STANDING"
function squishy:tick()
    self.oldScale = self.scale

    local verticalVel = -player:getVelocity()[2]

    local pose = player:getPose()
    --avoid wonky when flying/swimming
    if pose == "FALL_FLYING" or pose == "SWIMMING" or player:riptideSpinning() then
        verticalVel = 0
    end
    --bounce when crouching/uncrouching
    if pose == "CROUCHING" and self.oldPose ~= "CROUCHING" then
        self:applyForce(vec(0, self.crouchBounce, 0))
    elseif self.oldPose == "CROUCHING" and pose ~= "CROUCHING" then
        self:applyForce(vec(0, -self.crouchBounce, 0))
    end
    self.oldPose = pose

    --pulls back to original scale
    local dif = vec(1,1,1) - self.scale
    local springForce = dif*self.springStrength

    --resistive force/dampening
    local dampeningForce = self.scaleVel * self.dampening

    local netForce = vec(0, verticalVel/4, 0) + springForce - dampeningForce
    self:applyForce(netForce)

    self.scale = self.scale + self.scaleVel

    --safety net to make sure it doesn't get stuck at a non-original scale, which can happen if the forces cancel out
    self.scale = self.scale + dif/5

    --limiting scale
    self.scale = vec(
        math.clamp(self.scale.x, 0.6, 1.25),
        math.clamp(self.scale.y, 0.5, 1.5),
        math.clamp(self.scale.z, 0.6, 1.25)
    )


end

---@param dt number Tick delta
function squishy:render(dt, _)
    self.model:setScale(math.lerp(self.oldScale, self.scale, dt))
end


return squishy