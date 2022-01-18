local util = worldGlobals.CreateUtil()

RunHandled(
  WaitForever,
  OnEvery(Event(detector.Activated)),
  function()
    detector:Recharge()
    if plasmas[1]:IsOpen() or plasmas[2]:IsOpen() then return end
    if util.IsTimeSwitchPlaying() then return end
    if util.ExistEntityInArea("CJammerItemEntity", detector) then return end
    util.ResetMessage()
  end
)
