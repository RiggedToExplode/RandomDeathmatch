print("commands.lua")

roundLimit = 2
round = 1

concommand.Add("rdm_spawn_list", function()
  for k, v in pairs(spawnWeapons) do
    print(v)
  end
end)
concommand.Add("rdm_melee_list", function()
  for k, v in pairs(spawnMelee) do
    print(v)
  end
end)
concommand.Add("rdm_aux_list", function()
  for k, v in pairs(spawnspawnAuxiliary) do
    print(v)
  end
end)
concommand.Add("rdm_nodrop_list", function()
  for k, v in pairs(noDrop) do
    print(v)
  end
end)


concommand.Add("rdm_spawn_add", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
	  local weps = weapons.GetList()
      for h, i in pairs(weps) do
        if string.sub(i.ClassName, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(spawnWeapons, i.ClassName)
        end
      end
    else
      table.insert(spawnWeapons, v)
    end
  end
end)
concommand.Add("rdm_melee_add", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
	  local weps = weapons.GetList()
      for h, i in pairs(weps) do
        if string.sub(i.ClassName, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(spawnMelee, i.ClassName)
        end
      end
    else
      table.insert(spawnMelee, v)
    end
  end
end)
concommand.Add("rdm_aux_add", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
	  local weps = weapons.GetList()
      for h, i in pairs(weps) do
        if string.sub(i.ClassName, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(spawnAuxiliary, i.ClassName)
        end
      end
    else
      table.insert(spawnAuxiliary, v)
    end
  end
end)
concommand.Add("rdm_nodrop_add", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
	  local weps = weapons.GetList()
      for h, i in pairs(weps) do
        if string.sub(i.ClassName, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(noDrop, i.ClassName)
        end
      end
    else
      table.insert(noDrop, v)
    end
  end
end)


concommand.Add("rdm_spawn_remove", function(ply, cmd, args)
  for k, v in pairs(args) do
    table.RemoveByValue(spawnWeapons, v)
  end
end)
concommand.Add("rdm_melee_remove", function(ply, cmd, args)
  for k, v in pairs(args) do
    table.RemoveByValue(spawnMelee, v)
  end
end)
concommand.Add("rdm_aux_remove", function(ply, cmd, args)
  for k, v in pairs(args) do
    table.RemoveByValue(spawnAuxiliary, v)
  end
end)
concommand.Add("rdm_nodrop_remove", function(ply, cmd, args)
  for k, v in pairs(args) do
    table.RemoveByValue(noDrop, v)
  end
end)


concommand.Add("rdm_spawn_removeall", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
      local marked = {}
      for h, i in pairs(spawnWeapons) do
        if string.sub(i, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(marked, i)
        end
      end

      for h, i in pairs(marked) do
        table.RemoveByValue(spawnWeapons, i)
      end
    else
      while has_value(spawnWeapons, v) do
        table.RemoveByValue(spawnWeapons, v)
      end
    end
  end
end)
concommand.Add("rdm_melee_removeall", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
      local marked = {}
      for h, i in pairs(spawnMelee) do
        if string.sub(i, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(marked, i)
        end
      end

      for h, i in pairs(marked) do
        table.RemoveByValue(spawnMelee, i)
      end
    else
      while has_value(spawnWeapons, v) do
        table.RemoveByValue(spawnMelee, v)
      end
    end
  end
end)
concommand.Add("rdm_aux_removeall", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
      local marked = {}
      for h, i in pairs(spawnAuxiliary) do
        if string.sub(i, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(marked, i)
        end
      end

      for h, i in pairs(marked) do
        table.RemoveByValue(spawnAuxiliary, i)
      end
    else
      while has_value(spawnWeapons, v) do
        table.RemoveByValue(spawnAuxiliary, v)
      end
    end
  end
end)
concommand.Add("rdm_nodrop_removeall", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
      local marked = {}
      for h, i in pairs(noDrop) do
        if string.sub(i, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(marked, i)
        end
      end

      for h, i in pairs(marked) do
        table.RemoveByValue(noDrop, i)
      end
    else
      while has_value(spawnWeapons, v) do
        table.RemoveByValue(noDrop, v)
      end
    end
  end
end)


mapVote = false

respawn = true
timer.Create("RDMRoundRestart", 1800, 0, function()
  local leader = nil
  local prevFrags = 0

  for k, v in pairs(player.GetAll()) do
     if v:Frags() > prevFrags then
       leader = v
       prevFrags = leader:Frags()
     end
  end

  respawn = false
  for k, v in pairs(player.GetAll()) do
    v:Kill()
	if leader ~= nil then
      v:PrintMessage(HUD_PRINTCENTER, leader:GetName() .. " won!")
    end
	v:SetFrags(0)
	v:SetDeaths(0)
  end

  game.CleanUpMap()

  round = round + 1

  if round > roundLimit and mapVote == true then
    round = 1
	MapVote.Start(15, false, 16, {"rdm_","ttt_","tf2_","cs_"})
  end
  respawn = true
end)

concommand.Add("rdm_printweapon", function(ply)
	print(ply:GetActiveWeapon():GetClass())
end)
concommand.Add("rdm_mapvote", function(ply, cmd, args)
  if args[1] == "true" then
    mapVote = true
	print("true")
  else
    mapVote = false
	print("false")
  end
end)
concommand.Add("rdm_roundtime", function(ply, cmd, args)
  respawn = true
  timer.Create("RDMRoundRestart", args[1], 0, function()
    local leader = nil
    local prevFrags = 0

    for k, v in pairs(player.GetAll()) do
       if v:Frags() > prevFrags then
         leader = v
         prevFrags = leader:Frags()
       end
    end

    respawn = false
    for k, v in pairs(player.GetAll()) do
      v:Kill()
  	if leader ~= nil then
        v:PrintMessage(HUD_PRINTCENTER, leader:GetName() .. " won!")
      end
	  v:SetFrags(0)
	  v:SetDeaths(0)
    end

    game.CleanUpMap()

	round = round + 1

    if round > roundLimit and mapVote == true then
	  MapVote.Start(15, false, 16, {"rdm_","ttt_","tf2_","cs_"})
    end
	respawn = true
  end)
end)
concommand.Add("rdm_roundlimit", function(ply, cmd, args)
  roundLimit = tonumber(args[1])
end)

print(">Done!")
