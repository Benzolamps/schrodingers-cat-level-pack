local levels = {}

-- create level
worldGlobals.CreateLevel = function (levelTitle, neededMechanics, levelFile, levelIndex)
  local level = {}
  level.levelTitle = levelTitle
  level.neededMechanics = neededMechanics
  level.levelFile = levelFile
  level.levelIndex = levelIndex
  levels[levelIndex] = level
end

local strings = {
  CommonPrompt = [[<span class="strong">&gt;&gt;&gt; </span>]],
  Congratulations = TranslateString("TTRS:ScLevelPack.Congratulations=Congratulations!\n\n"),
  CongratulationsNewRecord = TranslateString("ScLevelPack.CongratulationsNewRecord=Congratulations! You have a new record:%w2%s0 %1 s\n\n"),
  Opening = TranslateString("TTRS:ScLevelPack.Opening=Opening %1.%w1.%w1.%w1 %w9Done.%w30.\n\n"),
  LevelRecordInfo = TranslateString("TTRS:ScLevelPack.LevelRecordInfo=%1 [%2]\nLevel File: %3\nLevel Best Time: %4 s\n\n"),
  LevelRecordInfoNotFinish = TranslateString("TTRS:ScLevelPack.LevelRecordInfoNotFinish=%1 [%2]\nLevel File: %3\nLevel Best Time: Infinity\n\n")
}

local utilMap = {}

-- create util object
worldGlobals.CreateUtil = function (worldInfo)
  if (utilMap[worldInfo]) then return utilMap[worldInfo] end

  -- get the player
  local player = Wait(Event(worldInfo.PlayerBorn)):GetBornPlayer()

  -- get the terminal
  local terminal = worldInfo:GetEntityByName("TerminalEnd")

  -- talosProgress : CTalosProgress
  local talosProgress = nexGetTalosProgress(worldInfo)

  -- define util
  utilMap[worldInfo] = {
    player = player,
    terminal = terminal,
    levels = levels,
    strings = strings
  }

  local levelFile = worldInfo:GetWorldFileName()
  for _, level in ipairs(levels) do
    level.GetLevelTime = function ()
      return talosProgress:GetCodeValue("Level" .. level.levelIndex .. "_TIME") / 100
    end

    level.SetLevelTime = function (time)
      talosProgress:SetCode("Level" .. level.levelIndex .. "_TIME", time * 100)
    end

    level.SetLevelRead = function (flag)
      if flag then
        talosProgress:SetVar("Level" .. level.levelIndex .. "_READ")
      else
        talosProgress:ClearVar("Level" .. level.levelIndex .. "_READ")
      end
    end

    level.IsLevelRead = function ()
      return talosProgress:GetVar("Level" .. level.levelIndex .. "_READ")
    end

    level.SetLevelRead(level.GetLevelTime() > 0)
    if levelFile == level.levelFile then
     utilMap[worldInfo].currentLevel = level
     talosProgress:SetCode("Level", utilMap[worldInfo].currentLevel.levelIndex)
    end
  end

  -- wait while
  utilMap[worldInfo].FormatString = function (str, ...)
    for i, v in ipairs({...}) do
      if (string.find(str, '%%' .. i)) then
        str = string.gsub(str, '%%' .. i, tostring(v))
      end
    end
    return str
  end

  -- wait while
  utilMap[worldInfo].WaitWhile = function (predicate)
    while predicate() do
      Wait(Delay(0.1))
    end
  end

  -- wait until
  utilMap[worldInfo].WaitUntil = function (predicate)
    repeat
      Wait(Delay(0.1))
    until predicate()
  end

  -- wait terminal started
  utilMap[worldInfo].WaitTerminal = function ()
    Wait(Event(terminal.Started))
  end

  -- judge the counts of specified entity in specified area
  utilMap[worldInfo].EntityCountInArea = function (entityStr, areaDetector)
    if nil == worldInfo then return 0 end
    local count = 0
    local all = worldInfo:GetAllEntitiesOfClass(entityStr)
    for _, entity in ipairs(all) do
      local vEntity = entity:GetActualPlacement():GetVect()
      if areaDetector:IsPointInArea(vEntity, 0.5) then
        count = count + 1
      end
    end
    return count
  end

  -- judge if there is specified entity in specified area
  utilMap[worldInfo].ExistEntityInArea = function (entityStr, areaDetector)
    return 0 < utilMap[worldInfo].EntityCountInArea(entityStr, areaDetector)
  end

  -- judge if player is in specified area
  utilMap[worldInfo].IsPlayerInArea = function (areaDetector)
    if nil == player then return false end
    local vEntity = player:GetPlacement():GetVect()
    return areaDetector:IsPointInArea(vEntity, 0.5)
  end

  -- show the reset message
  utilMap[worldInfo].ResetMessage = function ()
    if nil == player then return end
    player:ShowMessageOnHUD("TTRS:Hint.HoldToReset=Hold {plcmdHome} to reset")
  end

  -- judge if the time switch active
  utilMap[worldInfo].IsTimeSwitchActive = function ()
    if nil == worldInfo then return false end
    if worldInfo:IsTimeSwitchActive() then return true end
    if utilMap[worldInfo].IsTimeSwitchPlaying() then return true end
    return false
  end

  -- judge if the time switch playing
  utilMap[worldInfo].IsTimeSwitchPlaying = function ()
    if nil == worldInfo then return false end
    return 0 < #worldInfo:GetAllEntitiesOfClass("CPastPlayerPuppetEntity")
  end

  -- judge if the time switch recording
  utilMap[worldInfo].IsTimeSwitchRecording = function ()
    if nil == worldInfo then return false end
    if not worldInfo:IsTimeSwitchActive() then return false end
    if utilMap[worldInfo].IsTimeSwitchPlaying() then return false end
    return true
  end
  return utilMap[worldInfo]
end

local levelPackIndex = 0
repeat
  levelPackIndex = levelPackIndex + 1
  local levelPackFileName = "Content/Talos/Levels/sc_level_pack/Scripts/LevelPack" .. levelPackIndex .. ".lua"
  if scrFileExists(levelPackFileName) then
    dofile(levelPackFileName)
  else
    levelPackIndex = -1
  end
until levelPackIndex < 0
