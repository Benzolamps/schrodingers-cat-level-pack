RunHandled(
  function ()
    Wait(Event(key.Picked))
  end,
  OnEvery(CustomEvent("TimeSwitchRecordingStarted")),
  function()
    switch1:Activate()
  end,
  OnEvery(CustomEvent("TimeSwitchRecordingEnded")),
  function()
    switch1:Deactivate()
  end,
  OnEvery(CustomEvent("TimeSwitchPlayingStarted")),
  function()
    switch2:Activate()
  end,
  OnEvery(CustomEvent("TimeSwitchPlayingEnded")),
  function()
    switch2:Deactivate()
  end
)

switch1:Deactivate()
switch2:Deactivate()
