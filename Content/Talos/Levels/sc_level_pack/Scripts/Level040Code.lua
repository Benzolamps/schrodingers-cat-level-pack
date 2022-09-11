SIGSTRM12GIS             �g��                  Signkey.EditorSignature��{�MJ�K��4�����?�9d�)B�7�V�E"�Y~\���ے��͌'�m<��a�/��6t����'f\5[��H2������N����6\ʭ̟� �T��B�JԯS�4����U�7��m05�z��i�!ꯎ1�^PIGo�+~�����P��i�ͻnI�/5�%��q����{��z��t
L}��0d�C��!��MIx���ޠT�m�O������}�{s�-,%4�+�P� 1I~��h﻿local function GetRandomData()
  local t = { 1, 2, 3, 4, 5, 6 }
  local tr = {}
  while #t > 0 do
    local index = mthRndRangeL(1, #t)
    table.insert(tr, t[index])
    table.remove(t, index)
  end
  return tr, tonumber(tr[1] .. tr[2] .. tr[3] .. tr[4] .. tr[5] .. tr[6])
end

local listA, codeA = GetRandomData()
local listB, codeB = GetRandomData()
local listC, codeC = GetRandomData()
local listD, codeD = GetRandomData()

local codes = { codeA, codeB, codeC, codeD }
local names = { 'A', 'B', 'C', 'D' }

-- puzzle a
;
(function()
  for i = 1, 6 do
    receivers[i]:SetPlacement(markersA[listA[i]]:GetPlacement())
  end
end)()

-- puzzle b
;
(function()
  local fans = worldInfo:GetAllEntitiesOfClass('CFanEntity')
  for i = 1, #fans do
    local shouldHide = true
    local pFan = fans[i]:GetPlacement()
    for j = 1, 6 do
      if 
        fans[i]:GetName() == "Fan00" .. j
        and worldInfo:GetDistance(fans[i], markersB[listB[j]]) == 16
      then
        shouldHide = false
        break
      end
    end
    if shouldHide then
      fans[i]:Delete()
    end
  end
end)()

-- puzzle c
;
(function()
  local listNumbers = {}
  for i = 10, 99 do
    table.insert(listNumbers, i)
  end
  for i = 1, 6 do
    local index = mthRndRangeL(1, #listNumbers)
    listNumbers[i], listNumbers[index] = listNumbers[index], listNumbers[i]
  end
  listNumbers = { listNumbers[1], listNumbers[2], listNumbers[3], listNumbers[4], listNumbers[5], listNumbers[6] }
  table.sort(listNumbers)
  local numberMoved = false  
  for i = 1, 6 do
    local prressure = pressures[listC[i]]
    local marker1 = markersC[2 * listC[i] - 1]
    local marker2 = markersC[2 * listC[i]]
    local number = listNumbers[6 - i + 1]
    local number1 = mthFloorF(number / 10)
    local number2 = mthFloorF(number % 10)
    local number1M = numberModels[number1 + 1]
    local number2M = numberModels[number2 + 11]
    print(listC[i], number, number1, number2)
        RunAsync(function()
    RunHandled(
        WaitForever,
        OnEvery(Event(prressure.Pressed)),
        function()
          if not numberMoved then
            numberMoved = true
            number1M:SetPlacement(marker1:GetPlacement())
            number2M:SetPlacement(marker2:GetPlacement())
          end
        end,
        OnEvery(Event(prressure.Released)),
        function()
          numberMoved = false
        end  
      )end
      )
  end
end)()

-- puzzle d
;
(function()
  local index = 7

  for i = 1, 6 do
    RunAsync(function()
      RunHandled(
        WaitForever,
        OnEvery(Event(switches[i].Activated)),
        function()
          if (listD[index - 1] ~= i) then
            index = 7
            switches:Deactivate()
          else
            index = index - 1
          end
        end,
        OnEvery(Event(switches[i].Deactivated)),
        function()
          index = 7
          switches:Deactivate()
        end
      )
    end)
  end
end)()

-- terminal
;
(function()
  -- talosProgress : CTalosProgress
  local talosProgress = nexGetTalosProgress(worldInfo)

  print(codeA, codeB, codeC, codeD)

  talosProgress:ClearVar("Code_AC_Message_Read")
  for i = 1, 4 do
    talosProgress:ClearVar("Code_AC_Door" .. string.char(string.byte('@') + i) .. "_Unlocked")
  end

  RunHandled(
    WaitForever,
  -- reset the code
    OnEvery(CustomEvent(terminal, "TerminalEvent_6")),
    function()
      local index = talosProgress:GetCodeValue("Code_AC_Current")
      talosProgress:SetCode("Code_AC_Code", codes[index])
    end,
  -- code accepted
    OnEvery(CustomEvent(terminal, "TerminalEvent_7")),
    function()
      local index = talosProgress:GetCodeValue("Code_AC_Current")
      doors[index]:Open()
      talosProgress:SetVar("Code_AC_Door" .. string.char(string.byte('@') + index) .. "_Unlocked")
    end
  )
end)()
T��a�Sj�B�'N!ʞ����Y�������~"��Q���ۍ�B��}�u�7woi���Wxm�h����L�ΩB��jK�r�D�m3�Nr� ��%K.���T�I�$t�B|U{Y=/E��q��8G�p�,�!��S����Nh��(��렍7�p9�>-+�2��rbao��>
�_u��h�H�(3�7:�G�Cg9�h����tən�I�������Y��@ow�,꺱��?d�E���~}��yC՘