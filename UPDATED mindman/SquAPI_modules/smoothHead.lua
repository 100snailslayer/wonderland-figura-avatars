---SMOOTH HEAD 
---Mimics a vanilla player head, but smoother and with some extra life. Can also do smooth Torsos and Smooth Necks!


---@meta _
local squassets
local assetPath = "./SquAssets"
if pcall(require, assetPath) then squassets = require(assetPath) end
assert(squassets, "§4The smoothHead module requires SquAssets, which was not found!§c")

---@class smoothHead
local smoothHead = {}
smoothHead.all = {}

---*CONSTRUCTOR
---@param element ModelPart|table<ModelPart> The head element that you wish to effect. If you want a smooth neck or torso, instead of a single element, input a table of head elements(imagine it like {element1, element2, etc.}). this will apply the head rotations to each of these.
---@param strength? number|table<number> Defaults to `1`, the target rotation is multiplied by this factor. If you want a smooth neck or torso, instead of an single number, you can put in a table(imagine it like {strength1, strength2, etc.}). this will apply each strength to each respective element.(make sure it is the same length as your element table)
---@param tilt? number Defaults to `0.1`, for context the smooth head applies a slight tilt to the head as it's rotated toward the side, this controls the strength of that tilt.
---@param speed? number Defaults to `1`, how fast the head will rotate toward the target rotation.
---@param keepOriginalHeadPos? boolean|number Defaults to `true`, when true the heads position will follow the vanilla head position. For example when crouching the head will shift down to follow. If set to a number, changes which modelpart gets moved when doing actions such as crouching. this should normally be set to the neck modelpart.
---@param fixPortrait? boolean Defaults to `true`, sets whether or not the portrait should be applied if a group named "head" is found in the elements list
---@param animStraightenList? table<Animation> Defaults to `nil`, you can put in a list of animations that when played, will cause the head to straighten.
---@param straightenMultiplier? number Defaults to `0.5`, how strong the head will straighten during above
---@param straightenSpeed? number Defaults to `0.5`, how fast the head will straighten during above
---@param blendToConsiderStopped? number Defaults to `0.1`, for above, the animation will be considered stopped when it's blend is below this value.
---@return SquAPI.SmoothHead
function smoothHead:new(element, strength, tilt, speed, keepOriginalHeadPos, fixPortrait, animStraightenList, straightenMultiplier, straightenSpeed, blendToConsiderStopped)
  ---@class SquAPI.SmoothHead
  local self = setmetatable({}, {__index = smoothHead})

  --if it's a single element then converts to table
  if type(element) == "ModelPart" then
    assert(element, "§4Your model path for smoothHead is incorrect.§c")
    element = { element }
  end

  --checks each element amd updates parent type to none
  for i = 1, #element do
    assert(element[i]:getType() == "GROUP",
      "§4The head element at position " ..
      i ..
      " of the table is not a group. The head elements need to be groups that are nested inside one another to function properly.§c")
    assert(element[i], "§4The head segment at position " .. i .. " is incorrect.§c")
    element[i]:setParentType("NONE")
  end
  self.element = element

  --if strength is a single number then converts to table by evenly dividing strength for each element
  self.strength = strength or 1
  if type(self.strength) == "number" then
    local strengthDiv = self.strength / #element
    self.strength = {}
    for i = 1, #element do
      self.strength[i] = strengthDiv
    end
  end

  self.tilt = tilt or 0.1
  self.speed = (speed or 1)
  if keepOriginalHeadPos == nil then keepOriginalHeadPos = true end
  self.keepOriginalHeadPos = keepOriginalHeadPos
  self.animStraightenList = animStraightenList
  self.straightenMultiplier = straightenMultiplier or 0.5
  self.straightenSpeed = straightenSpeed or 0.5
  self.blendToConsiderStopped = blendToConsiderStopped or 0.1

  self.currentStraightenMultiplier = 1

  --portrait fix by FOX
  if fixPortrait == nil then fixPortrait = true end
  if fixPortrait then
    if type(element) == "table" then
      for _, part in ipairs(element) do
        if squassets.caseInsensitiveFind(part, "head") then
          part:copy("_squapi-portrait"):moveTo(models):setParentType("Portrait")
              :setPos(-part:getPivot())
          break
        end
      end
    elseif type(element) == "ModelPart" and element:getType() == "GROUP" then
      if squassets.caseInsensitiveFind(element, "head") then
        element:copy("_squapi-portrait"):moveTo(models):setParentType("Portrait")
            :setPos(-element:getPivot())
      end
    end
  end


  self.rot = {}
  self.rotOld = {}
  for i in ipairs(self.element) do
    self.rot[i] = vec(0,0,0)
    self.rotOld[i] = vec(0,0,0)
  end

  self.enabled = true

  table.insert(smoothHead.all, self)
  return self
end


--*CONTROL FUNCTIONS

---Applies an offset to the heads rotation to more easily modify it. Applies as a vector.(for multisegments it will modify the target rotation)
  ---@param xRot number X rotation
  ---@param yRot number Y rotation
  ---@param zRot number Z rotation
  function smoothHead:setOffset(xRot, yRot, zRot)
    self.offset = vec(xRot, yRot, zRot)
    return self
  end

---smoothHead enable handling
function smoothHead:disable() self.enabled = false return self end
function smoothHead:enable() self.enabled = true return self end
function smoothHead:toggle() self.enabled = not self.enabled return self end

---@param bool boolean
function smoothHead:setEnabled(bool)
    self.enabled = bool or false
    return self
end

  ---Resets this smooth head's position and rotation to their initial values
  function smoothHead:zero()
    for _, v in ipairs(self.element) do
      v:setPos(0, 0, 0)
      v:setOffsetRot(0, 0, 0)
      self.headRot = vec(0, 0, 0)
    end
    return self
  end



  
--*UPDATE FUNCTIONS

function smoothHead:tick()
  
  if self.animStraightenList then
    local strengthMultiplier = 1
    for _, v in ipairs(self.animStraightenList) do

      if v:isPlaying() and v:getBlend() > self.blendToConsiderStopped then
        strengthMultiplier = self.straightenMultiplier
        break
      end

    end

    self.currentStraightenMultiplier = math.lerp(self.currentStraightenMultiplier, strengthMultiplier, self.straightenSpeed)

  end
    
  for i in ipairs(self.element) do
    self.rotOld[i] = self.rot[i]
  end

  if self.enabled then
    local vanillaHeadRot = squassets.getHeadRot():add(vanilla_model.HEAD:getOffsetRot())
      
    for i in ipairs(self.element) do
        self.rot[i] = math.lerp(self.rot[i], (vanillaHeadRot + vanillaHeadRot.__y * self.tilt) * self.strength[i] * self.currentStraightenMultiplier , self.speed)
    end
  end
    
end

---@param dt number Tick delta
---@param context Event.Render.context
function smoothHead:render(dt, context)
    if self.enabled then
      for i, element in ipairs(self.element) do

        element:setOffsetRot(
          math.lerp(self.rotOld[i], self.rot[i], dt)
        )
        -- Better Combat SquAPI Compatibility created by @jimmyhelp and @foxy2526 on Discord
        if renderer:isFirstPerson() and context == "RENDER" then
          self.element[i]:setVisible(false)
        else
          self.element[i]:setVisible(true)
        end
      end

      if self.keepOriginalHeadPos then
        self.element
            [type(self.keepOriginalHeadPos) == "number" and self.keepOriginalHeadPos or #self.element]
            :setPos(-vanilla_model.HEAD:getOriginPos())
      end
    end
end

return smoothHead