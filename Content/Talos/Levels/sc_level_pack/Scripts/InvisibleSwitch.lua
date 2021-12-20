if not (#switches > 0) then
  switches = {switches}
end

for _, switch in ipairs(switches) do
  switch:SetUsable(false)
  local p = switch:GetPlacement()
  p.vy = -1000
  switch:SetPlacement(p)
end
