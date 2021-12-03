local util = worldGlobals.CreateUtil()


-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

if talosProgress:IsVarSet("Level001_Cube_Fall") then
  plasma1:Delete()
  return
else
  plasma2:Delete()
end

local status = 2
local timeSinceDrop = 0

repeat
  Wait(Delay(0.1))
  if cube:GetPicker() then
    status = 2
    timeSinceDrop = 0
  else
    timeSinceDrop = timeSinceDrop + 0.1
    local vect = cube:GetPlacement():GetVect()
    if detector:IsPointInArea(vect, 0.5) then
      status = 1
    else
      if status == 1 and timeSinceDrop > 1 then
        break
      end
    end
  end
until false

SignalEvent("Level001CubeFall")
talosProgress:SetVar("Level001_Cube_Fall")

local messages = {
  "TTRS:ScLevelPack.CubeFallHint1=It seems that the cube can easily fall off the mine.",
  "TTRS:ScLevelPack.CubeFallHint2=I'm sorry about this glitch.",
  "TTRS:ScLevelPack.CubeFallHint3=Please hold {plcmdHome} to reset, and the door will become lower, and the cube will not fall off so easily."
}

local index = 1
RunHandled(
  function ()
    util.player:ShowTutorialMessage(messages[index], 2, 2)
    index = index < 3 and index + 1 or 1
    util.WaitTerminal()
  end,
  OnEvery(Delay(4)),
  function()
    util.player:ShowTutorialMessage(messages[index], 2, 2)
    index = index < 3 and index + 1 or 1
  end
)
