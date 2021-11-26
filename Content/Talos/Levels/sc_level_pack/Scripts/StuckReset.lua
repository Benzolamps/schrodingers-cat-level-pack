local util = worldGlobals.CreateUtil(worldInfo)

--- 角色被困
--- @param detector table
local function PlayerStuck(detector)
  RunHandled(
    WaitForever,
    OnEvery(Event(detector.Activated)),
    function()
      detector:Recharge()
      util.ResetMessage()
    end
  )
end

--- 角色临时被困
--- @param detector table
local function PlayerStuckTemp(detector)
  RunHandled(
    util.WaitTerminal,
    OnEvery(Event(detector.Activated)),
    function()
      detector:Recharge()
      util.ResetMessage()
    end
  )
end

--- 物品被困
--- @param detector table
local function ItemStuck(detector)
  RunHandled(
    util.WaitTerminal,
    OnEvery(Delay(0.1)),
    function()
      if util.IsTimeSwitchActive() then return end
      if not util.ExistEntityInArea("CCarriableItemEntity", detector) then return end
      util.ResetMessage()
    end
  )
end

--- 门未开, 无干扰器, 角色被困
--- @param entities table
local function PlasmaStuck(entities)
  if not entities then return end
  for i = 1, #entities, 2 do
    local detector = entities[i]
    local plasma = entities[i + 1]
    RunAsync(function ()
      RunHandled(
        util.WaitTerminal,
        OnEvery(Event(detector.Activated)),
        function()
          detector:Recharge()
          if plasma:IsOpen() then return end
          if util.IsTimeSwitchPlaying() then return end
          if util.ExistEntityInArea("CJammerItemEntity", detector) then return end
          util.ResetMessage()
        end
      )
    end)
  end
end

--- 执行检测
--- @param detectors table
--- @param func function
local function RunDetectors(detectors, func)
  if detectors then
    if not #detectors > 0 then detectors = {detectors} end
    for i = 1, #detectors do
      RunAsync(function() func(detectors[i]) end)
    end
  end
end

RunDetectors(detectors1, PlayerStuck)
RunDetectors(detectors2, PlayerStuckTemp)
RunDetectors(detectors3, ItemStuck)
PlasmaStuck(entities)
