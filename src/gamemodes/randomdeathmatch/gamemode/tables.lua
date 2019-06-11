print("tables.lua")



RDMTablesLength = {} -- Initialize a length object
RDMTables = {} -- Initialize the tables object

function tableLoad()

  -- Load the text blob from tables.txt
  local raw = file.Read( "randomdeathmatch/tables.txt", "DATA" )

  -- the blob will equal nil if the file cannot be read.
  if raw ~= nil then

    RDMTables = util.JSONToTable( raw ) -- Change the tables if the blob can be loaded

    return true -- Return true for success

  else

    print( "tableLoad: tables.txt does not exist or cannot be read!" ) -- Else throw an "error"
    print( "-- Don't worry if this is your first time launching RDM, this is meant to happen!" ) -- Let the user know this is to be expected for first launch

    return false -- Return false for failure

  end

  RDMTablesLength = { -- Define the lengths once so that they are quicker to get.
    primary = #RDMTables.primary,
    melee = #RDMTables.melee,
    auxiliary = #RDMTables.auxiliary,
    models = #RDMTables.models
  }

end

function tableSave()

  -- Create the config directory (don't bother checking first)
  file.CreateDir( "randomdeathmatch" )
  -- Create the text blob and write it to the file.
  local text = util.TableToJSON( RDMTables, true )
  file.Write( "randomdeathmatch/tables.txt", text )

end

function tableDefault()

  -- Create a default table.
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

  RDMTablesLength = { -- Define the lengths once so that they are quicker to get.
    primary = #RDMTables.primary,
    melee = #RDMTables.melee,
    auxiliary = #RDMTables.auxiliary,
    models = #RDMTables.models
  }

end



if !tableLoad() then -- Try to load the tables from tables.txt
  tableDefaults() -- Load some defaults if the tables can't be loaded.
end


-- Save the tables upon server shutdown
function GM:ShutDown()

  tableSave()

end

print(">Done!")
