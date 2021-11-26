local util = worldGlobals.CreateUtil(worldInfo)

--- 0正常, 1记录, 2播放
local lastState = 0

RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchRecording() then
      if lastState ~= 1 then
        -- 开始记录
        SignalEvent("TimeSwitchRecordingStarted")
        lastState = 1
      end
    elseif util.IsTimeSwitchPlaying() then
      if lastState == 1 then
        -- 结束记录
        SignalEvent("TimeSwitchRecordingEnded")
        -- 开始播放
        SignalEvent("TimeSwitchPlayingStarted")
        lastState = 2
      elseif lastState == 0 then
        -- 开始播放
        SignalEvent("TimeSwitchPlayingStarted")
        lastState = 2
      end
    else
      if lastState == 1 then
        -- 结束记录
        SignalEvent("TimeSwitchRecordingEnded")
        -- 记录中断 (超时或者穿过紫门)
        SignalEvent("TimeSwitchRecordingAborted")
        lastState = 0
      elseif lastState == 2 then
        -- 结束记录
        SignalEvent("TimeSwitchPlayingEnded")
        lastState = 0
      end
    end
  end
)
