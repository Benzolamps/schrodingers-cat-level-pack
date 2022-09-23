local util = worldGlobals.CreateUtil()

Wait(Event(mine.Jammed))
RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function ()
    if util.player:GetPlacement().vy < 0.2 and not switch:IsActivated() then
      util.ResetMessage()
    end
  end
)
