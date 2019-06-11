concommand.Add("rdm_printweapon", function(ply)
	print(ply:GetActiveWeapon():GetClass())
end)
concommand.Add("rdm_printweapons", function(ply, cmd, args)
  for h, v in pairs(weapons.GetList()) do
    if string.sub(v.ClassName, 1, string.len(args[1])) == args[1] then
      print(v.ClassName)
    end
  end
end)
