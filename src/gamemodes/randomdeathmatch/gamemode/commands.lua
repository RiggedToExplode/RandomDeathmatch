print("commands.lua")

concommand.Add("rdm_tableprint", function ()
  PrintTable(RDMTables)
end)

concommand.Add("rdm_tablereload", function()
  local raw = file.Read("randomdeathmatch/tables.txt", "DATA")

  if raw ~= nil then
    RDMTables = util.JSONToTable( raw )
    PrintTable(RDMTables)
  else
    print("RDM loadouts.txt config file does not exist or cannot be loaded!")
  end
end)


-- All these are from the previous version. I didn't bother to comment them, but
-- merely brought them up to date with everything I changed.
concommand.Add("rdm_primary_add", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
	  local weps = weapons.GetList()
      for h, i in pairs(weps) do
        if string.sub(i.ClassName, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(RDMTables.primary, i.ClassName)
        end
      end
    else
      table.insert(RDMTables.primary, v)
    end
  end
end)
concommand.Add("rdm_melee_add", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
	  local weps = weapons.GetList()
      for h, i in pairs(weps) do
        if string.sub(i.ClassName, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(RDMTables.melee, i.ClassName)
        end
      end
    else
      table.insert(RDMTables.melee, v)
    end
  end
end)
concommand.Add("rdm_aux_add", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
	  local weps = weapons.GetList()
      for h, i in pairs(weps) do
        if string.sub(i.ClassName, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(RDMTables.auxiliary, i.ClassName)
        end
      end
    else
      table.insert(RDMTables.auxiliary, v)
    end
  end
end)
concommand.Add("rdm_nodrop_add", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
	  local weps = weapons.GetList()
      for h, i in pairs(weps) do
        if string.sub(i.ClassName, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(RDMTables.noDrop, i.ClassName)
        end
      end
    else
      table.insert(RDMTables.noDrop, v)
    end
  end
end)


concommand.Add("rdm_primary_remove", function(ply, cmd, args)
  for k, v in pairs(args) do
    table.RemoveByValue(RDMTables.primary, v)
  end
end)
concommand.Add("rdm_melee_remove", function(ply, cmd, args)
  for k, v in pairs(args) do
    table.RemoveByValue(RDMTables.melee, v)
  end
end)
concommand.Add("rdm_aux_remove", function(ply, cmd, args)
  for k, v in pairs(args) do
    table.RemoveByValue(RDMTables.auxiliary, v)
  end
end)
concommand.Add("rdm_nodrop_remove", function(ply, cmd, args)
  for k, v in pairs(args) do
    table.RemoveByValue(RDMTables.noDrop, v)
  end
end)


concommand.Add("rdm_primary_removeall", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
      local marked = {}
      for h, i in pairs(RDMTables.primary) do
        if string.sub(i, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(marked, i)
        end
      end

      for h, i in pairs(marked) do
        table.RemoveByValue(RDMTables.primary, i)
      end
    else
      while has_value(RDMTables.primary, v) do
        table.RemoveByValue(RDMTables.primary, v)
      end
    end
  end
end)
concommand.Add("rdm_melee_removeall", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
      local marked = {}
      for h, i in pairs(RDMTables.melee) do
        if string.sub(i, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(marked, i)
        end
      end

      for h, i in pairs(marked) do
        table.RemoveByValue(RDMTables.melee, i)
      end
    else
      while has_value(RDMTables.primary, v) do
        table.RemoveByValue(RDMTables.melee, v)
      end
    end
  end
end)
concommand.Add("rdm_aux_removeall", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
      local marked = {}
      for h, i in pairs(RDMTables.auxiliary) do
        if string.sub(i, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(marked, i)
        end
      end

      for h, i in pairs(marked) do
        table.RemoveByValue(RDMTables.auxiliary, i)
      end
    else
      while has_value(RDMTables.primary, v) do
        table.RemoveByValue(RDMTables.auxiliary, v)
      end
    end
  end
end)
concommand.Add("rdm_nodrop_removeall", function(ply, cmd, args)
  for k, v in pairs(args) do
    if string.sub(v, -2) == "^*" then
      local marked = {}
      for h, i in pairs(RDMTables.noDrop) do
        if string.sub(i, 1, string.len(v) - 2) == string.sub(v, 1, -3) then
          table.insert(marked, i)
        end
      end

      for h, i in pairs(marked) do
        table.RemoveByValue(RDMTables.noDrop, i)
      end
    else
      while has_value(RDMTables.primary, v) do
        table.RemoveByValue(RDMTables.noDrop, v)
      end
    end
  end
end)

print(">Done!")
