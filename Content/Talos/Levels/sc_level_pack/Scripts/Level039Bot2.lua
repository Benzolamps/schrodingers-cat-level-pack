local util = worldGlobals.CreateUtil()

local jammerGrabed = false
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
      jammerGrabed = true

      switch:Activate()
    end
  end,
  OnEvery(Event(util.player.ObjectDropped)),
  function()
    if not jammerBack then
      jammerGrabed = false
      switch:Deactivate()
    end
  end
)
