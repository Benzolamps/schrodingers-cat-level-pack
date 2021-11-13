local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if plasma:IsOpen() then return end
    if 1 ~= util.EntityCountInArea("CCarriableItemEntity", detector) then return end
    if util.ExistEntityInArea("CCarriableFanItemEntity", detector) then return end
    util.ResetMessage()
  end,
  OnEvery(Delay(0.1)),
  function ()
    if plasma:IsOpen() then return end
    local itemCount = util.EntityCountInArea("CCarriableItemEntity", detector)
    local fanCount = util.EntityCountInArea("CCarriableFanItemEntity", detector)
    if fanCount >= itemCount then return end
    if util.IsPlayerInArea(detector) then return end
    Wait(Delay(1))
    util.ResetMessage()
  end
)
