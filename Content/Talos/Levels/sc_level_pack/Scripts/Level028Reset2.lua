SIGSTRM12GIS             !��C                  Signkey.EditorSignature� E�����l�e|v�Q�]�\��a9�08�L���V�)�"�j�0Go=XA����Z�w[�}��=�tD����e�����g6�fCU3+�M�����+'���˽%�ȩʟE��_��͐�~�X�op�n9���v�6|�q��n%o�zn��>�:��^�?t <nB��[9���.�{[��}������-�th7]�!{�(�g�����A.��؁Ax�Q��?l��Oe�ؽ����^ ��﻿local util = worldGlobals.CreateUtil()

RunHandled(
  WaitForever,
  OnEvery(Event(detector.Activated)),
  function()
    detector:Recharge()
    if plasmas[1]:IsOpen() or plasmas[2]:IsOpen() then return end
    if util.IsTimeSwitchPlaying() then return end
    if util.ExistEntityInArea("CJammerItemEntity", detector) then return end
    util.ResetMessage()
  end
)
\�V���P��Zm��KV�F�8r��hI��F����iL(�0A��f��qV����y=˖4M�]�,�c9��8��r�������n�x���ւ�pRiᑖ~ŭE�$�dlEEn�s��F����h�'!�f��PoD�a�HV0�D��q��܇m�&{�`op �F�gݭ�e�<z�9�+
l�A�>Ym�kp�#�ګ՗��aM��6�)u0j&IMx�nS���XZ�'ZI��
g�i0>��gk