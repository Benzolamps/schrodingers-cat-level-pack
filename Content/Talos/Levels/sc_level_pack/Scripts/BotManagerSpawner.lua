-- botManager : CPlayerBotManagerEntity
local botManager = worldInfo:GetEntityByName("BotManager")
local markers = worldInfo:GetAllEntitiesOfClass("CNPCSpawnMarkerEntity")
for _, marker in ipairs(markers) do
  -- player : CPlayerBotPuppetEntity
  local player
  if string.find(marker:GetName(), "WhiteGhost") == 1 then
    player = botManager:SpawnGhostNPC("White Ghost", marker)
  elseif string.find(marker:GetName(), "BlackGhost") == 1 then
    player = botManager:SpawnGhostNPC("Black Ghost", marker)
  end
  player:SetCharacterName('Test Bot ' .. string.sub(marker:GetName(), 11))
  RunAsync(function ()
    local carriedItem
    RunHandled(
      function ()
        Wait(Event(player.Died))
        if carriedItem ~= nil then
          carriedItem:SetPlacement(player:GetPlacement())
        end
      end,
      OnEvery(Event(player.ObjectGrabbed)),
      function ()
        carriedItem = player:GetCarriedItem()
      end,
      OnEvery(Event(player.ObjectDropped)),
      function ()
        carriedItem = nil
      end
    )
  end)
end