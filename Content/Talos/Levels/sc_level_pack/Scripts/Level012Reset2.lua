local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  function ()
    Wait(Event(detector2.Activated))
  end,
  OnEvery(Delay(0.1)),
  function ()
    if util.IsTimeSwitchActive() then return end
    if not util.ExistEntityInArea("CCarriableItemEntity", detector1) then return end
    util.ResetMessage()
  end
)
