local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    if not util.ExistEntityInArea("CCarriableFanItemEntity", detector) then
      util.ResetMessage()
    end
  end
)
