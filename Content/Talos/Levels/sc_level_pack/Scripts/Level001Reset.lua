local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  function ()
    Wait(Event(mine.Died))
  end,
  OnEvery(Any(Event(detector1.Activated), Event(detector2.Activated))),
  function ()
    detector1:Recharge()
    detector2:Recharge()
    if not util.ExistEntityInArea("CJammerItemEntity", detector3) then
      util.ResetMessage()
    end
  end
)
