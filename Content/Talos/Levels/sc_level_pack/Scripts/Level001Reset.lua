SIGSTRM12GIS             �X}�                  Signkey.EditorSignatureu7
v{٧eS7�~OyF<u�#vTw��	�*�҂W���:͹ϛFWN�q��Iȩoo����*g�ZӀ�s�Q<$�\���o�5�5�G(?a �he洐H��ٔ��%랄ez�L�ݯRbT0E'Q)4#G�1�xm-�g�Rc��R&l=7��N�*mIfnV���ˬ0��@v��s\x�K^�)">wS4),���m"lSH��Ò�6N/"S2֪�,U��4�N�h"@�&P��U=��E�cM�<﻿local util = worldGlobals.CreateUtil()

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

RunHandled(
  function ()
    Wait(Any(CustomEvent("Level001CubeFall"), Event(mine.Died)))
    turret = nil
  end,
  OnEvery(Any(Events(detectors.Activated))),
  function ()
    detectors:Recharge()
    if not turret or turret:IsEnabled() then return end
    if not util.ExistEntityInArea("CJammerItemEntity", detectorJammer) then
      util.ResetMessage()
    end
  end
)
P	4�O��{��0U��{e���"�-b[�&��e��թ
mh�4��H�<����gx�\�ΝO�fh1UD�����鿚u�a����|���Rt��[|�s[�t3�K��[B�Y��Ķد8���a[�Iy���m�{��ğO\��h}[������'��l��~��d1�%�X�Y��U���>Q��*t�cQ ��/��c���ߍ�^×�Y��4�-��#��o1i��a
��z,L��L�#��\�H&�{i��S