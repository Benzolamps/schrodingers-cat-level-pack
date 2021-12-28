local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    for _, detector in ipairs(detectors) do
      if util.ExistEntityInArea("CTalosShieldItemEntity", detector) and not util.IsPlayerInArea(detector) then
        util.ResetMessage()
        return
      end
    end
  end
)
