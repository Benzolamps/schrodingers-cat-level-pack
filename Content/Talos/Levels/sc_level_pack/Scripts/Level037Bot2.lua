local cube1Deployed = false
local cube2Deployed = false

RunHandled(
  WaitForever,
  OnEvery(Event(mine.Jammed)),
  function()
    if not detector:IsPointInArea(mine:GetPlacement():GetVect(), 0.5) then
      return
    end
    local vCube1 = cube1:GetActualPlacement()
    local vCube2 = cube2:GetActualPlacement()
    if not cube1Deployed and detector:IsPointInArea(vCube1:GetVect(), 0.5) then
      cube1Deployed = true
      switch2:Activate()
      switch1:Activate()
      Wait(Delay(0.1))
      switch1:Deactivate()
      if cube2Deployed then
        vCube2.vy = 1
        vCube1.vy = 2.5
        marker1:SetPlacement(vCube2)
        marker2:SetPlacement(vCube1)
      end
      return
    end
    if not cube2Deployed and detector:IsPointInArea(vCube2:GetVect(), 0.5) then
      cube2Deployed = true
      switch2:Deactivate()
      switch1:Activate()
      Wait(Delay(0.1))
      switch1:Deactivate()
      if cube1Deployed then
        vCube1.vy = 1
        vCube2.vy = 2.5
        marker1:SetPlacement(vCube1)
        marker2:SetPlacement(vCube2)
      end
      return
    end
  end
)
