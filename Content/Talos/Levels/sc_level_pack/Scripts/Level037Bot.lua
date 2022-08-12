local util = worldGlobals.CreateUtil()

RunHandled(
  WaitForever,
  OnEvery(Event(door.Opened)),
  function ()
    if util.ExistEntityInArea("CTalosShieldItemEntity", detector) then
      switch:Activate()
    end
  end
)
