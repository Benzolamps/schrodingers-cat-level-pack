local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector.Activated)),
  function()
    detector:Recharge()
    if plasma:IsOpen() then return end
    if fan:IsActive() then return end
    if util.ExistEntityInArea("CCarriableRodItemEntity", detector) then return end
    util.ResetMessage()
  end
)
