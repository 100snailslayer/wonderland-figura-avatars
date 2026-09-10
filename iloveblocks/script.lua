vanilla_model.PLAYER:setVisible(false)

local keybindState = false
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

function pings.AnomalyPing(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
end

local AnomalyKey = keybinds:newKeybind("eyeless swap", "key.keyboard.h")
AnomalyKey.press = function()
    keybindState = not keybindState
    pings.AnomalyPing(keybindState)
end


function events.tick()
    local crouching = player:getPose() == "CROUCHING"
    -- This is the same line of code from the previous example
    local walking = player:getVelocity().xz:length() > .01
    -- walking == true when moving, and walking == false when still (or going directly up/down as we excluded the y axis)
    local sprinting = player:isSprinting()
    -- If you want to find more player functions, check out the Player Global page

    -- Now we're going to use a lot of logic to figure out when animations should/shouldn't play
    animations.model.idle:setPlaying(not walking and not crouching)
    -- You're idle when not walking and not crouching
    animations.model.walk:setPlaying(walking and not crouching and not sprinting)
    -- You're walking when... walking and not crouching, but you want to make sure you're not sprinting either
    --animations.example.sprint:setPlaying(sprinting and not crouching)
    -- You probably can catch my drift by now
    --animations.model.crouchIdle:setPlaying(crouching)
end

local squapi = require("SquAPI")

--replace each nil with the value/parmater you want to use, or leave as nil to use default values :)
--parenthesis are default values for reference
squapi.crouch(
    animations.model.crouchIdle, --crouch
    nil, --(nil) uncrouch
    nil, --(nil) crawl
    nil  --(nil) uncrawl
)