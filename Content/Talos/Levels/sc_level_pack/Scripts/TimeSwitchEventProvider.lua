local util = worldGlobals.CreateUtil(worldInfo)

local lastState = 0

RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchRecording() then
      if (lastState ~= 1) then
        SignalEvent("TimeSwitchRecordingStarted")
        lastState = 1
      end
    elseif util.IsTimeSwitchPlaying() then
      if (lastState == 1) then
        SignalEvent("TimeSwitchRecordingEnded")
        SignalEvent("TimeSwitchPlayingStarted")
        lastState = 2
      elseif (lastState == 0) then
        SignalEvent("TimeSwitchPlayingStarted")
        lastState = 2
      end
    else
      if (lastState == 1) then
        SignalEvent("TimeSwitchRecordingEnded")
        SignalEvent("TimeSwitchRecordingAborted")
        lastState = 0
      elseif (lastState == 2) then
        SignalEvent("TimeSwitchPlayingEnded")
        lastState = 0
      end
    end
  end
)
