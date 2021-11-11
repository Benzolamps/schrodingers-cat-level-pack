-- level pack
worldGlobals.levels = {}
local levels = worldGlobals.levels

local levelPackIndex = 0
repeat
  local levelPackFileName = "Content/Talos/Levels/sc_level_pack/Scripts/LevelPack" .. levelPackIndex .. ".lua"
  if scrFileExists(levelPackFileName) then
    dofile(levelPackFileName)
    levelPackIndex = levelPackIndex + 1
  else
    levelPackIndex = -1
  end
until levelPackIndex < 0

-- paged level pack
local levelsSplit = {}

-- generate the paged level pack
local j = 0
repeat
  local split = {}
  for i = 1, 6 do
    j = j + 1
    table.insert(split, levels[j])
    if j >= #levels then break end
  end
  table.insert(levelsSplit, split)
until j >= #levels

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

  -- get the i-th page, the j-th level
  instance.GetLevel = function (i, j)
    local k = i % #levelsSplit * 6 + j
    return Depfile("Content/Talos/Levels/sc_level_pack/level" .. k .. ".wld"), levels[k]
  end

  -- get current level
  instance.GetCurrentLevel = function ()
    if nil == worldInfo then return end
    for i = 1, #levels do
      if string.find(worldInfo:GetWorldFileName(), "level" .. i .. ".wld") then
        return worldInfo:GetWorldFileName(), levels[i]
      end
    end
  end

  -- get next level
  instance.GetNextLevel = function ()
    if nil == worldInfo then return end
    for i = 1, #levels do
      if string.find(worldInfo:GetWorldFileName(), "level" .. i .. ".wld") then
        local j = i + 1
        if j > #levels then
          return Depfile("Content/Talos/Levels/sc_level_pack/level1.wld"), levels[1]
        else
          return Depfile("Content/Talos/Levels/sc_level_pack/level" .. j .. ".wld"), levels[j]
        end
      end
    end
  end

  -- get specified page
  instance.GetLevelPage = function (page)
    return levelsSplit[page % #levelsSplit + 1]
  end

  -- get random level
  instance.GetRandomLevel = function ()
    local k = mthRndRangeL(1, #levels)
    return Depfile("Content/Talos/Levels/sc_level_pack/level" .. k .. ".wld"), levels[k]
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
