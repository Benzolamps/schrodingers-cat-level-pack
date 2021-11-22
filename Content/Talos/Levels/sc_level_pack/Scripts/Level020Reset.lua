local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  function()
    Wait(Event(detector3.Activated))
  end,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchPlaying() then
      return
    end
    if not util.ExistEntityInArea("CJammerItemEntity", detector1) then
      util.ResetMessage()
    end
    if util.EntityCountInArea("CCarriableItemEntity", detector2) > 1 then
      util.ResetMessage()
    end
  end
)
