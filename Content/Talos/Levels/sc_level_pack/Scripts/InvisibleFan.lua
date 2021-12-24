local util = worldGlobals.CreateUtil()

RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if util.IsPlayerInArea(detector) then
      fan:Deactivate()
    else
      fan:Activate()
    end
  end
)
