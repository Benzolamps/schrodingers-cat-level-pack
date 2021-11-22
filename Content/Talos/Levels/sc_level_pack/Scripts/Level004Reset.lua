local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if not plasma:IsOpen() then return end
    if mthAbsF(mine:GetPlacement():GetVect().x - pressure:GetPlacement():GetVect().x) < 5 then
      util.ResetMessage()
    end
  end
)
