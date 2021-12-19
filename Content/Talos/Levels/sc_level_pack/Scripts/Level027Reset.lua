local util = worldGlobals.CreateUtil()

RunHandled(
  function()
    Wait(Event(detector4.Activated))
  end,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchPlaying() then return end
    local door1Open = door1:IsOpen()
    local door2Open = door2:IsOpen()
    local door3Open = door3:IsOpen()
    local jammerIn1 = util.ExistEntityInArea("CJammerItemEntity", detector1)
    local jammerIn2 = util.ExistEntityInArea("CJammerItemEntity", detector2)
    local jammerIn3 = util.ExistEntityInArea("CJammerItemEntity", detector3)
    local playerIn1 = util.IsPlayerInArea(detector1)
    local playerIn2 = util.IsPlayerInArea(detector2)
    local playerIn3 = util.IsPlayerInArea(detector3)

    if playerIn1 then
      if not door1Open and not jammerIn1 then
        util.ResetMessage()
        return
      end
    elseif playerIn2 then
      if not door1Open and not door2Open and not jammerIn2 then
        util.ResetMessage()
        return
      end
    elseif playerIn3 then
      if not door2Open and not jammerIn3 then
        util.ResetMessage()
        return
      end
    else
      if not door3Open or not jammerIn3 then
        util.ResetMessage()
        return
      end
    end
  end
)
