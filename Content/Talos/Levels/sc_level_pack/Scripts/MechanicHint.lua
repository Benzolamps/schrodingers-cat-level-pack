local util = worldGlobals.CreateUtil()

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

local hints = {}
local showingHints = {}

for i = 1, 5 do
  talosProgress:ClearVar("Sc_Mechanic_Hint_" .. i)
  hints[i] = false
  showingHints[i] = false
end

local function ShowHint(index)
  if hints[index] then
    return
  end
  hints[index] = true
  showingHints[index] = true
  RunAsync(
    function()
      terminal:EnableOverlayRendering(true)
      terminal:AddTerminalText("Sc_Mechanic_Hint_" .. index)
      Wait(Event(terminal.FinishedTyping))
      Wait(Delay(20))
      showingHints[index] = false
      local flag = false
      for _, showingHint in ipairs(showingHints) do
        flag = flag or showingHint
      end
      if not flag then
        terminal:EnableOverlayRendering(false)
      end
      talosProgress:SetVar("Sc_Mechanic_Hinted_" .. index)
    end
  )
end

local hasBot = #worldInfo:GetAllEntitiesOfClass("CNPCSpawnMarkerEntity") > 0
local hasTimeSwitch = #worldInfo:GetAllEntitiesOfClass("CTimeSwitchEntity") > 0
local platforms = worldInfo:GetAllEntitiesOfClass("CTalosShieldItemEntity")
for _, platform in ipairs(platforms) do
  RunAsync(function()
    RunHandled(
      WaitForever,
      OnEvery(Event(platform.Picked)),
      function(e)
        if e:GetPicker() == util.player then
          ShowHint(1)
          if hasBot and hasTimeSwitch then
            ShowHint(5)
          end
        else
          ShowHint(4)
          if hasTimeSwitch then
            ShowHint(3)
          end
        end
      end
    )
  end)
end
RunHandled(
  WaitForever,
  OnEvery(CustomEvent("TimeSwitchRecordingStarted")),
  function()
    if GetClosestEntity(util.player, "CTimeSwitchEntity", 4) == nil then
      ShowHint(2)
    end
  end
)
