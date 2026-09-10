vanilla_model.PLAYER:setVisible(false)

local wingState = false
models.model.BodyFalse.Wings2:setVisible(false)

function pings.wingPing(state)
    models.model.BodyFalse.Wings2:setVisible(state)
end

local wingKey = keybinds:newKeybind("extra wing toggle", "key.keyboard.j")
wingKey.press = function()
    wingState = not wingState
    pings.wingPing(wingState)
end


local keybindState = false
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

function pings.AnomalyPing(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
end

local AnomalyKey = keybinds:newKeybind("yourmind swap", "key.keyboard.h")
AnomalyKey.press = function()
    keybindState = not keybindState
    pings.AnomalyPing(keybindState)
end

local squapi = require("SquAPI")

local myTail = {
    models.model.BodyFalse.Wings2.leftWing4,
    models.model.BodyFalse.Wings2.leftWing4.leftWing5,
    models.model.BodyFalse.Wings2.rightWing4,
    models.model.BodyFalse.Wings2.rightWing4.rightWing5
}
--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.tail:new(myTail,
    nil,    --(15) idleXMovement
    0,    --(5) idleYMovement
    nil,    --(1.2) idleXSpeed
    nil,    --(2) idleYSpeed
    nil,    --(2) bendStrength
    nil,    --(0) velocityPush
    nil,    --(0) initialMovementOffset
    1.5,    --(1) offsetBetweenSegments
    nil,    --(.005) stiffness
    nil,    --(.9) bounce
    0,    --(90) flyingOffset
    nil,    --(-90) downLimit
    nil     --(45) upLimit
)

local myTail = {
    models.model.rootANOMALY.Body2.backWings.leftBwing,
    models.model.rootANOMALY.Body2.backWings.leftBwing.leftBwing2,
    models.model.rootANOMALY.Body2.backWings.leftBwing.leftBwing2.leftBwing3,
    models.model.rootANOMALY.Body2.backWings.rightBwing,
    models.model.rootANOMALY.Body2.backWings.rightBwing.rightBwing2,
    models.model.rootANOMALY.Body2.backWings.rightBwing.rightBwing2.rightBwing3
}
--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.tail:new(myTail,
    nil,    --(15) idleXMovement
    0,    --(5) idleYMovement
    nil,    --(1.2) idleXSpeed
    nil,    --(2) idleYSpeed
    nil,    --(2) bendStrength
    nil,    --(0) velocityPush
    nil,    --(0) initialMovementOffset
    1,    --(1) offsetBetweenSegments
    nil,    --(.005) stiffness
    nil,    --(.9) bounce
    0,    --(90) flyingOffset
    nil,    --(-90) downLimit
    nil     --(45) upLimit
)