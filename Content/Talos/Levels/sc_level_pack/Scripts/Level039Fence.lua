local function pressFence (pressures, fence)
  local count = 0
  RunAsync(
    function()
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
    end
  )
end

pressFence(pressures1, fence1)
pressFence(pressures2, fence2)
