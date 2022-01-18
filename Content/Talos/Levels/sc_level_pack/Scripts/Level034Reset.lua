local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector1.Activated)),
  function ()
    detector1 :Recharge()
    if util.IsTimeSwitchPlaying() then return end
    if util.ExistEntityInArea("CCarriableRodItemEntity", detector1) then return end
    if util.ExistEntityInArea("CCarriableFanItemEntity", detector1) then return end
    util.ResetMessage()
  end,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchActive() then return end
    local itemCount = util.EntityCountInArea("CCarriableItemEntity", detector2)
    if itemCount == 0 then return end
    if itemCount == 1
       and util.ExistEntityInArea("CCarriableRodItemEntity", detector2)
       and (red:IsChargedUp() or red:IsCharging())
    then return end
    util.ResetMessage()
  end,
  OnEvery(Any(Events(detectors.Activated))),
  function ()
    detectors:Recharge()
    if util.IsTimeSwitchPlaying() then return end
    local itemCount1 = util.EntityCountInArea("CCarriableItemEntity", detectors[1])
    local itemCount2 = util.EntityCountInArea("CCarriableItemEntity", detectors[2])
    local itemCount3 = util.EntityCountInArea("CCarriableItemEntity", detectors[3])
    local itemCount4 = util.EntityCountInArea("CCarriableItemEntity", detectors[4])
    local itemCount5 = util.EntityCountInArea("CCarriableItemEntity", detectors[5])
    if red:IsChargedUp() or red:IsCharging() then
      if itemCount1 + itemCount3 + itemCount4 + itemCount5 >= 2 then return end
    else
      if (blue:IsChargedUp() or blue:IsCharging()) and itemCount1 + itemCount2 >= 1 then return end
    end
    util.ResetMessage()
  end
)
