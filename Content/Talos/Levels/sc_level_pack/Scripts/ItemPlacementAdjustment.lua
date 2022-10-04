RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function ()
    local all = worldInfo:GetAllEntitiesOfClass("CCarriableItemEntity")
    for _, item in ipairs(all) do
      local vItem = item:GetActualPlacement():GetVect()
      if detector:IsPointInArea(vItem, 0.5) then
        local pItem = item:GetPlacement()
        local pDetector = detector:GetPlacement()
        pItem.vx = pDetector.vx
        pItem.vz = pDetector.vz
        item:SetPlacement(pItem)
      end
    end
  end
)
