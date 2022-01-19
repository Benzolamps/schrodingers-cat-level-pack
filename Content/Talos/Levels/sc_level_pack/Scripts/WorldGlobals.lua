--- all level list
local levels = {}

--- create level by level info
--- @param levelTitle string level title
--- @param neededMechanics string needed mechanics
--- @param levelFile number level file
--- @param levelIndex number level index
--- @return table level object created
worldGlobals.CreateLevel = function (levelTitle, neededMechanics, levelFile, levelIndex)
  local level = {}
  level.levelTitle = levelTitle
  level.neededMechanics = neededMechanics
  level.levelFile = levelFile
  level.levelIndex = levelIndex
  levels[levelIndex] = level
  return level
end

--- string constants
local strings = {
  CommonPrompt = [[<span class="strong">&gt;&gt;&gt; </span>]],
  Congratulations = TranslateString("TTRS:ScLevelPack.Congratulations=Congratulations!\n\n"),
  CongratulationsNewRecord = TranslateString("ScLevelPack.CongratulationsNewRecord=Congratulations! You have a new record:%w2%s0 %1 s\n\n"),
  Opening = TranslateString("TTRS:ScLevelPack.Opening=Opening %1.%w1.%w1.%w1 %w9Done.%w30.\n\n"),
  LevelRecordInfo = TranslateString("TTRS:ScLevelPack.LevelRecordInfo=%1 [%2]\nLevel File: %3\nLevel Best Time: %4 s\n\n"),
  LevelRecordInfoNotFinish = TranslateString("TTRS:ScLevelPack.LevelRecordInfoNotFinish=%1 [%2]\nLevel File: %3\nLevel Best Time: Infinity\n\n")
}

--- cache each level util
local utilMap = {}

--- create util object
--- @return table
worldGlobals.CreateUtil = function ()
  local worldInfo = worldGlobals.worldInfo

  -- get current worldInfo util object directly
  if utilMap[worldInfo] then return utilMap[worldInfo] end

  -- get the player
  local player = Wait(Event(worldInfo.PlayerBorn)):GetBornPlayer()

  -- get the end terminal
  local terminal = worldInfo:GetEntityByName("TerminalEnd")

  -- talosProgress : CTalosProgress
  local talosProgress = nexGetTalosProgress(worldInfo)

  --- define util object
  --- @field player table player object
  --- @field terminal table end terminal object
  --- @field levels table all level list
  --- @field strings table constants
  --- @field currentLevel table current level object
  local util = {
    player = player,
    terminal = terminal,
    levels = levels,
    strings = strings,
    currentLevel = nil
  }

  -- get current level
  local levelFile = worldInfo:GetWorldFileName()
  for _, level in ipairs(levels) do
    --- get the level time
    --- @return number level time
    level.GetLevelTime = function ()
      return talosProgress:GetCodeValue("Level" .. level.levelIndex .. "_TIME") / 100
    end

    --- set the level time
    --- @param time number level time
    level.SetLevelTime = function (time)
      talosProgress:SetCode("Level" .. level.levelIndex .. "_TIME", time * 100)
    end

    --- is the level finished
    --- @return boolean finished
    level.IsLevelRead = function ()
      return talosProgress:IsVarSet("Level" .. level.levelIndex .. "_READ")
    end

    --- set the level finished
    --- @param flag boolean finished
    level.SetLevelRead = function (flag)
      if flag then
        if not string.find(talosProgress:GetInventoryTetrominoes(), "NO" .. level.levelIndex .. ";") then
          player:AwardTetromino("NO" .. level.levelIndex)
        end
        talosProgress:SetVar("Level" .. level.levelIndex .. "_READ")
      else
        talosProgress:ClearVar("Level" .. level.levelIndex .. "_READ")
      end
    end

    -- if the level time > 0, finished
    level.SetLevelRead(level.GetLevelTime() > 0)

    -- set current level
    if levelFile == level.levelFile then
     util.currentLevel = level
     talosProgress:SetCode("Level", util.currentLevel.levelIndex)
    end
  end

  --- format string
  --- @param str string string formatting
  util.FormatString = function (str, ...)
    for i, v in ipairs({...}) do
      if string.find(str, '%%' .. i) then
        str = string.gsub(str, '%%' .. i, tostring(v))
      end
    end
    return str
  end

  --- wait while condition meets
  --- @param predicate function condition
  util.WaitWhile = function (predicate)
    while predicate() do
      Wait(Delay(0.1))
    end
  end

  --- wait until condition meets
  --- @param predicate function condition
  util.WaitUntil = function (predicate)
    repeat
      Wait(Delay(0.1))
    until predicate()
  end

  --- wait end terminal started
  util.WaitTerminal = function ()
    Wait(Event(terminal.Started))
  end

  --- judge the counts of specified entity in specified area
  --- @param entityStr string entity class string
  --- @param areaDetector table area
  --- @return number
  util.EntityCountInArea = function (entityStr, areaDetector)
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

  --- judge if there is specified entity in specified area
  --- @param entityStr string entity class string
  --- @param areaDetector table area
  --- @return boolean
  util.ExistEntityInArea = function (entityStr, areaDetector)
    return util.EntityCountInArea(entityStr, areaDetector) > 0
  end

  --- judge if player is in specified area
  --- @param areaDetector table area
  --- @return boolean
  util.IsPlayerInArea = function (areaDetector)
    local vEntity = player:GetPlacement():GetVect()
    return areaDetector:IsPointInArea(vEntity, 0.5)
  end

  --- show the reset message
  util.ResetMessage = function ()
    player:ShowMessageOnHUD("TTRS:Hint.HoldToReset=Hold {plcmdHome} to reset")
  end

  --- judge if the time switch active
  --- @return boolean
  util.IsTimeSwitchActive = function ()
    if util.IsTimeSwitchPlaying() then return true end
    if util.IsTimeSwitchRecording() then return true end
    return false
  end

  --- judge if the time switch playing
  --- @return boolean
  util.IsTimeSwitchPlaying = function ()
    -- if not worldInfo:IsTimeSwitchActive() then return false end
    local pastPlayerCount = #worldInfo:GetAllEntitiesOfClass("CPastPlayerPuppetEntity")
    if pastPlayerCount <= 0 then return false end
    return true
  end

  -- judge if the time switch recording
  --- @return boolean
  util.IsTimeSwitchRecording = function ()
    if not worldInfo:IsTimeSwitchActive() then return false end
    if util.IsTimeSwitchPlaying() then return false end
    return true
  end

  utilMap[worldInfo] = util
  return util
end

-- load the level packs
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
