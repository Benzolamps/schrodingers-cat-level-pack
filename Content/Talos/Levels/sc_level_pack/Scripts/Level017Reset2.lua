local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if util.IsTimeSwitchActive() then return end
    local itemCount = util.EntityCountInArea("CCarriableItemEntity", entityDetector)
    local jammerCount = util.EntityCountInArea("CJammerItemEntity", entityDetector)
    if itemCount == jammerCount then return end
    if red:IsChargedUp() then return end
    if playerDetector1:IsActivated() or playerDetector2:IsActivated() then
      playerDetector1:Recharge()
      playerDetector2:Recharge()
      return
    end
    util.ResetMessage()
  end
)
