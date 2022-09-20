local util = worldGlobals.CreateUtil()

Wait(Any(Events(mines.Died)))
RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    util.ResetMessage()
  end
)
