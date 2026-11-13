vanilla_model.PLAYER:setVisible(false)
models.model.rootANOMALY:setVisible(false)
models.model.root.Head.ExtraHair:setVisible(false)
models.model.rootANOMALY:setPrimaryRenderType("EMISSIVE")

--nameplate
nameplate.ALL:setText('{"text":"MindManLol954", "color":"#ffffff", "bold":true}')

--action wheel
local actionMain = action_wheel:newPage()
local actionPage = action_wheel:newPage()
local soundPage = action_wheel:newPage()
action_wheel:setPage(actionMain)

local pageAction1 = actionMain:newAction()
    :title("Toggles")
    :item("minecraft:diamond_sword")
    :onLeftClick(function()
        action_wheel:setPage(actionPage)
    end)
local pageAction2 = actionPage:newAction()
    :title("Return")
    :item("minecraft:diamond_sword")
    :onLeftClick(function()
        action_wheel:setPage(actionMain)
end)

--yourmind toggle
function pings.mindToggled(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
    nameplate.ENTITY:setVisible(not state)
end

local anomToggle = actionPage:newAction()
    :title("YourMind Toggle")
    :toggleTitle("YourMind Toggle")
    :item("minecraft:redstone_block")
    :toggleItem("minecraft:emerald_block")
    :hoverColor(0, 1, 0)
    :setOnToggle(pings.mindToggled)

--elytra toggle
function pings.elytraToggled(state)
    vanilla_model.ELYTRA:setVisible(not state)
end

local elytraToggle = actionPage:newAction()
    :title("Elytra Invisible Toggle")
    :toggleTitle("Elytra Invisible Toggle")
    :item("minecraft:redstone_block")
    :toggleItem("minecraft:emerald_block")
    :hoverColor(0, 1, 0)
    :setOnToggle(pings.elytraToggled)

--long hair toggle
function pings.hairToggled(state)
    models.model.root.Head.ExtraHair:setVisible(state)
end

local hairToggle = actionPage:newAction()
    :title("Longer Hair Toggle")
    :toggleTitle("Longer Hair Toggle")
    :item("minecraft:redstone_block")
    :toggleItem("minecraft:emerald_block")
    :hoverColor(0, 1, 0)
    :setOnToggle(pings.hairToggled)

local squapi = require("SquAPI")
--squishyapi stuff

--i use squishyapi's tail physics for the wings and theres 6 wings so this is gonna be Alot Sorry if ur editing the avatars code </3

--wing parts
local myTail = {
    models.model.rootANOMALY.Body2.Wings.LeftWing,
    models.model.rootANOMALY.Body2.Wings.LeftWing.LeftWingPart,
    models.model.rootANOMALY.Body2.Wings.LeftWing.LeftWingPart.LeftWingEnd,
    models.model.rootANOMALY.Body2.Wings.RightWing,
    models.model.rootANOMALY.Body2.Wings.RightWing.RightWingPart,
    models.model.rootANOMALY.Body2.Wings.RightWing.RightWingPart.RightWingEnd,
    models.model.rootANOMALY.Body2.Wings.LeftUpperWing,
    models.model.rootANOMALY.Body2.Wings.LeftUpperWing.LeftUpperWingPart,
    models.model.rootANOMALY.Body2.Wings.LeftUpperWing.LeftUpperWingPart.LeftUpperWingEnd,
    models.model.rootANOMALY.Body2.Wings.RightUpperWing,
    models.model.rootANOMALY.Body2.Wings.RightUpperWing.RightUpperWingPart,
    models.model.rootANOMALY.Body2.Wings.RightUpperWing.RightUpperWingPart.RightUpperWingEnd,
    models.model.rootANOMALY.Body2.Wings.LeftLowerWing,
    models.model.rootANOMALY.Body2.Wings.LeftLowerWing.LeftLowerWingPart,
    models.model.rootANOMALY.Body2.Wings.LeftLowerWing.LeftLowerWingPart.LeftLowerWingEnd,
    models.model.rootANOMALY.Body2.Wings.RightLowerWing,
    models.model.rootANOMALY.Body2.Wings.RightLowerWing.RightLowerWingPart,
    models.model.rootANOMALY.Body2.Wings.RightLowerWing.RightLowerWingPart.RightLowerWingEnd
}

--wing settings
squapi.tail:new(myTail,
    nil,    --(15) idleXMovement
    nil,    --(5) idleYMovement
    1,    --(1.2) idleXSpeed
    nil,    --(2) idleYSpeed
    nil,    --(2) bendStrength
    nil,    --(0) velocityPush
    nil,    --(0) initialMovementOffset
    1.1,    --(1) offsetBetweenSegments
    nil,    --(.005) stiffness
    nil,    --(.9) bounce
    0,    --(90) flyingOffset
    nil,    --(-90) downLimit
    nil     --(45) upLimit
)

--eye movement
squapi.eye:new(
    models.model.root.Head.Eyes.Pupils,  --the eye element 
    .5,  --(0.25) left distance
    .5,  --(1.25) right distance
    .7,  --(0.5) up distance
    nil   --(0.5) down distance
)