vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)
models.model.rootDISGUISE:setVisible(false)
models.model.root.Head.Eyes:setPrimaryRenderType("EMISSIVE")

--action wheel
local Actions = action_wheel:newPage()
action_wheel:setPage(Actions)

--action wheel functions
function pings.disguiseToggled(state)
    models.model.rootDISGUISE:setVisible(state)
    models.model.root:setVisible(not state)
end

function pings.invisToggled(state)
    models.model.root:setVisible(not state)
    nameplate.ENTITY:setVisible(not state)
end

function pings.AggroToggled(state)
    animations.model.eyeToggle:setPlaying(state)
    function events.tick()
    local walking = player:getVelocity().xz:length() > .01
    local sprinting = player:isSprinting()

    animations.model.idle2:setPlaying(state and not walking)
    animations.model.aggroRun:setPlaying(state and sprinting)
    end
end

--action wheel toggles
local disguiseToggle = Actions:newAction()
    :title("Steve Disguise Toggle")
    :toggleTitle("Steve Disguise Toggle")
    :item("minecraft:redstone_block")
    :toggleItem("minecraft:emerald_block")
    :hoverColor(0, 1, 0)
    :setOnToggle(pings.disguiseToggled)
local invisToggle = Actions:newAction()
    :title("Invisible Toggle")
    :toggleTitle("Invisible Toggle")
    :item("minecraft:redstone_block")
    :toggleItem("minecraft:emerald_block")
    :hoverColor(0, 1, 0)
    :setOnToggle(pings.invisToggled)
local AggroToggle = Actions:newAction()
    :title("Aggro Toggle")
    :toggleTitle("Aggro Toggle")
    :item("minecraft:redstone_block")
    :toggleItem("minecraft:emerald_block")
    :hoverColor(0, 1, 0)
    :setOnToggle(pings.AggroToggled)
--squishyapi stuff

local squapi = require("SquAPI")

squapi.arm:new(
    models.model.root.LeftArm, --element
    .5, --(1) strength
    nil, --(false) isRight
    nil  --(true) keepPosition
)
squapi.arm:new(
    models.model.root.RightArm, --element
    .5, --(1) strength
    true, --(false) isRight
    nil  --(true) keepPosition
)
squapi.leg:new(
    models.model.root.RightLeg, --element
    .5, --(1) strength
    true, --(false) isRight
    nil  --(true) keepPosition
)
squapi.leg:new(
    models.model.root.LeftLeg, --element
    .5, --(1) strength
    nil, --(false) isRight
    nil  --(true) keepPosition
)

--animations
function events.tick()
    local walking = player:getVelocity().xz:length() > .01
    local sprinting = player:isSprinting()
    local crouching = player:getPose() == "CROUCHING"

    animations.model.idle:setPlaying(not walking)
    animations.model.crouch:setPlaying(crouching)
end

time = 0
function events.tick()
    time = time + 1    
end

function events.tick()
    models.model.root.Body.Animation:setUV(math.floor(time/4)/6,0)
    models.model.root.Head.Animation2:setUV(math.floor(time/4)/6,0)
end