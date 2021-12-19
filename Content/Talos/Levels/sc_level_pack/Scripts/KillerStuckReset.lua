local util = worldGlobals.CreateUtil()

local killer = worldInfo:GetAllEntitiesOfClass("CKillerEntity")[1]

RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function()
    if util.IsTimeSwitchActive() then return end
    local all = worldInfo:GetAllEntitiesOfClass("CCarriableItemEntity")
    for _, entity in ipairs(all) do
      local p = entity:GetActualPlacement()
      if p.vy < killer:GetPlacement().vy then
        util.ResetMessage()
        return
      end
    end
  end
)
