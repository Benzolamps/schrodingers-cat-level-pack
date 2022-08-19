RunHandled(
  WaitForever,
  OnEvery(Event(detector.Activated)),
  function(e)
    detector:Recharge()
    if e:GetActivator():GetClassName() == 'CPastPlayerPuppetEntity' then
      switch:Activate()
    else
      switch:Deactivate()
    end
  end
)
