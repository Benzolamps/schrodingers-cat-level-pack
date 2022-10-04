local function GetRandomData()
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

if corIsAppEditor() then
  print(codeA, codeB, codeC, codeD)
end

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
    local shouldDelete = true
    for j = 1, 6 do
      if
        fans[i]:GetName() == "Fan_" .. j
        and worldInfo:GetDistance(fans[i], markersB[listB[j]]) <= 16
      then
        shouldDelete = false
        break
      end
    end
    if shouldDelete then
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
  local numberModels = worldInfo:GetAllEntitiesOfClass('CStaticModelEntity')
  for i = 1, #numberModels do
    local shouldDelete = true
    for j = 1, 6 do
      local number = listNumbers[6 - j + 1]
      local number1 = mthFloorF(number / 10)
      local number2 = mthFloorF(number % 10)
      local name = numberModels[i]:GetName()
      if worldInfo:GetDistance(numberModels[i], markersC[listC[j]]) <= 5 then
        if name == "Number_" .. number1 or name == "Number_" .. (number2 + 10) then
          shouldDelete = false
        end
      end
    end
    if shouldDelete then
      numberModels[i]:Delete()
    end
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
  -- generate hint
  local util = worldGlobals.CreateUtil()

  local doorAHint = TranslateString("TTRS:ScLevelPack.CodeAC.DoorAHint=From fast to slow   ")
  local doorBHint = TranslateString("TTRS:ScLevelPack.CodeAC.DoorBHint=From high to low    ")
  local doorCHint = TranslateString("TTRS:ScLevelPack.CodeAC.DoorCHint=From big to small   ")
  local doorDHint = TranslateString("TTRS:ScLevelPack.CodeAC.DoorDHint=From present to past")
  local str = TranslateString('ScLevelPack.codeAC.From=\nFrom: anonymous\n')
    .. util.FormatString(TranslateString('ScLevelPack.codeAC.To=To: %1\n\n'), util.player:GetPlayerName())
    .. TranslateString('ScLevelPack.codeAC.TopSecret=Top secret, burn after reading.\n\n')
    .. '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n'
    .. '▓▓ A. ' .. doorAHint .. ' ▓▓\n'
    .. '▓▓ B. ' .. doorBHint .. ' ▓▓\n'
    .. '▓▓ C. ' .. doorCHint .. ' ▓▓\n'
    .. '▓▓ D. ' .. doorDHint .. ' ▓▓\n'
    .. '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n\n'

  -- talosProgress : CTalosProgress
  local talosProgress = nexGetTalosProgress(worldInfo)
  talosProgress:ClearVar("Code_AC_Message_Read")
  for i = 1, 4 do
    talosProgress:ClearVar("Code_AC_Door" .. string.char(string.byte('@') + i) .. "_Unlocked")
  end

  RunHandled(
    WaitForever,
    -- set the code
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
    end,
    -- show hint
    OnEvery(CustomEvent(terminal, "TerminalEvent_8")),
    function()
      terminal:AddString(str .. util.strings.CommonPrompt)
    end
  )
end)()
