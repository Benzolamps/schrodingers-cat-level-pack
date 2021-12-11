local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    if util.IsTimeSwitchPlaying() then return end
    if util.ExistEntityInArea("CCarriableFanItemEntity", detector) then return end
    util.ResetMessage()
  end
)
