local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if not pressure:IsPressed() then return end
    if util.IsTimeSwitchActive() then return end
    util.ResetMessage()
  end
)
