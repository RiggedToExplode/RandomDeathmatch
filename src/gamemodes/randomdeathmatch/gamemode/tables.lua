print("tables.lua")

file.CreateDir("randomdeathmatch")
raw = file.Read("randomdeathmatch/tables.txt", "DATA")

if raw ~= nil then
  RDMTables = util.JSONToTable( raw )
else

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

function GM:ShutDown()
  local text = util.TableToJSON(RDMTables, true)
  file.Write( "randomdeathmatch/tables.txt", text )
end

print(">Done!")
