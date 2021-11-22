local util = worldGlobals.CreateUtil(worldInfo)

local itemCount = util.EntityCountInArea("CCarriableItemEntity", detector2)

RunHandled(
  function()
    Wait(Event(detector3.Activated))
  end,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchPlaying() then return end
    if not util.ExistEntityInArea("CJammerItemEntity", detector1) then
      util.ResetMessage()
    end
    if util.EntityCountInArea("CCarriableItemEntity", detector2) > itemCount then
      util.ResetMessage()
    end
  end
)
