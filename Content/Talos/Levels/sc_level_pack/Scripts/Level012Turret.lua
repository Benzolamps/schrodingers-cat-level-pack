RunHandled(
  WaitForever,
  OnEvery(Event(fakeFan.Activated)),
  function ()
    turret:Enable()
  end,
  OnEvery(Event(fakeFan.Deactivated)),
  function ()
    turret:Disable()
  end
)
