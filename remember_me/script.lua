vanilla_model.PLAYER:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
animations.model.censor:setPlaying(true)

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
    animations.model.run:setPlaying(sprinting and not crouching)
    -- You probably can catch my drift by now
    animations.model.crouch:setPlaying(crouching)
end

local keybindState = false

function pings.CornPing(state)
    animations.model.cornflowerToggle:setPlaying(state)
end

local CornKey = keybinds:newKeybind("cornflower toggle", "key.keyboard.j")
CornKey.press = function()
    keybindState = not keybindState
    pings.CornPing(keybindState)
end

local keybindState2 = false

function pings.hangPing(state)
    animations.model.hanging:setPlaying(state)
end

local hangKey = keybinds:newKeybind("hanging toggle", "key.keyboard.h")
hangKey.press = function()
    keybindState2 = not keybindState2
    pings.hangPing(keybindState2)
end
