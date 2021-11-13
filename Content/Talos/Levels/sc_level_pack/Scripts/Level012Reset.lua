local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  WaitForever,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    if not turret:IsEnabled() then return end
    if util.IsTimeSwitchPlaying() then return end
    util.ResetMessage()
  end
)
