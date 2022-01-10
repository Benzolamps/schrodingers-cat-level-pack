local count = 0

RunHandled(
  WaitForever,
  OnEvery(Any(Events(pressures.Pressed))),
  function()
    count = count + 1
    if count == #pressures then
      switch:Activate()
    end
  end,
  OnEvery(Any(Events(pressures.Released))),
  function()
    count = count - 1
    if count == #pressures - 1 then
      switch:Deactivate()
    end
  end
)
