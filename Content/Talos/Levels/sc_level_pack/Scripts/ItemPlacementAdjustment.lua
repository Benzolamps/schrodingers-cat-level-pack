if not #detectors then detectors = {detectors} end

RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function ()
    local all = worldInfo:GetAllEntitiesOfClass("CCarriableItemEntity")
    for _, item in ipairs(all) do
      for _, detector in ipairs(detectors) do
        local vItem = item:GetActualPlacement():GetVect()
        if detector:IsPointInArea(vItem, 0.5) then
          local pItem = item:GetPlacement()
          local pDetector = detector:GetPlacement()
          pDetector.vy = pItem.vy
          item:SetPlacement(pDetector)
        end
      end
    end
  end
)
