SIGSTRM12GIS             ����                  Signkey.EditorSignature8�Y����L��J�6��P)v����u���p����*�H�M�n�j���{Ce	A�[��F�S�8��]�#��QO���Z��%�'L�eM����������r�� �0�C3���:�h���~�H:~E��t�`خT�4�����y�b*���m���c��� Ԉ1V84q�׈c����&��W�U����xh�[f6��qe풇WP�K��Ϯ�'�����W�=M�g�=�b��/z���@V>�K��﻿local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if red:IsChargedUp() then return end
    if util.IsTimeSwitchActive() then return end
    local itemCount = util.EntityCountInArea("CCarriableItemEntity", entityDetector)
    local jammerCount = util.EntityCountInArea("CJammerItemEntity", entityDetector)
    if itemCount == jammerCount then return end
    if detectors[1]:IsActivated() or detectors[2]:IsActivated() then
      detectors[1]:Recharge()
      detectors[2]:Recharge()
      return
    end
    util.ResetMessage()
  end
)
	����w��]�n{�aL7�FP����+���f��F�)�����aY�!X{r29���I�ɟt��!g'@ѵ�^��L�n�N-0�iX�r�F�?rI۳e�,���gu���|��/e�L������Q�����ݿh�$�H�o��]V��zV����"b�᫰��U ��H�ȷ���v+('8 �C��1v����d�_x�p{]/�cƇ�� ��[&��̈&g'$.5�۳�aڝ����{�