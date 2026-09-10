vanilla_model.PLAYER:setVisible(false)

local squapi = require("SquAPI")

models.model.FirstPersonArm:setVisible(false)

local keybindState = false
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

function pings.AnomalyPing(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
end

local AnomalyKey = keybinds:newKeybind("thespawn swap", "key.keyboard.h")
AnomalyKey.press = function()
    keybindState = not keybindState
    pings.AnomalyPing(keybindState)
end

--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.arm:new(
    models.model.rootANOMALY.LeftArm2, --element
    .5, --(1) strength
    false, --(false) isRight
    nil  --(true) keepPosition
)

squapi.arm:new(
    models.model.rootANOMALY.RightArm2, --element
    .5, --(1) strength
    true, --(false) isRight
    nil  --(true) keepPosition
)

squapi.leg:new(
    models.model.rootANOMALY.LeftLeg2,    --element
    .5,    --(1) strength
    nil,    --(false) isRight
    nil     --(true) keepPosition
)

squapi.leg:new(
    models.model.rootANOMALY.RightLeg2,    --element
    .5,    --(1) strength
    true,    --(false) isRight
    nil     --(true) keepPosition
)

squapi.arm:new(
    models.model.rootANOMALY.LeftArm2.LeftArmPart, --element
    nil, --(1) strength
    false, --(false) isRight
    nil  --(true) keepPosition
)

squapi.arm:new(
    models.model.rootANOMALY.RightArm2.RightArmPart, --element
    nil, --(1) strength
    true, --(false) isRight
    nil  --(true) keepPosition
)

squapi.leg:new(
    models.model.rootANOMALY.LeftLeg2.LeftLegPart,    --element
    nil,    --(1) strength
    nil,    --(false) isRight
    nil     --(true) keepPosition
)

squapi.leg:new(
    models.model.rootANOMALY.RightLeg2.RightLegPart,    --element
    nil,    --(1) strength
    true,    --(false) isRight
    nil     --(true) keepPosition
)

local myTail = {
    models.model.root.Body.Tail,
    models.model.root.Body.Tail.Tail2,
    models.model.root.Body.Tail.Tail2.Tail3,
    models.model.root.Body.Tail.Tail2.Tail3.Tail4,
    models.model.root.Body.Tail.Tail2.Tail3.Tail4.Tail5
}
--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.tail:new(myTail,
    10,    --(15) idleXMovement
    2,    --(5) idleYMovement
    1,    --(1.2) idleXSpeed
    nil,    --(2) idleYSpeed
    nil,    --(2) bendStrength
    .5,    --(0) velocityPush
    nil,    --(0) initialMovementOffset
    .5,    --(1) offsetBetweenSegments
    nil,    --(.005) stiffness
    nil,    --(.9) bounce
    20,    --(90) flyingOffset
    nil,    --(-90) downLimit
    nil     --(45) upLimit
)

--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.ear:new(
    models.model.root.Head.cheetahEars.LeftEar, --leftEar
    models.model.root.Head.cheetahEars.RightEar, --(nil) rightEar
    .5, --(1) rangeMultiplier
    nil, --(false) horizontalEars
    nil, --(2) bendStrength
    nil, --(true) doEarFlick
    nil, --(400) earFlickChance
    nil, --(0.1) earStiffness
    nil  --(0.8) earBounce
)

--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.crouch(
    animations.model.crouch, --crouch
    nil, --(nil) uncrouch
    nil, --(nil) crawl
    nil  --(nil) uncrawl
)

--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.FPHand:new(
    models.model.FirstPersonArm,    --element
    vec(0,0,0),    --( vec(0,0,0) ) position
200,    --(1) scale
    true     --(false) onlyVisibleInFP
)