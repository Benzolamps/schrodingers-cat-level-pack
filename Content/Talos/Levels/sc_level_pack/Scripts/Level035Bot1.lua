local util = worldGlobals.CreateUtil()

RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if util.ExistEntityInArea("CJammerItemEntity", detector) and  util.IsPlayerInArea(detector) then
      switch:Activate()
    else
      switch:Deactivate()
    end
  end
)
