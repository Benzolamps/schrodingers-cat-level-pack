local util = worldGlobals.CreateUtil()

for _, marker in ipairs(markers) do
  local p = marker:GetPlacement()
  p.vx = -60
  marker:SetPlacement(p)
end

RunHandled(
  function ()
    Wait(Any(Event(mine1.Died), Event(mine2.Died)))
  end,
  OnEvery(Delay(0.1)),
  function()
    if mthAbsF(mine1:GetPlacement().vz) < 12.5 and mine1:GetLinearVelocity().z <= 0 then
      switch1:Activate()
    else
      switch1:Deactivate()
    end
    if mthAbsF(mine2:GetPlacement().vz) < 12.5 and mine2:GetLinearVelocity().z >= 0 then
      switch2:Activate()
    else
      switch2:Deactivate()
    end
  end,
  On(Event(switch.Activated)),
  function()
    Wait(Delay(1))
    cubes:Delete()
  end
)
