local util = worldGlobals.CreateUtil()

--- 0-none, 1-recording, 2-playing
local lastState = 0

RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchRecording() then
      if lastState ~= 1 then
        if lastState == 2 then
          -- playing ended
          SignalEvent("TimeSwitchPlayingEnded")
        end
        -- recording started
        SignalEvent("TimeSwitchRecordingStarted")
        lastState = 1
      end
    elseif util.IsTimeSwitchPlaying() then
      if lastState == 1 then
        -- recording ended
        SignalEvent("TimeSwitchRecordingEnded")
        -- playing started
        SignalEvent("TimeSwitchPlayingStarted")
        lastState = 2
      elseif lastState == 0 then
        -- playing started
        SignalEvent("TimeSwitchPlayingStarted")
        lastState = 2
      end
    else
      if lastState == 1 then
        -- recording ended
        SignalEvent("TimeSwitchRecordingEnded")
        -- recording aborted (timeout or pass through purple wall)
        SignalEvent("TimeSwitchRecordingAborted")
        lastState = 0
      elseif lastState == 2 then
        -- playing ended
        SignalEvent("TimeSwitchPlayingEnded")
        lastState = 0
      end
    end
  end
)
