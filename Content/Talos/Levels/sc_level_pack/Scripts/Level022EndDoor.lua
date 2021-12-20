local count = 0

RunHandled(
  WaitForever,
  OnEvery(Any(Events(pressures.Pressed))),
  function()
    count = count + 1
    if count == 3 then
      switch:Activate()
    end
  end,
  OnEvery(Any(Events(pressures.Released))),
  function()
    count = count - 1
    if count == 2 then
      switch:Deactivate()
    end
  end
)
