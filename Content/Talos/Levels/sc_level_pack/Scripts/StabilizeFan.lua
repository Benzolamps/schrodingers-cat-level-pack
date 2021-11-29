local util = worldGlobals.CreateUtil()

while true do
  Wait(Delay(0.1))
  if util.IsPlayerInArea(detector) then
    fan:Deactivate()
  else
    fan:Activate()
  end
end
