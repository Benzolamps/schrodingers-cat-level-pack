local util = worldGlobals.CreateUtil()

Wait(Delay(0.1))
local bot = worldInfo:GetAllEntitiesOfClass('CPlayerBotPuppetEntity')[1]
local po = marker:GetPlacement()
RunHandled(
  WaitForever,
  OnEvery(CustomEvent("TimeSwitchPlayingStarted")),
  function()
    local player
    local pastPlayers = worldInfo:GetAllEntitiesOfClass("CPastPlayerPuppetEntity")
    local distance = 1000
    for _, p in ipairs(pastPlayers) do
      local d = worldInfo:GetDistance(timeSwitch, p)
      if d < distance then
        distance = d
        player = p
      end
    end
    BreakableRunHandled(
      function ()
        Wait(CustomEvent("TimeSwitchPlayingEnded"))
      end ,
      OnEvery(Delay(0.1)),
      function()
        if not util:IsTimeSwitchPlaying() then
          return
        end
        if player == nil or IsDeleted(player) then
          return
        end
        if bot == nil or IsDeleted(bot) or bot:GetPlacement().vy > po.vy - 1 then
          BreakRunHandled()
          return
        end
        marker:SetPlacement(po)
        local pPlayer = player:GetPlacement()
        if not detector:IsPointInArea(pPlayer:GetVect(), 0.5) then
          return
        end
        local platforms = worldInfo:GetAllEntitiesOfClass("CTalosShieldItemEntity")
        for _, p in ipairs(platforms) do
          local pPlatform = p:GetActualPlacement()
          if pPlatform == pPlayer then
            pPlayer.vy = po.vy
            marker:SetPlacement(pPlayer)
          end
        end
      end
    )
  end
)
