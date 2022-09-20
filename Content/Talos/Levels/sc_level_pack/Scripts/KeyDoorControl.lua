SIGSTRM12GIS             Q#>�                  Signkey.EditorSignature�p\��8�V�bp5u���5u�\?[	�g	���]���rv]ʛdN�L� U���	��@�>x��x�Tpf.tq����4;oW�A��sÅyYL��~���w�� ��7����J�NRA`�X�Z)k�S5�;#��r���rCHW��Wl)��:zBhY՟��0g�╥W����pd>8bP�DtM�e�g'�
�+Β�������Np�׊��L
�'P���%穝�1�W�HQ���v>N�J﻿local function bindKeyWithDoor(key, door)
  local keyPicked = false
  local doorOpened = false
  local aggregator = SpawnEntityByClass(worldInfo, worldInfo:GetPlacement(), "CKeyAggregatorEntity")
  aggregator:ShowHudInfo(true)
  aggregator:AddKey(key)
  door:AssureLocked()
  door:EnableUsage()
  door:EnableLookedAtNotification()
  RunAsync(function()
    RunHandled(
      WaitForever,
      OnEvery(Event(key.Picked)),
      function()
        keyPicked = true
        door:Unlock()
      end,
      OnEvery(Event(door.Used)),
      function()
        if (keyPicked) then
          doorOpened = true
          door:DisableUsage()
          Wait(Delay(0.5))
          aggregator:ShowHudInfo(false)
        else
          door:DisableUsage()  
          Wait(Delay(3.5))
          door:EnableUsage()
        end
      end)
  end)
end

if key and door then
  bindKeyWithDoor(key, door)
end

if not keysAndDoors then return end

local key, door

for _, entity in ipairs(keysAndDoors) do
  if entity:GetClassName() == "CDoorEntity" then
    door = entity
    bindKeyWithDoor(key, door)
  else
    key = entity
  end
end
lF���X[ռ[�3�ˁĳ9x���(�ꅁ�hf5����t;^t�X֩���;���IAW鏏"�V>>�c���T7��@�����-4�>��EZ����f���V>���-��O@c@�
W���/uo{=f��hB��d�S����q��z����z������4B��'����ITΓ�e=�9�B?�1	��]������9c|DB�^��6gA�@
�xI�$B	��͛���LQ������~���/�>