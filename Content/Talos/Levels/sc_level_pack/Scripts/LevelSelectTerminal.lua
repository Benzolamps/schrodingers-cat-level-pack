worldInfo:ActivateTimer(0)

local base = worldGlobals.CreateInstance(worldInfo)

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

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
local page
RunHandled(
  WaitForever,
  OnEvery(Event(terminal.Started)),
  function ()
    if terminal:GetName() == "TerminalEnd" and not finished then
      finished = true
      terminal:EnableASCIIAnimation(false)
    
      -- calculate the time
      local time = worldInfo:GetTimePassedFromTimer()
      local old = talosProgress:GetCodeValue(worldInfo:GetWorldFileName()) / 100
      local str = "Congratulations! "
      -- judge if it is new record
      if old <= 0 or time < old then
        talosProgress:SetCode(worldInfo:GetWorldFileName(), time * 100)
        str = str .. "You have a new record."
      end
      str = str .. "\nTime:%w2 " .. mthFloorF(time * 100) / 100 .. " s%w3\n"
      terminal:AddString(str)
    end
    page = -1
    talosProgress:SetCode("LevelCount", #base.GetLevelPage(page + 1))
  end,

  -- loading the level
  On(CustomEvent(terminal, "TerminalEvent_0")),
  function ()
    local level
    -- next level
    if talosProgress:IsVarSet("Next") then
      level = base.GetNextLevel()
    -- random level
    elseif talosProgress:IsVarSet("Random") then
      level = base.GetRandomLevel()
    -- specified level
    else
      level = base.GetLevel(page, talosProgress:GetCodeValue("Level"))
    end
    terminal:AddString("Opening " .. level .. ".%w1.%w1.%w1 %w9Done.%w30.")
    Wait(Delay(2))
    worldInfo:StartLevel(level)
  end,

  -- level select
  OnEvery(CustomEvent(terminal, "TerminalEvent_1")),
  function ()
    page = page + 1
    talosProgress:SetCode("LevelCount", #base.GetLevelPage(page + 1))
    local str = "Please select which level you want to play: "
    local levels = base.GetLevelPage(page)
    for i = 1, #levels do
      str = str .. "\n%w2 " .. i .. " - " .. levels[i]
    end
    str = str .. "\n%w2 R - Random"
    str = str .. "\n%w2 N - Next Page"
    terminal:AddString(str .. "\n<span class=\"strong\">>>></span> ")
  end,

  -- level record
  OnEvery(CustomEvent(terminal, "TerminalEvent_2")),
  function ()
    local levelFile, levelName = base.GetCurrentLevel()
    local levelTime = talosProgress:GetCodeValue(levelFile) / 100
    local str = "";
    str = str .. levelName .. "\n"
    str = str .. "Level File: " .. levelFile .. "\n"
    if levelTime > 0 then
      str = str .. "Level Best Time: " .. levelTime .. " s\n"
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
