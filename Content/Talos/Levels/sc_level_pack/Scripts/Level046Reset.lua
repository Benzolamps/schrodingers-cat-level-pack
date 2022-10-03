local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchPlaying() then
      return
    end
    if util.ExistEntityInArea("CTalosShieldItemEntity", detector1) then
      if not util.IsPlayerInArea(detector1)
        and not util.IsPlayerInArea(detector2)
        and not util.IsPlayerInArea(detector3)
      then
        util.ResetMessage()
      end
    elseif util.ExistEntityInArea("CTalosShieldItemEntity", detector2) then
      util.ResetMessage()
    end
  end
)
