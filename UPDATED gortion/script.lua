vanilla_model.PLAYER:setVisible(false)

local keybindState = false
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

function pings.AnomalyPing(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
end

local AnomalyKey = keybinds:newKeybind("pillar swap", "key.keyboard.h")
AnomalyKey.press = function()
    keybindState = not keybindState
    pings.AnomalyPing(keybindState)
end


local openState = false
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

function pings.OpenPing(state)
    animations.model.open:setPlaying(state)
    animations.model.close:setPlaying(not state)
end

local OpenKey = keybinds:newKeybind("open", "key.keyboard.j")
OpenKey.press = function()
    openState = not openState
    pings.OpenPing(openState)
end