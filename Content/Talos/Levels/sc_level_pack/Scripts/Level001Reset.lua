local util = worldGlobals.CreateUtil()

RunHandled(
  function ()
    Wait(Event(mine.Died))
  end,
  OnEvery(Any(Events(detectors.Activated))),
  function ()
    detectors:Recharge()
    if turret:IsEnabled() then return end
    if not util.ExistEntityInArea("CJammerItemEntity", detectorJammer) then
      util.ResetMessage()
    end
  end
)
