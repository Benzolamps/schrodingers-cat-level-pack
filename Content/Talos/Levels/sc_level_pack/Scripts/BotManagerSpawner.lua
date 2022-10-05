local util = worldGlobals.CreateUtil()

local markers = worldInfo:GetAllEntitiesOfClass("CNPCSpawnMarkerEntity")
for _, marker in ipairs(markers) do
  -- player : CPlayerBotPuppetEntity
  local name = string.sub(marker:GetName(), 1, 4)
  local player = botManager:SpawnGhostNPC(name, marker)
  player:SetCharacterName("Test Bot " .. string.sub(marker:GetName(), 6))
  RunAsync(function ()
    local carriedItem
    RunHandled(
      function ()
        Wait(Event(player.Died))
        if carriedItem ~= nil and not IsDeleted(carriedItem) then
          carriedItem:SetPlacement(player:GetPlacement())
        end
        Wait(Delay(3))
        player:StartFadingOut(1)
        Wait(Delay(1.5))
        if not util.IsTimeSwitchPlaying() then
          player:Delete()
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
