local player

local util = worldGlobals.CreateUtil()

local po = marker:GetPlacement()

RunHandled(
  WaitForever,
  OnEvery(CustomEvent("TimeSwitchPlayingStarted")),
  function ()
    local pastPlayers = worldInfo:GetAllEntitiesOfClass("CPastPlayerPuppetEntity")
    local distance = 1000
    for _, p in ipairs(pastPlayers) do
      local d = worldInfo:GetDistance(timeSwitch, p)
      if d < distance then
        distance = d
        player = p
      end
    end
  end,
  OnEvery(Delay(0.1)),
  function (e)

    if not util:IsTimeSwitchPlaying() then return end
    if player == nil or IsDeleted(player) then return end
    local pPlayer = player:GetPlacement()
    if not detector:IsPointInArea(pPlayer:GetVect(), 0.5) then return end
    local platforms = worldInfo:GetAllEntitiesOfClass("CTalosShieldItemEntity")
     for _, p in ipairs(platforms) do
       local pPlatform = p:GetActualPlacement()
       if pPlatform == pPlayer then
         pPlayer.vy = pPlayer.vy + 2
         marker:SetPlacement(pPlayer)
      end
    end
  end
)
