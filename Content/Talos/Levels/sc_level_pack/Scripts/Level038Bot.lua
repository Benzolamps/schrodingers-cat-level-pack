RunHandled(
WaitForever,
OnEvery(Delay(0.1)),
function ()
  if detectecr:IsPointInArea(mine1:GetPlacement():GetVect(), 0.5) and mine1:GetLinearVelocity().z <= 0 then
    switch1:Activate()
  else
    switch1:Deactivate()
  end
  if detectecr:IsPointInArea(mine2:GetPlacement():GetVect(), 0.5) and mine2:GetLinearVelocity().z >= 0 then
    switch2:Activate()
  else
    switch2:Deactivate()
  end
  if switch1:IsActivated() and switch2:IsActivated() then
    marker1:SetPlacement(mthQuatVect(mthEulerToQuaternion(mthVector3f(0, 0 ,0)), mthVector3f(-60, 0 ,-1)))
    marker2:SetPlacement(mthQuatVect(mthEulerToQuaternion(mthVector3f(0, 0 ,0)), mthVector3f(-60, 0 ,1)))
  end
end,
On(Event(detector1.Activated)),
function (e)
  e:GetActivator():SetPlacement(marker1:GetPlacement())
  mine1:SetPlacement(marker3:GetPlacement())
  mine2:SetPlacement(marker4:GetPlacement())
end
)
