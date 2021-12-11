worldInfo:ActivateTimer(0)

local util = worldGlobals.CreateUtil()

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

if terminal == util.terminal then
  -- create a temporary ChapterInfo object to prevent the level from not being saved
  local curr = worldInfo:GetCurrentChapter()
  local temp = SpawnEntityByClass(worldInfo, curr:GetPlacement(), "CChapterInfoEntity")
  temp:Start()
  Wait(Delay(0.1))
  curr:Start()
  terminal:EnableASCIIAnimation(true)

  -- move switch to invisible range
  if switch ~= nil then
    local p = switch:GetPlacement()
    p.vy = -1000
    switch:SetPlacement(p)
  end
end

local finished = false

RunHandled(
  WaitForever,
  OnEvery(Event(terminal.Started)),
  function ()
    if terminal == util.terminal and not finished then
      finished = true
      terminal:EnableASCIIAnimation(false)

      -- calculate level time
      local time = worldInfo:GetTimePassedFromTimer()
      local str
      -- judge if it is new record
      if util.currentLevel.GetLevelTime() <= 0 or time < util.currentLevel.GetLevelTime() then
        util.currentLevel.SetLevelTime(time)
        str = util.FormatString(util.strings.CongratulationsNewRecord, mthFloorF(time * 100) / 100)
      else
        str = util.strings.Congratulations
      end
      terminal:AddString(str)
      util.currentLevel.SetLevelRead(true)
    end
  end,

  -- load the level
  On(CustomEvent(terminal, "TerminalEvent_0")),
  function ()
    local levelIndex = talosProgress:GetCodeValue("Level")
    -- load the level, if not exists, then next level, else the 1st level
    local level
    for key in ipairs(util.levels) do
      if key >= levelIndex then
        level = util.levels[levelIndex]
        break
      end
    end
    level = level or util.levels[1]
    terminal:AddString(util.FormatString(util.strings.Opening, level.levelFile) .. util.strings.CommonPrompt)
    worldInfo:RemoveFromWorldCache(util.currentLevel.levelFile)
    worldInfo:AddToWorldCache(level.levelFile)
    Wait(Delay(2))
    worldInfo:StartLevel(level.levelFile)
  end,

  -- show level record
  OnEvery(CustomEvent(terminal, "TerminalEvent_1")),
  function ()
    local str
    if util.currentLevel.GetLevelTime() > 0 then
      str = util.FormatString(
        util.strings.LevelRecordInfo,
        util.currentLevel.levelTitle,
        util.currentLevel.neededMechanics,
        util.currentLevel.levelFile,
        util.currentLevel.GetLevelTime()
      )
    else
      str = util.FormatString(
        util.strings.LevelRecordInfoNotFinish,
        util.currentLevel.levelTitle,
        util.currentLevel.neededMechanics,
        util.currentLevel.levelFile
      )
    end
    terminal:AddString(str .. util.strings.CommonPrompt)
  end,

  On(Event(terminal.Stopped)),
  function ()
    if terminal == util.terminal then
      -- lower the fences
      if fences ~= nil then
        fences:Open()
      end
      -- disable the barriers
      if barriers ~= nil then
        barriers:Disable()
      end
      -- trigger the switch
      if switch ~= nil then
        if switch:IsActivated() then
          switch:Deactivate()
        else
          switch:Activate()
        end
      end
    end
  end
)
