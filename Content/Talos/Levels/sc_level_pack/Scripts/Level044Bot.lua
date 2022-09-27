RunHandled(function()
  Wait(Event(door.Unlocked))
end,
  OnEvery(Delay(0.1)),
  function()
    if worldInfo:GetDistance(mine, marker) < 0.5 then
      switch:Activate()
    else
      switch:Deactivate()
    end
  end
)
