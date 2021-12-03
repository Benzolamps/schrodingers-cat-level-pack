local util = worldGlobals.CreateUtil()

RunHandled(
  util.WaitTerminal,
  OnEvery(Event(detectorTrigger.Activated)),
  function()
    detectorTrigger:Recharge()
    if not util.IsTimeSwitchRecording() then return end
    if mthAbsF(mine:GetLinearVelocity().z) >= 0.01 then return end
    if not util.ExistEntityInArea("CJammerItemEntity", detectorJammer) then return end
    if not util.ExistEntityInArea("CCarriableFanItemEntity", detectorFan) then return end
    util.player: ShowTutorialMessage("TTRS:ScLevelPack.SplitHint=Don't forget to press the pressure plate!", 2, 2)
  end
)
