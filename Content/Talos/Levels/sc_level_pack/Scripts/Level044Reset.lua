local util = worldGlobals.CreateUtil()

local needReset = true
local needResetTime = false

Wait(Event(detector.Activated))
detector:Recharge()

RunHandled(
  util.WaitTerminal,
  On(Delay(2)),
  function()
    needResetTime = true
  end,
  OnEvery(Event(detector.Activated)),
  function()
    detector:Recharge()
    if not needReset then
      return
    end
    if
      receivers[1]:IsChargedUp() or receivers[1]:IsCharging()
      or receivers[2]:IsChargedUp() or receivers[2]:IsCharging()
    then
      needReset = false
      return
    end
    if needResetTime
    then
      util.ResetMessage()
    end
  end
)
