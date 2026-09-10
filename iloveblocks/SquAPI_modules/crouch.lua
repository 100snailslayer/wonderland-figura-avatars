---*FUNCTION
---@param crouchAnim Animation The animation to play when you crouch. Make sure this animation is on "hold on last frame" and override.
---@param unCrouchAnim? Animation The animation to play when you unCrouchAnim. make sure to set to "play once" and set to override. If it's just a pose with no actual animation, than you should leave this blank or set to nil.
---@param crawl? Animation Same as crouch but for crawling.
---@param uncrawl? Animation Same as unCrouchAnim but for crawling.
---@return nil
return function(crouchAnim, unCrouchAnim, crawl, uncrawl)
  local oldstate = "STANDING"

  assert(crouchAnim, "§4Your crouch animation is incorrect§c")

  function events.render()
    local pose = player:getPose()
    if pose == "SWIMMING" and not player:isInWater() then pose = "CRAWLING" end

    if pose == "CROUCHING" then
      if unCrouchAnim ~= nil then
        unCrouchAnim:stop()
      end
      crouchAnim:play()
    elseif oldstate == "CROUCHING" then
      crouchAnim:stop()
      if unCrouchAnim ~= nil then
        unCrouchAnim:play()
      end
    elseif crawl ~= nil then
      if pose == "CRAWLING" then
        if uncrawl ~= nil then
          uncrawl:stop()
        end
        crawl:play()
      elseif oldstate == "CRAWLING" then
        crawl:stop()
        if uncrawl ~= nil then
          uncrawl:play()
        end
      end
    end

    oldstate = pose
  end

end

