local util = worldGlobals.CreateUtil()

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

if talosProgress:IsVarSet("Platform_Hinted") then
  return
end

Wait(Event(platform.Picked))
Wait(Delay(1))
util.player:ShowTutorialMessage("TTRS:ScLevelPack.EnhancedPlatformHint1=This kind of enhanced platform can be snapped to hexahedrons, pressure plates, and recorded platforms.", 5, 2)
Wait(Delay(8))
util.player:ShowTutorialMessage("TTRS:ScLevelPack.EnhancedPlatformHint2=Please never mind its indicator is a fan!", 3, 2)

if levelFlag then
  util.WaitTerminal()
  talosProgress:SetVar("Platform_Hinted")
end
