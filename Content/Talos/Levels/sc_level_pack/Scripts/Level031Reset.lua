SIGSTRM12GIS             �M	                  Signkey.EditorSignature���-�¹�	�2u�s<|�G�q�v���Yu�#`E�0�]��B�Q���<F����WC�d%�w`���;ru)�෠g��,èg5m��q�l�]�#��TÀ���TDꃕ�ǡ3<�rһ\g[L����W�G-V��R+w�Td&@9Cp�ۜ��8���]b�0�2Y�qS�uq��O{�6������ �B��r�xr�Ў�Y�j�SʂW�ؓ%a���#�F��$�r���@��5I�ӄ_�r9��﻿local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    if util.IsTimeSwitchPlaying() then return end
    if util.ExistEntityInArea("CCarriableFanItemEntity", detector) then return end
    util.ResetMessage()
  end
)
\����"W�w�C	� E�:��'x��[K9��A��[�Ͻ��ʡ�2r�P����xnL\�����	�W5G�)�g�$���%,��w�#NG1��qz.�?��j^^`�-cW~Q�ˏ�%����`��N߄b5��? )��Oo���pwv3�^�Q��?�7�'&g��{6UA���ޣ}Y�8����ᐅ��J�o̹�����J�cˊ���m���~��Z���[���{�U���}����g�۩+���}~�����