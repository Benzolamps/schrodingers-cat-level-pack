local util = worldGlobals.CreateUtil()

repeat
  Wait(Delay(300))
  for _ = 1, 3 do
    util.player:ShowTutorialMessage("TTRS:ScLevelPack.PoppyHint1=Hint 1: When you pass through the purple door, the time recorder will stop.", 4, 2)
    Wait(Delay(7))
    util.player:ShowTutorialMessage("TTRS:ScLevelPack.PoppyHint2=Hint 2: When the time recorder stops playback, it will delay by about 1 s.", 4, 2)
    Wait(Delay(7))
  end
until false
