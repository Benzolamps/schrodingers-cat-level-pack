SIGSTRM12GIS             �҇
                  Signkey.EditorSignature@"�$OX�
;��m����Z0su�_4�v�����P�F��H��1��\n����ltq���/|}�U�C`iJAM���ά���;����l\_��?wNnz���h�������G�Z�c7�"��x����uqt�C=��+~����R��=�k���A]hb�~�\�S�������x�ND��\�9և_9�X�(&a��vٛe0�� �Jm>D�����h�A�v�YqJ��X0�C����̆�Hؚ�i]C�﻿local util = worldGlobals.CreateUtil()

--- player stuck forever
--- @param detector table
local function PlayerStuck(detector)
  RunHandled(
    WaitForever,
    OnEvery(Event(detector.Activated)),
    function()
      detector:Recharge()
      util.ResetMessage()
    end
  )
end

--- player stuck temporarily
--- @param detector table
local function PlayerStuckTemp(detector)
  RunHandled(
    util.WaitTerminal,
    OnEvery(Event(detector.Activated)),
    function()
      detector:Recharge()
      util.ResetMessage()
    end
  )
end

--- item stuck
--- @param detector table
local function ItemStuck(detector)
  RunHandled(
    util.WaitTerminal,
    OnEvery(Delay(0.1)),
    function()
      if util.IsTimeSwitchActive() then return end
      if not util.ExistEntityInArea("CCarriableItemEntity", detector) then return end
      util.ResetMessage()
    end
  )
end

--- plasma closed, no jammer, player stuck
--- @param entities table
local function PlasmaStuck(entities)
  if not entities then return end
  for i = 1, #entities, 2 do
    local detector = entities[i]
    local plasma = entities[i + 1]
    RunAsync(function ()
      RunHandled(
        WaitForever,
        OnEvery(Event(detector.Activated)),
        function()
          detector:Recharge()
          if plasma:IsOpen() then return end
          if util.IsTimeSwitchPlaying() then return end
          if util.ExistEntityInArea("CJammerItemEntity", detector) then return end
          util.ResetMessage()
        end
      )
    end)
  end
end

--- run detectors
--- @param detectors table
--- @param func function
local function RunDetectors(detectors, func)
  if detectors then
    if not (#detectors > 0) then detectors = {detectors} end
    for _, detector in ipairs(detectors) do
      RunAsync(function() func(detector) end)
    end
  end
end

RunDetectors(detectors1, PlayerStuck)
RunDetectors(detectors2, PlayerStuckTemp)
RunDetectors(detectors3, ItemStuck)
PlasmaStuck(entities)

local minVy = killer and killer:GetPlacement().vy or -5

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchActive() then return end
    local all = worldInfo:GetAllEntitiesOfClass("CCarriableItemEntity")
    for _, entity in ipairs(all) do
      local p = entity:GetActualPlacement()
      if p.vy < minVy then
        util.ResetMessage()
        return
      end
    end
  end
)

>��$`L3�W;�q~��~?/�%Qt�3�۴�|<��-��X@���)gy�� H�;���DL�qޱ�w�z�6��q�x�ao��~�YUT�#y�d)�Qz���o�*��,���KW�G
O�'E���;��Gp����d���q�q�Gȇ&��CPAۆ��A�i-����/�d!`�gI�:�PUQ7(��;����^��A�l<qNV5W��q+���h��h��X۶�<�q5_R�;u����X��Z�خ��e�