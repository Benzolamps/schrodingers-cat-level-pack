local base = worldGlobals.CreateInstance(worldInfo)

while true do
  Wait(Delay(0.1))
  if base.IsPlayerInArea(detector) then
    fan:Deactivate()
  else
    fan:Activate()
  end
end
