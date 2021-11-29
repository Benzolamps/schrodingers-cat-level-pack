local util = worldGlobals.CreateUtil()

RunHandled(
  function ()
    Wait(Event(switch.Activated))
  end,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    util.ResetMessage()
  end
)
