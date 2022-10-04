local count = 0
RunHandled(
  WaitForever,
  OnEvery(Any(Events(pressures.Pressed))),
  function()
    count = count + 1
    if count == #pressures then
      fence:Open()
    end
  end,
  OnEvery(Any(Events(pressures.Released))),
  function()
    count = count - 1
  end
)
