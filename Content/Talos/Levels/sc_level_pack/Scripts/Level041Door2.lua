arranger:Reset()
Wait(Event(arranger.Solved))
Wait(Delay(0.5))
DoorOpened:PlayOnce()
door:Open()