local util = worldGlobals.CreateUtil()

RunHandled(
  function ()
    Wait(Event(fan.Activated))
  end,
  OnEvery(Event(detector.Activated)),
  function ()
    detector:Recharge()
    util.ResetMessage()
  end
)

Wait(Event(mine.Jammed))
RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    if util.player:GetPlacement().vy < 0.1 and not switch:IsActivated() then
      util.ResetMessage()
    end
  end
)
