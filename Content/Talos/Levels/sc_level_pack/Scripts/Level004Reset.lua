local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if not plasma:IsOpen() then return end
    if worldInfo:GetDistance(mine, pressure) < 5 then
      util.ResetMessage()
    end
  end
)
