door2:Disappear()
Wait(Event(door1.Unlocked))
Wait(Event(door1.Used))
door1:Disappear()
door2:Appear()
door2:Unlock()
door2:Open()