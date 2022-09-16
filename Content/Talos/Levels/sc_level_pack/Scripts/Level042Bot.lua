local util = worldGlobals.CreateUtil()

RunHandled(
  WaitForever,
  OnEvery(Event(pressure1.Pressed)),
  function()
    if not util.ExistEntityInArea("CCarriableFanItemEntity", detector) then
      switch:Activate()
    end
  end,
  OnEvery(Event(pressure2.Pressed)),
  function()
    switch:Activate()
  end,
  OnEvery(Any(Event(pressure1.Released), Event(pressure2.Released))),
  function()
    switch:Deactivate()
  end
)
