RunHandled(
  WaitForever,
  OnEvery(Event(fan.Activated)),
  function()
    animMover:PlayAnimWait("Up")
    SoundPlatformRotate:PlayOnce()
  end,
  OnEvery(Event(fan.Deactivated)),
  function()
    animMover:PlayAnimWait("Down")
    SoundPlatformRotate:PlayOnce()
  end
)