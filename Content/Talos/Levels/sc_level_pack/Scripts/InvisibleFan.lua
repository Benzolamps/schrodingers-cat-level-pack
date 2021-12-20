local util = worldGlobals.CreateUtil()

local switch, fan

for _, entity in ipairs(switchesAndFans) do
  if entity:GetClassName() == "CFanEntity" then
    fan = entity
    local initActivated = not not switch:IsActivated()
    RunAsync(function()
      RunHandled(
        WaitForever,
        OnEvery(Delay(0.1)),
        function()
          local pp = util.player:GetPlacement()
          local pf = fan:GetPlacement()
          local closeToFan = true
          closeToFan = closeToFan and pp.vy < pf.vy + 4 and pp.vy > pf.vy - 12
          closeToFan = closeToFan and mthAbsF(pp.vx - pf. vx) < 4
          closeToFan = closeToFan and mthAbsF(pp.vz - pf. vz) < 4
          if closeToFan == initActivated then
            switch:Deactivate()
          else
            switch:Activate()
          end
        end
      )
    end)
  else
    switch = entity
  end
end
