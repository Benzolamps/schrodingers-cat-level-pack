local util = worldGlobals.CreateUtil()

local count = 0
RunHandled(
  util.WaitTerminal,
  OnEvery(Any(Events(mines.Died))),
  function ()
    count = count + 1
  end,
  OnEvery(Delay(0.1)),
  function ()
    if count == 1 then
      util.ResetMessage()
    end
  end
)
