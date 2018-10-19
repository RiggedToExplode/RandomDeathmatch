print("post.lua")
timer.Create("CleanupTimer", 15, 0, function()
  for k, v in pairs(ents.GetAll()) do
	   if v:GetVar("DropTime") ~= nil and v:GetVar("DropTime") + 60 <= CurTime() then
       v:Remove()
     end
  end
end)

timer.Create("PlayerHeal", 1, 0, function()
  for k, v in pairs(player.GetAll()) do
	   if v:Health() < 100 and v:Alive() then
       v:SetHealth(v:Health() + 1)
     end
  end
end)
print(">Done!")
