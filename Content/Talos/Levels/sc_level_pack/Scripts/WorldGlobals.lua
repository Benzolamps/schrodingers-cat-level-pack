-- level pack
worldGlobals.levels = {}
local levels = worldGlobals.levels

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

-- create base object
worldGlobals.CreateInstance = function (worldInfo)

  -- get the player
  local player = Wait(Event(worldInfo.PlayerBorn)):GetBornPlayer()

  -- get the terminal
  local terminal = worldInfo:GetEntityByName("TerminalEnd")

  -- define instance
  local instance = {}
  
  -- get player
  instance.GetPlayer = function ()
    return player
  end
  
  -- get terminal
  instance.GetTerminal = function ()
    return terminal
  end

  -- get the level
  instance.GetLevel = function (index)
    return levels[index]
  end

  instance.GetLevelByFile = function (file)
    for index, level in ipairs(levels) do
      if file == level.levelFile then
        return level, index
      end
    end
  end

  -- wait while
  instance.WaitWhile = function (predicate)
    while predicate() do
      Wait(Delay(0.1))
    end
  end

  -- wait until
  instance.WaitUntil = function (predicate)
    repeat
      Wait(Delay(0.1))
    until predicate()
  end
    
  -- wait terminal started
  instance.WaitTerminal = function ()
    instance.WaitUntil(function ()
      return terminal
    end)
    Wait(Event(terminal.Started))
  end

  -- judge the counts of specified entity in specified area
  instance.EntityCountInArea = function (entityStr, areaDetector)
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
  instance.ExistEntityInArea = function (entityStr, areaDetector)
    return 0 < instance.EntityCountInArea(entityStr, areaDetector)
  end

  -- judge if player is in specified area
  instance.IsPlayerInArea = function (areaDetector)
    if nil == player then return false end
    local vEntity = player:GetPlacement():GetVect()
    return areaDetector:IsPointInArea(vEntity, 0.5)
  end

  -- show the reset message
  instance.ResetMessage = function ()
    if nil == player then return end
    player:ShowMessageOnHUD("TTRS:Hint.HoldToReset=Hold {plcmdHome} to reset")
  end

  -- judge if the time switch active
  instance.IsTimeSwitchActive = function ()
    if nil == worldInfo then return false end
    if worldInfo:IsTimeSwitchActive() then return true end
    if instance.IsTimeSwitchPlaying() then return true end
    return false
  end

  -- judge if the time switch playing
  instance.IsTimeSwitchPlaying = function ()
    if nil == worldInfo then return false end
    return 0 < #worldInfo:GetAllEntitiesOfClass("CPastPlayerPuppetEntity")
  end

  -- judge if the time switch recoding
  instance.IsTimeSwitchRecoding = function ()
    if nil == worldInfo then return false end
    if not worldInfo:IsTimeSwitchActive() then return false end
    if instance.IsTimeSwitchPlaying() then return false end
    return true
  end

  return instance
end
