print("tables.lua")

raw = file.Read("randomdeathmatch/tables.txt", "DATA")

if raw ~= nil then
  -- If we could load from the file, then use it.
  RDMTables = util.JSONToTable( raw )
else
  -- Else start the tables with some defaults.
  -- Declare the item tables as one big RDMLoadout object.
  RDMTables = {
    noDrop = {
      "weapon_fists"
    },

    primary = {
      "weapon_pistol",
      "weapon_smg1",
      "weapon_frag",
      "weapon_crossbow",
      "weapon_shotgun",
      "weapon_357",
      "weapon_rpg",
      "weapon_ar2"
    },

    melee = {
      "weapon_crowbar"
    },

    auxiliary = {
      "weapon_physcannon",
      "weapon_medkit"
    },

    models = {
      "models/player/odessa.mdl"
    }
  }
end

-- Save the tables upon server shutdown
function GM:ShutDown()
  -- Create the config directory if it doesn't exist
  file.CreateDir("randomdeathmatch")
  -- Create the text blob and write it to the file.
  local text = util.TableToJSON(RDMTables, true)
  file.Write( "randomdeathmatch/tables.txt", text )
end

print(">Done!")
