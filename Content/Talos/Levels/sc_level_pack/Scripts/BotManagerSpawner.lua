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
  player:SetCharacterName('')
end
