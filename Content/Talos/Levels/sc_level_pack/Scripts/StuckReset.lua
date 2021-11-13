SIGSTRM12GIS             M#�                  Signkey.EditorSignatureUU��*s�S�/.4����6��2ZBVS�K��j�%m�H���������>QQ/ף�7��{���N)��ц�+r�V�B�/ұ��WBN�!'C�ٛھ'�~��B��ʶ��=wu�mE:�"��c&�.#q�G���FsZ��!�(�������\��ZFԓ�T��n�����A��ό�!���W娸cg2i�&J��A�v��O��v��/��Tw}�Ð*Ʋ���s��֚�9�i�p�z@�TA&W�ԫ:$8� �=��wx�﻿ local util = worldGlobals.CreateUtil(worldInfo)

-- player stuck forever
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

-- player stuck temporal
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

-- item stuck
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

-- plasma stuck
local function PlasmaStuck(entities)
  if not entities then return end
  for i = 1, #entities, 2 do
    local detector = entities[i]
    local plasma = entities[i + 1]
    RunAsync(function ()
      RunHandled(
        util.WaitTerminal,
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

-- run detectors
local function RunDetectors(detectors, func)
  if detectors then
    if not (#detectors > 0) then detectors = {detectors} end
    for i = 1, #detectors do
      RunAsync(function() func(detectors[i]) end)
    end
  end
end

RunDetectors(detectors1, PlayerStuck)
RunDetectors(detectors2, PlayerStuckTemp)
RunDetectors(detectors3, ItemStuck)
PlasmaStuck(entities)
(\|÷�1�p]��,WHއ�M|�H.��ē�	Eᡪh���o���G�"�B {}5��EYA ~QZ:����;;�(k��Ȫ�� e��ֵ�P�W�8�	do���5�M��G�~�c��k�q[g����is_xh[� 
��n�H�� ��KW5�w�<疽p�:��1�J��bs��5���w��?�=�L���#y�@�N�X�2���7O�`�?Pbq���%Θ���פh������_�
y����ؔ؍���m