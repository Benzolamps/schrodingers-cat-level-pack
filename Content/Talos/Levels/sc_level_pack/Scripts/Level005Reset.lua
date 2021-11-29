local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    if receiver:IsChargedUp() or receiver:IsCharging() then return end
    util.ResetMessage()
  end
)
