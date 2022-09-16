Wait(Event(receiver.ChargedUp))
local itemIndex1, itemIndex2
local distance1 = 1000
local distance2 = 1000
for i = 1, 3 do
  local d = worldInfo:GetDistance(door1, connectors[i])
  if d < distance1 then
    distance1 = d
    itemIndex1 = i
  end
end

for i = 1, 3 do
  local d = worldInfo:GetDistance(door2, connectors[i])
  if d < distance2 then
    distance2 = d
    itemIndex2 = i
  end
end


for i = 1, 3 do
  if itemIndex1 == i then
    switchs[i]:Activate()
  end
  if itemIndex2 == i then
    switchs[i + 3]:Activate()
  end
end
