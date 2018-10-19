print("utils.lua")
math.randomseed(os.time())

function has_value (tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

firstBlood = false

timer.Create("LeadingAnnouncement1", 60, 0, function()
  local leader = nil
  local prevFrags = 0

  for k, v in pairs(player.GetAll()) do
     if v:Frags() > prevFrags then
       leader = v
       prevFrags = leader:Frags()
     end
  end

  if leader ~= nil then
    for k, v in pairs(player.GetAll()) do
        v:PrintMessage(HUD_PRINTCENTER, leader:GetName() .. " is in the lead with " .. tostring(leader:Frags()) .. " points!")
    end
  end
end)
print(">Done!")
