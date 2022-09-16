RunHandled(
  function ()
    Wait(Event(mine.Destroyed))
  end,
  OnEvery(Delay(0.1)),
  function ()
    if worldInfo:GetDistance(mine, marker) < 0.5 then
      mine:Explode("")
    end
  end
)
