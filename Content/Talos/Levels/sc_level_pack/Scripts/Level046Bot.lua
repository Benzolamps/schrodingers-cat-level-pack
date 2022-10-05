Wait(Delay(1))
local bot = worldInfo:GetAllEntitiesOfClass("CPlayerBotPuppetEntity")[1]
BreakableRunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    if IsDeleted(bot) then
      BreakRunHandled()
    end
    if detector:IsPointInArea(bot:GetPlacement():GetVect(), 0.5) and pressure:IsPressed() then
      switch:Activate()
    else
      switch:Deactivate()
    end
  end
)
