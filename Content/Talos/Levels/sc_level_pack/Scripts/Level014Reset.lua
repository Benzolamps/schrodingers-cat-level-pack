local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if util.EntityCountInArea("CCarriableRodItemEntity", detector) <= 0 then
      util.ResetMessage()
    end
  end
)
