local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if not detector1:IsPointInArea(cube1:GetPlacement():GetVect(), 0.5) then
      return
    end
    if not detector2:IsPointInArea(cube2:GetPlacement():GetVect(), 0.5) then
      return
    end
    if cube2:GetPlacement().vy > 0.5 then
      return
    end
    util.ResetMessage()
  end
)
