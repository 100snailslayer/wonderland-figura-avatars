vanilla_model.PLAYER:setVisible(false)

local keybindState = false
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

function pings.AnomalyPing(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
end

local AnomalyKey = keybinds:newKeybind("hoarder swap", "key.keyboard.h")
AnomalyKey.press = function()
    keybindState = not keybindState
    pings.AnomalyPing(keybindState)
end

models.model.rootArmor:setVisible(false)
local ArmorkeybindState = false 

function pings.ArmorPing(state)
    models.model.rootArmor:setVisible(state)
end

local ArmorKey = keybinds:newKeybind("fake diamond armor toggle", "key.keyboard.j")
ArmorKey.press = function()
    ArmorkeybindState = not ArmorkeybindState
    pings.ArmorPing(ArmorkeybindState)
end