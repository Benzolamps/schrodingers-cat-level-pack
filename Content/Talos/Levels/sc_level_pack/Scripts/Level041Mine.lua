character:Disappear(true)
RunHandled(
  function ()
    Wait(Event(mine.Died))
    character:Delete()
  end,
  OnEvery(Delay(0.1)),
  function ()
    if worldInfo:GetDistance(mine, character) < 0.5 then
      character:Appear(true)
    end
  end
)
