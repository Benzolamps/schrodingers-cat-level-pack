SIGSTRM12GIS             n_Q=                  Signkey.EditorSignaturew�	J����}��������%�3��e�,�8���j�p��}�9��?q�}�!�2c�����&5L��DX���Rt�Ɨ�Y�$�՝Tq匔MB�y�'�6�|B�dil+��U5)�w��0JD}\��Sp��*�)E8F���1S&�#S\�l6^��6�!ۮ�*qI����Ŵ/��0}J?e��-�T���깐'���0�����Ы�z&�4;���_B`�b��g�%�r�ړ蜺�_;=W����﻿local util = worldGlobals.CreateUtil()

RunHandled(
  function()
    Wait(Event(detector4.Activated))
  end,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchPlaying() then return end
    local door1Open = door1:IsOpen()
    local door2Open = door2:IsOpen()
    local door3Open = door3:IsOpen()
    local jammerIn1 = util.ExistEntityInArea("CJammerItemEntity", detector1)
    local jammerIn2 = util.ExistEntityInArea("CJammerItemEntity", detector2)
    local jammerIn3 = util.ExistEntityInArea("CJammerItemEntity", detector3)
    local playerIn1 = util.IsPlayerInArea(detector1)
    local playerIn2 = util.IsPlayerInArea(detector2)
    local playerIn3 = util.IsPlayerInArea(detector3)

    if playerIn1 then
      if not door1Open and not jammerIn1 then
        util.ResetMessage()
        return
      end
    elseif playerIn2 then
      if not door1Open and not door2Open and not jammerIn2 then
        util.ResetMessage()
        return
      end
    elseif playerIn3 then
      if not door2Open and not jammerIn3 then
        util.ResetMessage()
        return
      end
    else
      if not door3Open or not jammerIn3 then
        util.ResetMessage()
        return
      end
    end
  end
)
XF��Tr����ѽV�G�Y�G,��[���}5�>��\��A�w��h�F:��@���W�r�s��q����iD����}��p��2(�:���ӗ�Kߡ��)��K�Sm�����ɐB��X�5�/��L���崨w� �pC*ؠq0�[yu(�_�B|���4I��P����;�Jp��hjM�oL�N/��'-�W>K���D�¯��B�~���}O�WS�n�U�=EX�~ɢ��0d��]�>�/�q��+