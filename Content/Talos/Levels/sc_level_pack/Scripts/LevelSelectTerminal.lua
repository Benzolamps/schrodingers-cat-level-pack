worldInfo:ActivateTimer(0)

local util = worldGlobals.CreateUtil(worldInfo)

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

if (terminal == util.terminal) then
  -- create temporal chapter, prevent not saving the level
  local curr = worldInfo:GetCurrentChapter()
  local temp = SpawnEntityByClass(worldInfo, curr:GetPlacement(), "CChapterInfoEntity")
  temp:Start()
  Wait(Delay(0.1))
  curr:Start()
  terminal:EnableASCIIAnimation(true)
end

local finished = false

RunHandled(
  WaitForever,
  OnEvery(Event(terminal.Started)),
  function ()
    if terminal == util.terminal and not finished then
      finished = true
      terminal:EnableASCIIAnimation(false)

      -- calculate the time
      local time = worldInfo:GetTimePassedFromTimer()
      local str
      -- judge if it is new record
      if util.currentLevel.GetLevelTime() <= 0 or time < util.currentLevel.GetLevelTime() then
        util.currentLevel.SetLevelTime(time)
        str = string.format(util.strings.CongratulationsNewRecord, mthFloorF(time * 100) / 100)
      else
        str = util.strings.Congratulations
      end
      print(str)
      terminal:AddString(str)
      util.currentLevel.SetLevelRead(true)
    end
  end,

  -- loading the level
  On(CustomEvent(terminal, "TerminalEvent_0")),
  function ()
    local level = util.levels[talosProgress:GetCodeValue("Level")]
    terminal:AddString(string.format(util.strings.Opening, level.levelFile))
    print(string.format(util.strings.Opening, level.levelFile))
    Wait(Delay(2))
    worldInfo:StartLevel(level.levelFile)
  end,

  -- level record
  OnEvery(CustomEvent(terminal, "TerminalEvent_1")),
  function ()
    local str
    if (util.currentLevel.GetLevelTime() > 0) then
      str = string.format(
        util.strings.LevelRecordInfo,
        util.currentLevel.levelTitle,
        util.currentLevel.neededMechanics,
        util.currentLevel.levelFile,
        util.currentLevel.GetLevelTime()
      )
    else
      str = string.format(
        util.strings.LevelRecordInfoNotFinish,
        util.currentLevel.levelTitle,
        util.currentLevel.neededMechanics,
        util.currentLevel.levelFile
      )
    end
    print(str)
    terminal:AddString(str .. [[<span class="strong">&gt;&gt;&gt; </span>]])
  end,

  -- close the fences and barriers
  On(Event(terminal.Stopped)),
  function ()
    if terminal == util.terminal then
      if fences then
        fences:Open()
      end
      if barriers then
        barriers:Disable()
      end
    end
  end
)
