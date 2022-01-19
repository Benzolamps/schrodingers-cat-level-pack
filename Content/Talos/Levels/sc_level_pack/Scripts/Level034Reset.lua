local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector1.Activated)),
  function ()
    detector1:Recharge()
    if util.IsTimeSwitchPlaying() then return end
    if util.ExistEntityInArea("CCarriableRodItemEntity", detector1) then return end
    if util.ExistEntityInArea("CCarriableFanItemEntity", detector1) then return end
    util.ResetMessage()
  end,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchActive() then return end
    if util.IsPlayerInArea(detector3) then return end
    local itemCount = util.EntityCountInArea("CCarriableItemEntity", detector2)
    if itemCount == 0 then return end
    if itemCount == 1
       and util.ExistEntityInArea("CCarriableRodItemEntity", detector2)
       and (red:IsChargedUp() or red:IsCharging())
    then return end
    util.ResetMessage()
  end
)
