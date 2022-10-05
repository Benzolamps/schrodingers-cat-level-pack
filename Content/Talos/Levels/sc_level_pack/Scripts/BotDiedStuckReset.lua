local util = worldGlobals.CreateUtil()

Wait(Delay(1))
local bots = worldInfo:GetAllEntitiesOfClass("CPlayerBotPuppetEntity")
local botGroup = NewGroupVar()
for _, bot in ipairs(bots) do
  table.insert(botGroup, bot)
end
Wait(Any(Events(botGroup.Died)))
RunHandled(
  util.WaitTerminal,
  OnEvery(Delay(0.1)),
  function ()
    util.ResetMessage()
  end
)
