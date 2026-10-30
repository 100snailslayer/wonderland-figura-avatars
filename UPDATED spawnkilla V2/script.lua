vanilla_model.PLAYER:setVisible(false)
models.model.rootANOMALY:setVisible(false)
models.model.root:setVisible(true)

--action wheel
local Actions = action_wheel:newPage()
action_wheel:setPage(Actions)

function pings.spawnToggled(state)
    models.model.rootANOMALY:setVisible(state)
    models.model.root:setVisible(not state)
end

local anomToggle = Actions:newAction()
    :title("The Spawn Toggle")
    :toggleTitle("The Spawn Toggle")
    :item("minecraft:redstone_block")
    :toggleItem("minecraft:emerald_block")
    :hoverColor(0, 1, 0)
    :setOnToggle(pings.spawnToggled)

function pings.crawlToggled(state)
    function events.tick()
    local walking = player:getVelocity().xz:length() > .01
    local sprinting = player:isSprinting()

    animations.model.idle2:setPlaying(state and not walking)
    animations.model.walk2:setPlaying(state and walking and not sprinting)
    animations.model.sprint2:setPlaying(state and sprinting)
    end
end

local crawlingToggle = Actions:newAction()
    :title("Crawling Toggle (MUST HAVE THE SPAWN TOGGLED)")
    :toggleTitle("Crawling Toggle (MUST HAVE THE SPAWN TOGGLED)")
    :item("minecraft:redstone_block")
    :toggleItem("minecraft:emerald_block")
    :hoverColor(0, 1, 0)
    :setOnToggle(pings.crawlToggled)

function pings.Amb1ping(state)
    sounds:playSound("ambient2", player:getPos())
end

local amb1 = Actions:newAction()
    :title("Ambient Sound 1")
    :item("minecraft:snowball")
    :hoverColor(0, 1, 0)
    :onLeftClick(pings.Amb1ping)

function pings.Amb2ping(state)
    sounds:playSound("ambient3", player:getPos())
end

local amb1 = Actions:newAction()
    :title("Ambient Sound 2")
    :item("minecraft:snowball")
    :hoverColor(0, 1, 0)
    :onLeftClick(pings.Amb2ping)

--squapi stuff i love you squishyapi
local squapi = require("SquAPI")

squapi.arm:new(
    models.model.rootANOMALY.RightArm2.RightArmExt, --element
    .5, --(1) strength
    true, --(false) isRight
    nil  --(true) keepPosition
)
squapi.arm:new(
    models.model.rootANOMALY.LeftArm2.LeftArmExt, --element
    .5, --(1) strength
    nil, --(false) isRight
    nil  --(true) keepPosition
)
squapi.arm:new(
    models.model.rootANOMALY.RightArm2, --element
    .5, --(1) strength
    true, --(false) isRight
    nil  --(true) keepPosition
)
squapi.arm:new(
    models.model.rootANOMALY.LeftArm2, --element
    .5, --(1) strength
    nil, --(false) isRight
    nil  --(true) keepPosition
)

squapi.leg:new(
    models.model.rootANOMALY.LeftLeg2,    --element
    .3,    --(1) strength
    nil,    --(false) isRight
    nil     --(true) keepPosition
)

squapi.leg:new(
    models.model.rootANOMALY.LeftLeg2.LeftLegExt,    --element
    .2,    --(1) strength
    nil,    --(false) isRight
    nil     --(true) keepPosition
)

squapi.leg:new(
    models.model.rootANOMALY.RightLeg2.RightLegExt,    --element
    .2,    --(1) strength
    true,    --(false) isRight
    nil     --(true) keepPosition
)

squapi.leg:new(
    models.model.rootANOMALY.RightLeg2,    --element
    .3,    --(1) strength
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

local myTail = {
    models.model.rootANOMALY.Body2.Tail6,
    models.model.rootANOMALY.Body2.Tail6.Tail7,
    models.model.rootANOMALY.Body2.Tail6.Tail7.Tail8,
    models.model.rootANOMALY.Body2.Tail6.Tail7.Tail8.Tail9,
    models.model.rootANOMALY.Body2.Tail6.Tail7.Tail8.Tail9.Tail10
}

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

squapi.ear:new(
    models.model.rootANOMALY.Head2.cheetahEars2.LeftEar2, --leftEar
    models.model.rootANOMALY.Head2.cheetahEars2.RightEar2, --(nil) rightEar
    .5, --(1) rangeMultiplier
    nil, --(false) horizontalEars
    nil, --(2) bendStrength
    nil, --(true) doEarFlick
    nil, --(400) earFlickChance
    nil, --(0.1) earStiffness
    nil  --(0.8) earBounce
)

--animations
function events.tick()
    local walking = player:getVelocity().xz:length() > .01
    local sprinting = player:isSprinting()

    animations.model.idle:setPlaying(not walking)
    animations.model.walk:setPlaying(walking and not sprinting)
    animations.model.sprint:setPlaying(sprinting)
end

squapi.crouch(
    animations.model.crouch, --crouch
    nil, --(nil) uncrouch
    animations.model.crawl, --(nil) crawl
    nil  --(nil) uncrawl
)