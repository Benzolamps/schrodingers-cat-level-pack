SIGSTRM12GIS             fӶ�                  Signkey.EditorSignatureq
��{���䂫�Q*�M�U�t:+��+N
�-m��������D�c
]�|�R�!��D��*��X���������e3���l|�oEVX7�n�d��k�����Ё��")��I��K�r���p�7�|! �+aZ�c�N{�>�ܜ��H���
gɉ��7���rj(���L����֡�zm�����AI9h�׌~��>����:qڝuG1��'����qפD���;�s}(}�7.�u���q8CW��Y�﻿-- botManager : CPlayerBotManagerEntity
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
        Wait(Delay(3))
        player:StartFadingOut(1)
        Wait(Delay(1.5))
        player:Delete()
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
E`CW�jܖ����׺�y�Ⱥ-�UK��	z7p6���2fCo��)_�qG�߰&�b���ᆸ˳o�w3���@�m��3�k�X� {]%|������(�3T�~�[��˗k�oS��we�4�9�n�3�rN�z���#WY,,1R��n��=��F��֮�K�oUĦyQ��+��oo�tC/3�mQ��q�O�b�M+�7�.�@e�)ǘ�F�<�~�_+�qY�eI}E2��3��g��o�6�