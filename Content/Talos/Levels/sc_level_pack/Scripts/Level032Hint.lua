local util = worldGlobals.CreateUtil()

Wait(Event(platform.Picked))
Wait(Delay(1))
util.player:ShowTutorialMessage("TTRS:ScLevelPack.EnhancedPlatformHint1=This kind of enhanced platform can be snapped to hexahedrons, pressure plates, and recorded platforms.", 5, 2)
Wait(Delay(8))
util.player:ShowTutorialMessage("TTRS:ScLevelPack.EnhancedPlatformHint2=Please never mind its indicator is a fan!", 3, 2)
