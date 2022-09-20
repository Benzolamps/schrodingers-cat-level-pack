RunHandled(
  function ()
    Wait(Event(key.Picked))
    switch:Activate()
  end,
  OnEvery(Delay(0.01)),
  function ()
    local p = elevator:GetPlacement()
    p.vy = 2
    key:SetPlacement(p)
  end
)
