local util = worldGlobals.CreateUtil()

local jammerGrabbed = false
local jammerBack = false

RunHandled(
  WaitForever,
  OnEvery(Event(detector.Activated)),
  function()
    if util.ExistEntityInArea("CJammerItemEntity", detector) then
      jammerBack = true
    else
      detector:Recharge()
    end
  end,
  OnEvery(Event(util.player.ObjectGrabbed)),
  function()
    if not jammerBack then
      jammerGrabbed = true
      switch:Activate()
    end
  end,
  OnEvery(Event(util.player.ObjectDropped)),
  function()
    if not jammerBack then
      jammerGrabbed = false
      switch:Deactivate()
    end
  end
)
