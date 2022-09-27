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
    if switch1:IsActivated() and switch2:IsActivated() then
      marker1:SetPlacement(mthQuatVect(mthEulerToQuaternion(mthVector3f(0, 0, 0)), mthVector3f(-60, 0, -1)))
      marker2:SetPlacement(mthQuatVect(mthEulerToQuaternion(mthVector3f(0, 0, 0)), mthVector3f(-60, 0, 1)))
    end
  end,
  On(Event(switch.Activated)),
  function()
    mine1:SetPlacement(marker3:GetPlacement())
    mine2:SetPlacement(marker4:GetPlacement())
  end
)
