SIGSTRM12GIS             �9a-                  Signkey.EditorSignaturem��ȓ��jf�=���d�֛M���E՝���p�w�
�]�|���9�#򙌑�9= x]�¦Лe�$�A���ASR�V�j4-��J:��\��̞�ĳ�"f�Թ �ܥ0��uN��i>�/o�w�F�[�H�0s;��@��Asr
�v���jb��HP�˚qmգ��'�vmQ'���L�r��M�$�ce�!�P�����ݏq������7���v����2~hA7n�Ero����l�X��!�﻿RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if detector:IsPointInArea(mine1:GetPlacement():GetVect(), 0.5) and mine1:GetLinearVelocity().z <= 0 then
      switch1:Activate()
    else
      switch1:Deactivate()
    end
    if detector:IsPointInArea(mine2:GetPlacement():GetVect(), 0.5) and mine2:GetLinearVelocity().z >= 0 then
      switch2:Activate()
    else
      switch2:Deactivate()
    end
    if switch1:IsActivated() and switch2:IsActivated() then
      marker1:SetPlacement(mthQuatVect(mthEulerToQuaternion(mthVector3f(0, 0, 0)), mthVector3f(-60, 0, -1)))
      marker2:SetPlacement(mthQuatVect(mthEulerToQuaternion(mthVector3f(0, 0, 0)), mthVector3f(-60, 0, 1)))
    end
  end,
  On(Event(switch.Activated)),
  function()
    mine1:SetPlacement(marker3:GetPlacement())
    mine2:SetPlacement(marker4:GetPlacement())
  end
)
�p���ل41��M�M���;S/S��zr<�qK@��S��O�2!��,.�()RN��z�Z��i�8����ש`�ӟT�F�F9���j�Ӱ	�B{Ӂ����񐿏,0�(l|�����d�m��̗���X��`�ڲq'���y7��"2S6qط�����[�������F�7xi����4���3 �A���5��\�|��%����O��]Z;1 ��C`����1��*�A�Ngaޕ��WN�іq�S�M{U