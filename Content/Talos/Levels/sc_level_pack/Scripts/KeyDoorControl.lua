local function bindKeyWithDoor(key, door)
  local keyPicked = false
  local doorOpened = false
  local aggregator = SpawnEntityByClass(worldInfo, worldInfo:GetPlacement(), "CKeyAggregatorEntity")
  aggregator:ShowHudInfo(true)
  aggregator:AddKey(key)
  door:AssureLocked()
  door:EnableUsage()
  door:EnableLookedAtNotification()
  RunAsync(function()
    RunHandled(
      WaitForever,
      OnEvery(Event(key.Picked)),
      function()
        keyPicked = true
        door:Unlock()
      end,
      OnEvery(Event(door.Used)),
      function()
        if (keyPicked) then
          doorOpened = true
          door:DisableUsage()
          Wait(Delay(0.5))
          aggregator:ShowHudInfo(false)
        else
          door:DisableUsage()
          Wait(Delay(3.5))
          door:EnableUsage()
        end
      end)
  end)
end

if key and door then
  bindKeyWithDoor(key, door)
end

if not keysAndDoors then return end

local key, door

for _, entity in ipairs(keysAndDoors) do
  if entity:GetClassName() == "CDoorEntity" then
    door = entity
    bindKeyWithDoor(key, door)
  else
    key = entity
  end
end
