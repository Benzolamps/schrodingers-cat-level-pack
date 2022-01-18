local util = worldGlobals.CreateUtil()

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

--- get the stage 1-A 2-B 3-C
--- @return number stage
local function GetStage()
  return talosProgress:GetCodeValue("Code_TS_Stage")
end

--- set the stage
--- @param stage number stage
local function SetStage(stage)
  if corIsAppEditor() then
    print('stage: ' .. stage)
  end
  talosProgress:SetCode("Code_TS_Stage", stage)
end

--- get the code
--- @return number code
local function GetCode()
  return talosProgress:GetCodeValue("Code_TS_Code")
end

--- set the code
--- @param code number code
local function SetCode(code)
  if corIsAppEditor() then
    print('code: ' .. code)
  end
  talosProgress:SetCode("Code_TS_Code", code)
  talosProgress:SetCode("Code_TS_CodePart_1", code / 1000 % 10)
  talosProgress:SetCode("Code_TS_CodePart_2", code / 10000)
  talosProgress:SetCode("Code_TS_CodePart_3", code % 1000)
end


--- get the code part 1 2 3
--- @return number stage
local function GetCodePart()
  return talosProgress:GetCodeValue("Code_TS_Part")
end

--- set the stage
--- @param part number stage
local function SetCodePart(part)
  if corIsAppEditor() then
    print('part: ' .. part)
  end
  talosProgress:SetCode("Code_TS_Part", part)
end

--- get the code part 1 2 3
--- @return number stage
local function GetCodeParts()
  return talosProgress:GetCodeValue("Code_TS_Parts")
end

--- set the stage
--- @param parts number stage
local function SetCodeParts(parts)
  if corIsAppEditor() then
    print('parts: ' .. parts)
  end
  talosProgress:SetCode("Code_TS_Parts", parts)
end

--- get the code read 0-unread 1-read 2-(unread during recording, change to read when playing started)
--- @return number code read
local function GetCodeRead()
  return talosProgress:GetCodeValue("Code_TS_CodeRead")
end

--- set the code read
--- @param codeRead number code read
local function SetCodeRead(codeRead)
  if corIsAppEditor() then
    print('codeRead: ' .. codeRead)
  end
  if codeRead ~= 1 then
    if codeRead == 0 then
      SetCodeParts(0)
    elseif codeRead == 2 then
      if (GetCodeRead() ~= 2) then
        SetCodeParts(mthOr(GetCodeParts(), mthPow2F(GetCodePart() - 1)))
      end
    end
    if GetCodePart() == 3 then
      SetCodePart(1)
    else
      SetCodePart(GetCodePart() + 1)
    end
  end
  talosProgress:SetCode("Code_TS_CodeRead", codeRead)
end

--- set recording
--- @param recording boolean recording
local function SetRecording(recording)
  if corIsAppEditor() then
    print('recording: ' .. tostring(recording))
  end
  if recording then
    talosProgress:SetVar("Code_TS_Recording")
  else
    talosProgress:ClearVar("Code_TS_Recording")
  end
end

-- init data
--- cache code
local cacheCode = 0
SetStage(1)
SetCode(mthRndRangeL(100000, 999999))
SetCodePart(mthRndRangeL(1, 3))
SetCodeRead(0)
SetRecording(false)

RunHandled(
  function()
    util.WaitTerminal()
    SetStage(4)
  end,
  -- start recording, cache current code, set recording
  OnEvery(CustomEvent("TimeSwitchRecordingStarted")),
  function()
    cacheCode = GetCode()
    SetRecording(true)
  end,
  -- end recording, set not recording
  OnEvery(CustomEvent("TimeSwitchRecordingEnded")),
  function()
    SetRecording(false)
  end,
  -- recording aborted, clear the cache
  OnEvery(CustomEvent("TimeSwitchRecordingAborted")),
  function()
    cacheCode = 0
    if GetCodeRead() == 2 then
      SetCodeRead(0)
    end
  end,
  -- playing started, assign cache code to current code, code read 2 to 1
  OnEvery(CustomEvent("TimeSwitchPlayingStarted")),
  function()
    SetCode(cacheCode)
    if GetCodeRead() == 2 then
      SetCodeRead(1)
    end
  end,
  -- reset the code
  OnEvery(CustomEvent(terminal, "TerminalEvent_6")),
  function()
    if (GetStage() == 1) then
      SetCodeRead(1)
    else
      SetCode(mthRndRangeL(100000, 999999))
      if (util.IsTimeSwitchRecording()) then
        SetCodeRead(2)
      else
        SetCodeRead(0)
      end
    end
  end,
  -- code accepted
  OnEvery(CustomEvent(terminal, "TerminalEvent_7")),
  function()
    doors[GetStage()]:Open()
    SetStage(GetStage() + 1)
    cacheCode = 0
    SetCodeRead(0)
    SetCode(mthRndRangeL(100000, 999999))
  end
)
