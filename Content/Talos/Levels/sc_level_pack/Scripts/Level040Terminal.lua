SIGSTRM12GIS             �[�O                  Signkey.EditorSignatureR�s�DW��ޯZ.�jNB>����VP�-4���Ș@թP7����&�'�{��z�`�-�!���l㲋{h��/"6�v:�s�;��z����1��1*���@Z.���N��9��,@#��g�EXj��|�q��lC�8�☇D4�"��R�������������i�)e�/r�A�Y����:´Z�pvR���]����p ��dpdc����-�`8����ADro�,�zQ	l?�~c���{� p��﻿local util = worldGlobals.CreateUtil()

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)


RunHandled(

WaitForever,

  -- reset the code
  OnEvery(CustomEvent(terminal, "TerminalEvent_6")),
  function()
    print(talosProgress:GetCodeValue("Code_AC_Current"))
    talosProgress:SetCode("Code_AC_Code", 666666)
  end,
-- code accepted
  OnEvery(CustomEvent(terminal, "TerminalEvent_7")),
  function()
 print(talosProgress:GetCodeValue("Code_AC_Current"))
  end
)
m���'rf�}�wP��w]G��7�7.�{�QִR\�U��j�f��7*����|����,&(QOc��#s=�j��o��?~.+ф��[�w*J�ov{*p\��0�(M�d[.N#�e3�ը�������t��H�^��\BFm�w�X(�Iu�����ɐ|�� ,4E#�^i�F�E�J�g� �'!v���X��t*T�����XY��言Z,wq57�(�薘�7���F�+�9.=�fuQ�2��E��s��̇