local util = worldGlobals.CreateUtil()

local keyPicked = false

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchPlaying() then return end
    local door1Open = door1:IsOpen()
    local door2Open = door2:IsOpen()
    local door3Open = door3:IsOpen()
    local jammerIn1 = util.ExistEntityInArea("CJammerItemEntity", detector1)
    local jammerIn2 = util.ExistEntityInArea("CJammerItemEntity", detector2)
    local jammerIn3 = util.ExistEntityInArea("CJammerItemEntity", detector3)
    local jammerIn4 = util.ExistEntityInArea("CJammerItemEntity", detector4)
    local playerIn1 = util.IsPlayerInArea(detector1)
    local playerIn2 = util.IsPlayerInArea(detector2)
    local playerIn3 = util.IsPlayerInArea(detector3)
    local playerIn4 = util.IsPlayerInArea(detector4)

    if playerIn1 then
      if not door1Open and not jammerIn1 then
        util.ResetMessage()
        return
      end
    elseif playerIn2 or playerIn3 then
      if (not door1Open and not keyPicked or not door2Open) and not jammerIn2 and not jammerIn3 then
        util.ResetMessage()
        return
      end
    else
      if keyPicked then
        if not playerIn4 and not door3Open and (jammerIn1 or jammerIn2 or jammerIn3 or jammerIn4) then
          util.ResetMessage()
          return
        end
      else
        if not jammerIn1 and not jammerIn2 and not jammerIn3 then
          util.ResetMessage()
          return
        end
      end
    end
  end,
  On(Event(key.Picked)),
  function ()
    keyPicked = true
  end,
  OnEvery(Event(detector5.Activated)),
  function ()
    detector5:Recharge()
    if not util.IsTimeSwitchPlaying() then
      util.ResetMessage()
    end
  end
)
