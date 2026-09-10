vanilla_model.PLAYER:setVisible(false)
animations.model.censor:setPlaying(true)

local keybindState = false
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

function pings.AnomalyPing(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
end

local AnomalyKey = keybinds:newKeybind("no_one swap", "key.keyboard.h")
AnomalyKey.press = function()
    keybindState = not keybindState
    pings.AnomalyPing(keybindState)
end

local upsideDown = false

function pings.downPing(state)
    animations.model.upsidedown:setPlaying(state)
end

local downKey = keybinds:newKeybind("upside down", "key.keyboard.j")
downKey.press = function()
    upsideDown = not upsideDown
    pings.downPing(upsideDown)
end

local hangmanState = false
models.model.rootHANGMAN:setVisible(false)

function pings.HangmanPing(state)
    models.model.rootHANGMAN:setVisible(state)
    models.model.rootANOMALY:setVisible(not state)
    models.model.root:setVisible(not state)
end

local HangmanKey = keybinds:newKeybind("hangman swap", "key.keyboard.n")
HangmanKey.press = function()
    hangmanState = not hangmanState
    pings.HangmanPing(hangmanState)
end

local squapi = require("SquAPI")

squapi.arm:new(
    models.model.rootHANGMAN.LeftArm3, --element
    .5, --(1) strength
    nil, --(false) isRight
    nil  --(true) keepPosition
)

squapi.arm:new(
    models.model.rootHANGMAN.RightArm3, --element
    .5, --(1) strength
    true, --(false) isRight
    nil  --(true) keepPosition
)

squapi.leg:new(
    models.model.rootHANGMAN.LeftLeg3, --element
    .5, --(1) strength
    nil, --(false) isRight
    nil  --(true) keepPosition
)

squapi.leg:new(
    models.model.rootHANGMAN.RightLeg3, --element
    .5, --(1) strength
    true, --(false) isRight
    nil  --(true) keepPosition
)

function events.tick()
    local crouching = player:getPose() == "CROUCHING"
    local walking = player:getVelocity().xz:length() > .01
    local sprinting = player:isSprinting()

    animations.model.hangmanIdle:setPlaying(not walking and not crouching)
end