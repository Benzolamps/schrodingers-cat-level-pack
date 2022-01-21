RunHandled(
  WaitForever,
  OnEvery(Event(fakeFan.Activated)),
  function()
    for i, elevator in ipairs(elevators) do
      elevator:MoveToDestinationEntity(markersEnd[i])
    end
  end,
  OnEvery(Event(fakeFan.Deactivated)),
  function()
     for i, elevator in ipairs(elevators) do
      elevator:MoveToDestinationEntity(markersStart[i])
     end
  end
)
