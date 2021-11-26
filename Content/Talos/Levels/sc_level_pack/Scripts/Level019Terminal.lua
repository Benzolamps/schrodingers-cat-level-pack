local util = worldGlobals.CreateUtil(worldInfo)

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

--- 获取阶段 1-A 2-B 3-C
--- @return number 阶段
local function GetStage()
  return talosProgress:GetCodeValue("Code_TS_Stage")
end

--- 设置阶段
--- @param stage number 阶段
local function SetStage(stage)
  if corIsAppEditor() then
    print('stage: ' .. stage)
  end
  talosProgress:SetCode("Code_TS_Stage", stage)
end

--- 获取密码
--- @return number 密码
local function GetCode()
  return talosProgress:GetCodeValue("Code_TS_Code")
end

--- 设置密码
--- @param code number 密码
local function SetCode(code)
  if corIsAppEditor() then
    print('code: ' .. code)
  end
  talosProgress:SetCode("Code_TS_Code", code)
  talosProgress:SetCode("Code_TS_CodePrefix", code / 10000)
  talosProgress:SetCode("Code_TS_CodeSuffix", code % 1000)
end

--- 获取密码是否已读 0-未读 1-已读 2-(在记录状态下为未读, 由记录状态转变为播放状态时转为已读)
--- @return number 是否已读
local function GetCodeRead()
  return talosProgress:GetCodeValue("Code_TS_CodeRead")
end

--- 设置密码是否已读
--- @param codeRead number 是否已读
local function SetCodeRead(codeRead)
  if corIsAppEditor() then
    print('codeRead: ' .. codeRead)
  end
  talosProgress:SetCode("Code_TS_CodeRead", codeRead)
end

--- 设置正在记录
--- @param recording boolean 是否正在记录
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

-- 初始化
--- 缓存的密码
local cacheCode = 0
SetStage(1)
SetCode(mthRndRangeL(100000, 999999))
SetCodeRead(0)
SetRecording(false)

RunHandled(
  function()
    Wait(All(Events(doors.Unlocked)))
  end,
  -- 开始记录, 缓存当前密码, 设置状态
  OnEvery(CustomEvent("TimeSwitchRecordingStarted")),
  function()
    cacheCode = GetCode()
    SetRecording(true)
  end,
  -- 结束记录, 设置状态
  OnEvery(CustomEvent("TimeSwitchRecordingEnded")),
  function()
    SetRecording(false)
  end,
  -- 记录中断, 清空缓存
  OnEvery(CustomEvent("TimeSwitchRecordingAborted")),
  function()
    cacheCode = 0
  end,
  -- 开始播放, 将当前密码设置为缓存的密码, 将是否已读由2变1
  OnEvery(CustomEvent("TimeSwitchPlayingStarted")),
  function()
    SetCode(cacheCode)
    if GetCodeRead() == 2 then
      SetCodeRead(1)
    end
  end,
  -- 重置密码
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
  -- 密码正确
  OnEvery(CustomEvent(terminal, "TerminalEvent_7")),
  function()
    doors[GetStage()]:Open()
    SetStage(GetStage() + 1)
    cacheCode = 0
    SetCodeRead(0)
    SetCode(mthRndRangeL(100000, 999999))
  end
)
