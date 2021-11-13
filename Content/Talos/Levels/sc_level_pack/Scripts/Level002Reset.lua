local util = worldGlobals.CreateUtil(worldInfo)

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detector1.Activated)),
  function ()
    detector1:Recharge()
    if plasma:IsOpen() then return end
    if util.ExistEntityInArea("CJammerItemEntity", detector1) then return end
    if util.ExistEntityInArea("CJammerItemEntity", detector2) then return end
    util.ResetMessage()
  end
)
