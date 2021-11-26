local util = worldGlobals.CreateUtil(worldInfo)

--- 0正常, 1记录, 2播放
local lastState = 0

RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchRecording() then
      if lastState ~= 1 then
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
