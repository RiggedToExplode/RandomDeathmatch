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

print(">Done!")
