vanilla_model.PLAYER:setVisible(false)

local squapi = require("SquAPI")

local myTail = {
    models.model.root.Body.Tail,
    models.model.root.Body.Tail.Tail2,
    models.model.root.Body.Tail.Tail2.Tail3,
    models.model.root.Body.Tail.Tail2.Tail3.Tail4,
    models.model.root.Body.Tail.Tail2.Tail3.Tail4.Tail5,
    models.model.root.Body.Tail.Tail2.Tail3.Tail4.Tail5.Tail6
}

squapi.tail:new(myTail,
    nil,    --(15) idleXMovement
    2,    --(5) idleYMovement
    1,    --(1.2) idleXSpeed
    nil,    --(2) idleYSpeed
    nil,    --(2) bendStrength
    nil,    --(0) velocityPush
    nil,    --(0) initialMovementOffset
    .5,    --(1) offsetBetweenSegments
    nil,    --(.005) stiffness
    nil,    --(.9) bounce
    25,    --(90) flyingOffset
    nil,    --(-90) downLimit
    nil     --(45) upLimit
)

local keybindState = false
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

function pings.AnomalyPing(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
end

local AnomalyKey = keybinds:newKeybind("helpless swap", "key.keyboard.h")
AnomalyKey.press = function()
    keybindState = not keybindState
    pings.AnomalyPing(keybindState)
end

local myTail = {
    models.model.rootANOMALY.body2.boneTail,
    models.model.rootANOMALY.body2.boneTail.boneTail2,
    models.model.rootANOMALY.body2.boneTail.boneTail2.boneTail3,
    models.model.rootANOMALY.body2.boneTail.boneTail2.boneTail3.boneTail4,
    models.model.rootANOMALY.body2.boneTail.boneTail2.boneTail3.boneTail4.boneTail5,
    models.model.rootANOMALY.body2.boneTail.boneTail2.boneTail3.boneTail4.boneTail5.boneTail6
}

squapi.tail:new(myTail,
    nil,    --(15) idleXMovement
    2,    --(5) idleYMovement
    1,    --(1.2) idleXSpeed
    nil,    --(2) idleYSpeed
    nil,    --(2) bendStrength
    nil,    --(0) velocityPush
    nil,    --(0) initialMovementOffset
    .5,    --(1) offsetBetweenSegments
    nil,    --(.005) stiffness
    nil,    --(.9) bounce
    25,    --(90) flyingOffset
    nil,    --(-90) downLimit
    nil     --(45) upLimit
)

function events.tick()
    local crouching = player:getPose() == "CROUCHING"
    local walking = player:getVelocity().xz:length() > .01
    local sprinting = player:isSprinting()

    animations.model.idle:setPlaying(not walking and not crouching)
    animations.model.walk:setPlaying(walking and not crouching and not sprinting)
    animations.model.sprint:setPlaying(sprinting and not crouching)
    animations.model.crouch:setPlaying(crouching)
end