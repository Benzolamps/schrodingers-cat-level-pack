local util = worldGlobals.CreateUtil()

RunHandled(
  WaitForever,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    if receiver:IsChargedUp() or receiver:IsCharging() then return end
    util.ResetMessage()
  end
)
