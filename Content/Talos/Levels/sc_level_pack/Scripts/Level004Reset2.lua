local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    if not util.ExistEntityInArea("CJammerItemEntity", detector) and not plasma:IsOpen() then
      util.ResetMessage()
    end
  end
)
