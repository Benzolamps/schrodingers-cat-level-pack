local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector.Activated)),
  function()
    detector:Recharge()
    if util.IsTimeSwitchPlaying() then return end
    if receivers[1]:IsChargedUp()
      or receivers[1]:IsCharging()
      or receivers[2]:IsChargedUp()
      or receivers[2]:IsCharging()
    then return end
    if util.ExistEntityInArea("CCarriableRodItemEntity", detector) then return end
    util.ResetMessage()
  end
)
