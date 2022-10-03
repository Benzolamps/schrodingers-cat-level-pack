local util = worldGlobals.CreateUtil()

RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchPlaying() then
      return
    end
    if util.ExistEntityInArea("CTalosShieldItemEntity", detector)
      or util.IsPlayerInArea(detector)
    then
      util.ResetMessage()
    end
  end
)
