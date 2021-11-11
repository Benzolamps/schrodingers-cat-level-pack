local base = worldGlobals.CreateInstance(worldInfo)

RunHandled(
  base.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    local distance = mthAbsF(mine:GetPlacement():GetVect().x - pressure:GetPlacement():GetVect().x)
    if plasma:IsOpen() and 5 > distance then
      base.ResetMessage()
    end
  end
)
