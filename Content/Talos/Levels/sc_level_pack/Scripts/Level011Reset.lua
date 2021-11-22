local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if plasma:IsOpen() then return end
    local itemCount = util.EntityCountInArea("CCarriableItemEntity", detector)
    local fanCount = util.EntityCountInArea("CCarriableFanItemEntity", detector)
    if itemCount == 0 then return end
    if itemCount == 1 and fanCount == 1 then return end
    if itemCount == 2 and util.IsPlayerInArea(detector) then return end
    util.ResetMessage()
  end
)
