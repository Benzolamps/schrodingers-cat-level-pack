local fixed = false

local function ChangePosition(switch, position)
  local p = switch:GetPlacement()
  p.vy = position
  switch:SetPlacement(p)
end

ChangePosition(switch2, -1000)

RunHandled(
  WaitForever,
  OnEvery(CustomEvent("TimeSwitchRecordingStarted")),
  function()
    ChangePosition(switch1, -1000)
    ChangePosition(switch2, 1.5)
  end,
  OnEvery(CustomEvent("TimeSwitchPlayingStarted")),
  function()
    Wait(Delay(1))
    ChangePosition(switch1, 1.5)
    ChangePosition(switch2, -1000)
  end,
  OnEvery(Event(switch1.Activated)),
  function()
    local p = worldInfo:GetClosestPlayer(switch1, 8)
    if not fixed and p == nil then
      switch1:Deactivate()
      fixed = true
    else
      switch2:Activate()
      fixed = false
    end
  end,
  OnEvery(Event(switch1.Deactivated)),
  function()
    local p = worldInfo:GetClosestPlayer(switch1, 8)
    if not fixed and p == nil then
      switch1:Activate()
      fixed = true
    else
      switch2:Deactivate()
      fixed = false
    end
  end
)
