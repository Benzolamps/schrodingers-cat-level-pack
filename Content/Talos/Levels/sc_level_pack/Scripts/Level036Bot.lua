RunHandled(
  function ()
    Wait(Event(mine.Jammed))
  end,
  OnEvery(Delay(0.1)),
  function()
    if detector:IsPointInArea(mine:GetPlacement():GetVect(), 0.5)  then
      switch:Activate()
    else
      switch:Deactivate()
    end
  end
)
