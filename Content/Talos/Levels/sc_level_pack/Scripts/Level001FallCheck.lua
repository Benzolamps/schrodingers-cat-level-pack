local util = worldGlobals.CreateUtil()

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

if talosProgress:IsVarSet("Level001_Cube_Fall") then
  plasma1:Delete()
  return
else
  plasma2:Delete()
end

local timeSinceDrop = 0
local timeSinceClose = 0
local timeSinceFall = 0
local carriedItem
RunHandled(
  function ()
    Wait(CustomEvent("Level001CubeFall"))
  end,
  OnEvery(Event(util.player.ObjectGrabbed)),
  function ()
    carriedItem = util.player:GetCarriedItem()
  end,
  OnEvery(Event(util.player.ObjectDropped)),
  function ()
    if carriedItem == cube then
      timeSinceDrop = 0
    end
  end,
  OnEvery(Event(plasma1.Closed)),
  function ()
    timeSinceClose = 0
  end,
  OnEvery(Delay(0.1)),
  function ()
    timeSinceDrop = timeSinceDrop + 0.1
    timeSinceClose = timeSinceClose + 0.1
    local vect = cube:GetPlacement():GetVect()
    if detector:IsPointInArea(vect, 0.5) then
      timeSinceFall = 0
    else
      timeSinceFall = timeSinceFall + 0.1
      print(timeSinceDrop .. ' ' .. timeSinceClose .. ' ' .. timeSinceFall)
      if timeSinceDrop - timeSinceFall > 1
        and timeSinceClose - timeSinceFall > 1
      then
        SignalEvent("Level001CubeFall")
        talosProgress:SetVar("Level001_Cube_Fall")
      end
    end
  end
)

local messages = {
  "TTRS:ScLevelPack.CubeFallHint1=It seems that the cube can easily fall off the mine.",
  "TTRS:ScLevelPack.CubeFallHint2=I'm sorry about this glitch.",
  "TTRS:ScLevelPack.CubeFallHint3=Please hold {plcmdHome} to reset, and the door will become lower, and the cube will not fall off so easily."
}

local index = 1
RunHandled(
  function ()
    util.player:ShowTutorialMessage(messages[index], 4, 2)
    index = index < 3 and index + 1 or 1
    util.WaitTerminal()
  end,
  OnEvery(Delay(7)),
  function ()
    util.player:ShowTutorialMessage(messages[index], 4, 2)
    index = index < 3 and index + 1 or 1
  end
)
