--- 所有关卡集合
local levels = {}

--- 根据关卡信息创建关卡
--- @param levelTitle string 关卡标题
--- @param neededMechanics string 所需道具
--- @param levelFile number 关卡文件
--- @param levelIndex number 关卡序号
--- @return table 生成的关卡对象
worldGlobals.CreateLevel = function (levelTitle, neededMechanics, levelFile, levelIndex)
  local level = {}
  level.levelTitle = levelTitle
  level.neededMechanics = neededMechanics
  level.levelFile = levelFile
  level.levelIndex = levelIndex
  levels[levelIndex] = level
  return level
end

--- 字符串常量
local strings = {
  CommonPrompt = [[<span class="strong">&gt;&gt;&gt; </span>]],
  Congratulations = TranslateString("TTRS:ScLevelPack.Congratulations=Congratulations!\n\n"),
  CongratulationsNewRecord = TranslateString("ScLevelPack.CongratulationsNewRecord=Congratulations! You have a new record:%w2%s0 %1 s\n\n"),
  Opening = TranslateString("TTRS:ScLevelPack.Opening=Opening %1.%w1.%w1.%w1 %w9Done.%w30.\n\n"),
  LevelRecordInfo = TranslateString("TTRS:ScLevelPack.LevelRecordInfo=%1 [%2]\nLevel File: %3\nLevel Best Time: %4 s\n\n"),
  LevelRecordInfoNotFinish = TranslateString("TTRS:ScLevelPack.LevelRecordInfoNotFinish=%1 [%2]\nLevel File: %3\nLevel Best Time: Infinity\n\n")
}

--- 缓存每个关卡的util对象
local utilMap = {}

--- 创建util对象
--- @param worldInfo table WorldInfo对象
--- @return table
worldGlobals.CreateUtil = function (worldInfo)
  -- 直接获取当前WorldInfo已生成的util对象
  if utilMap[worldInfo] then return utilMap[worldInfo] end

  -- 获取角色
  local player = Wait(Event(worldInfo.PlayerBorn)):GetBornPlayer()

  -- 获取终点终端
  local terminal = worldInfo:GetEntityByName("TerminalEnd")

  -- talosProgress : CTalosProgress
  -- 获取TalosProgress对象
  local talosProgress = nexGetTalosProgress(worldInfo)

  --- 定义util对象
  --- @field player table 角色对象
  --- @field terminal table 终点终端对象
  --- @field levels table 所有关卡集合
  --- @field strings table 字符串常量
  --- @field currentLevel table 当前关卡对象
  local util = {
    player = player,
    terminal = terminal,
    levels = levels,
    strings = strings,
    currentLevel = nil
  }

  -- 获取当前关卡
  local levelFile = worldInfo:GetWorldFileName()
  for _, level in ipairs(levels) do
    --- 获取关卡最佳时间
    --- @return number 最佳时间
    level.GetLevelTime = function ()
      return talosProgress:GetCodeValue("Level" .. level.levelIndex .. "_TIME") / 100
    end

    --- 设置关卡最佳时间
    --- @param time number 最佳时间
    level.SetLevelTime = function (time)
      talosProgress:SetCode("Level" .. level.levelIndex .. "_TIME", time * 100)
    end

    --- 获取关卡是否完成
    --- @return boolean 是否完成
    level.IsLevelRead = function ()
      return talosProgress:GetVar("Level" .. level.levelIndex .. "_READ")
    end

    --- 设置关卡是否完成
    --- @param flag boolean 是否完成
    level.SetLevelRead = function (flag)
      if flag then
        talosProgress:SetVar("Level" .. level.levelIndex .. "_READ")
      else
        talosProgress:ClearVar("Level" .. level.levelIndex .. "_READ")
      end
    end

    -- 若关卡最佳时间大于0, 则标记为已完成
    level.SetLevelRead(level.GetLevelTime() > 0)

    -- 如果关卡文件与当前关卡文件相同, 标记为当前关卡
    if levelFile == level.levelFile then
     util.currentLevel = level
     talosProgress:SetCode("Level", util.currentLevel.levelIndex)
    end
  end

  --- 格式化字符串
  --- @param str string 要格式化的字符串
  util.FormatString = function (str, ...)
    for i, v in ipairs({...}) do
      if string.find(str, '%%' .. i) then
        str = string.gsub(str, '%%' .. i, tostring(v))
      end
    end
    return str
  end

  --- 当满足条件时等待
  --- @param predicate function 条件
  util.WaitWhile = function (predicate)
    while predicate() do
      Wait(Delay(0.1))
    end
  end

  --- 等待直到满足条件
  --- @param predicate function 条件
  util.WaitUntil = function (predicate)
    repeat
      Wait(Delay(0.1))
    until predicate()
  end

  --- 等待直到终点终端启动
  util.WaitTerminal = function ()
    Wait(Event(terminal.Started))
  end

  --- 获取指定区域内指定物体的个数
  --- @param entityStr string 物体类字符串
  --- @param areaDetector table 区域
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

  --- 判断指定区域内是否含有指定物体
  --- @param entityStr string 物体类字符串
  --- @param areaDetector table 区域
  --- @return boolean
  util.ExistEntityInArea = function (entityStr, areaDetector)
    return util.EntityCountInArea(entityStr, areaDetector) > 0
  end

  --- 判断角色是否在指定区域内
  --- @param areaDetector table 区域
  --- @return boolean
  util.IsPlayerInArea = function (areaDetector)
    local vEntity = player:GetPlacement():GetVect()
    return areaDetector:IsPointInArea(vEntity, 0.5)
  end

  --- 展示重置消息
  util.ResetMessage = function ()
    player:ShowMessageOnHUD("TTRS:Hint.HoldToReset=Hold {plcmdHome} to reset")
  end

  --- 判断时间记录仪是否启动
  --- @return boolean
  util.IsTimeSwitchActive = function ()
    if not worldInfo:IsTimeSwitchActive() then return false end
    return true
  end

  --- 判断时间记录仪是否正在播放
  --- @return boolean
  util.IsTimeSwitchPlaying = function ()
    if not worldInfo:IsTimeSwitchActive() then return false end
    if #worldInfo:GetAllEntitiesOfClass("CPastPlayerPuppetEntity") > 0 then return false end
    return true
  end

  -- 判断时间记录仪是否正在记录
  --- @return boolean
  util.IsTimeSwitchRecording = function ()
    if not worldInfo:IsTimeSwitchActive() then return false end
    if util.IsTimeSwitchPlaying() then return false end
    return true
  end

  utilMap[worldInfo] = util
  return util
end

-- 加载关卡
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
