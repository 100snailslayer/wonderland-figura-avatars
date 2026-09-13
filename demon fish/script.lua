vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

local squapi = require("SquAPI")

vanilla_model.HELD_ITEMS:setVisible(false)

local myTail = {
    models.model.root.Body,
    models.model.root.Body.Tail1,
    models.model.root.Body.Tail1.Tail2,
    models.model.root.Body.Tail1.Tail2.Tail3,
    models.model.root.Body.leftFin,
    models.model.root.Body.rightFin
}
--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.tail:new(myTail,
    nil,    --(15) idleXMovement
    2,    --(5) idleYMovement
    1,    --(1.2) idleXSpeed
    nil,    --(2) idleYSpeed
    nil,    --(2) bendStrength
    nil,    --(0) velocityPush
    nil,    --(0) initialMovementOffset
    nil,    --(1) offsetBetweenSegments
    nil,    --(.005) stiffness
    nil,    --(.9) bounce
    0,    --(90) flyingOffset
    nil,    --(-90) downLimit
    nil     --(45) upLimit
)

