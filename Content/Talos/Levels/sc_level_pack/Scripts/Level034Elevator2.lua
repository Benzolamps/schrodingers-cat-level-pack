SIGSTRM12GIS             _(��                  Signkey.EditorSignature����@��H+��� �N����ܴ�Iώ9���{ef�C����;ia�,ImK/#�/�&茑=^���>��3�ֶ'���o���ڨn�G8�r�uZ�^p��`.�b��������f��OUdEˤ(n��W �X�SU$�hWx�ǀ���z��˾�6��_gBE�}� r@N�i�K�TωԹ�o����x1�d{-���j_�����#�,Nt�'@�a�l=��cq���"��>T�Y���� '����4��h﻿RunHandled(
  WaitForever,
  OnEvery(Event(receiver.ChargedUp)),
  function()
    for i, elevator in ipairs(elevators) do
      elevator:MoveToDestinationEntity(markersEnd[i])
    end
  end,
  OnEvery(Event(receiver.Reset)),
  function()
     for i, elevator in ipairs(elevators) do
      elevator:MoveToDestinationEntity(markersStart[i])
     end
  end
)
�Hg_�e���y�GФ|[wT0�#���5x]�Ήo���k}jC��-x�+H�>DH�G���F�_#%��ؓ�-8�oWXf��U����v���If�&ӕ��0��+t�;M"
�>w��:W�>V�kV���۽
\�8z��I��nR��Z~d�*��k>���)���F�B����c�d����Z�e����P���{�b+�Q ����Ejev��e��WR��.˅y�7�� ��E��M�pS��rN�q�5�