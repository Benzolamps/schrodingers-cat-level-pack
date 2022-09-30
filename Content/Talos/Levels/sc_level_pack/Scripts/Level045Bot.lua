local util = worldGlobals.CreateUtil()
RunHandled(
  WaitForever,
  OnEvery(Delay(0.1)),
  function()
    local current
    if util.player:GetPlacement().vz > -8 then
      current = 5
    end
    local pf = fan:GetPlacement()
    local pc = cube:GetPlacement()
    local pfi = fanItem:GetPlacement()
    local pr = connector:GetPlacement()
    local p = 0.01 > 0
      + mthAbsF(pc.vx - pf.vx)
      + mthAbsF(pc.vz - pf.vz)
      + mthAbsF(pfi.vx - pf.vx)
      + mthAbsF(pfi.vz - pf.vz)
      + mthAbsF(pr.vx - pf.vx)
      + mthAbsF(pr.vz - pf.vz)
    for i, detector in ipairs(detectors) do
      if util.IsPlayerInArea(detector) and (i ~= 2 or p) then
        current = i
      end
    end
    if current ~= nil then
      switches[current]:Activate()
      marker:SetPlacement(markers[current]:GetPlacement())
      for i, switch in ipairs(switches) do
        if i ~= current then
          switch:Deactivate()
        end
      end
    end
  end
)
