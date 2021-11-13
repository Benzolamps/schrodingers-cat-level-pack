worldInfo:ActivateTimer(0)

local base = worldGlobals.CreateInstance(worldInfo)

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

local currentLevelIndex = talosProgress:GetCodeValue("Level")
local currentLevel

if (currentLevelIndex <= 0) then
  currentLevel, currentLevelIndex = base.GetLevelByFile(worldInfo:GetWorldFileName())
  talosProgress:SetCode("Level", currentLevelIndex)
else
  currentLevel = base.GetLevel(currentLevelIndex)
end

currentLevel.SetLevelTime = function (time)
  talosProgress:SetCode("Level" .. currentLevelIndex .. "_TIME", time * 100)
end

currentLevel.GetLevelTime = function ()
  return talosProgress:GetCodeValue("Level" .. currentLevelIndex .. "_TIME") / 100
end

currentLevel.SetLevelRead = function (flag)
  if flag then
    talosProgress:SetVar("Level" .. currentLevelIndex .. "_READ")
  else
    talosProgress:ClearVar("Level" .. currentLevelIndex .. "_READ")
  end
end

currentLevel.SetLevelRead(currentLevel.GetLevelTime() > 0)

if (terminal:GetName() == "TerminalEnd") then
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
    if terminal:GetName() == "TerminalEnd" and not finished then
      finished = true
      terminal:EnableASCIIAnimation(false)
    
      -- calculate the time
      local time = worldInfo:GetTimePassedFromTimer()
      local str = "Congratulations! "
      -- judge if it is new record
      if currentLevel.GetLevelTime() <= 0 or time < currentLevel.GetLevelTime() then
        currentLevel.SetLevelTime(time)
        str = str .. "You have a new record."
      end
      str = str .. "\nTime:%w2 " .. currentLevel.GetLevelTime() .. " s%w3\n"
      terminal:AddString(str)
      talosProgress:SetVar("Level" .. currentLevelIndex .. "_READ")
    end
  end,

  -- loading the level
  On(CustomEvent(terminal, "TerminalEvent_0")),
  function ()
    local level = base.GetLevel(talosProgress:GetCodeValue("Level"))
    terminal:AddString("Opening " .. level.levelFile .. ".%w1.%w1.%w1 %w9Done.%w30.")
    Wait(Delay(2))
    worldInfo:StartLevel(level.levelFile)
  end,

  -- level record
  OnEvery(CustomEvent(terminal, "TerminalEvent_1")),
  function ()
    local str = "";
    str = str .. currentLevel.levelTitle .. "\n"
    str = str .. "Level File: " .. currentLevel.levelFile .. "\n"
    if currentLevel.GetLevelTime() > 0 then
      str = str .. "Level Best Time: " .. currentLevel.GetLevelTime() .. " s\n"
    else
      str = str .. "Level Best Time: Infinity\n"
    end
    terminal:AddString(str .. "<span class=\"strong\">>>></span> ") 
  end,

  -- close the fences and barriers
  On(Event(terminal.Stopped)),
  function ()
    if terminal:GetName() == "TerminalEnd" then
      if fences then
        fences:Open()
      end
      if barriers then
        barriers:Disable()
      end
    end
  end
)
