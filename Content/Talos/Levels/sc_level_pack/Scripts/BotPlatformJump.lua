local util = worldGlobals.CreateUtil()

Wait(Delay(0.1))
local bot = worldInfo:GetAllEntitiesOfClass('CPlayerBotPuppetEntity')[1]
local player
local po = marker2:GetPlacement()
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
  function ()
    if not util:IsTimeSwitchPlaying() then
      return
    end
    if player == nil or IsDeleted(player) then
      return
    end
    if bot == nil or IsDeleted(bot) or worldInfo:GetDistance(bot, marker1) > 1 then
      return
    end
    marker2:SetPlacement(po)
    local pPlayer = player:GetPlacement()
    if not detector:IsPointInArea(pPlayer:GetVect(), 0.5) then
      return
    end
    local platforms = worldInfo:GetAllEntitiesOfClass("CTalosShieldItemEntity")
    for _, p in ipairs(platforms) do
      local pPlatform = p:GetActualPlacement()
      if pPlatform == pPlayer then
        pPlayer.vy = pPlayer.vy + 2
        marker2:SetPlacement(pPlayer)
      end
    end
  end
)
