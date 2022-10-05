Wait(Event(platform.Picked))
platform:SetPlacement(marker:GetPlacement())
platform:Unhide()

Wait(Event(key.Picked))
SignalEvent("TimeSwitchResponseEnded")
