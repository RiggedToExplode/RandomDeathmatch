print("rdm_tables.lua")



RDMTablesLength = {} -- Initialize a length object
RDMTables = {} -- Initialize the tables object

function tableLengths()

  RDMTablesLength = { -- Define the lengths once so that they are quicker to get.
    auxiliary = #RDMTables.auxiliary,
    melee = #RDMTables.melee,
    models = #RDMTables.models,
    nodrop = #RDMTables.nodrop,
    primary = #RDMTables.primary
  }

end

function precache()

  for k, v in pairs( RDMTables.primary ) do
    local wep = weapons.Get( v )

    if wep ~= nil then

      local viewmodel = wep.ViewModel
      local worldmodel = wep.WorldModel

      print( "Precaching viewmodel " .. viewmodel )
      util.PrecacheModel( viewmodel )
      print( "Precaching worldmodel " .. worldmodel )
      util.PrecacheModel( worldmodel )

    end

  end

  for k, v in pairs( RDMTables.melee ) do
    local wep = weapons.Get( v )

    if wep ~= nil then

      local viewmodel = wep.ViewModel
      local worldmodel = wep.WorldModel

      print( "Precaching viewmodel " .. viewmodel )
      util.PrecacheModel( viewmodel )
      print( "Precaching worldmodel " .. worldmodel )
      util.PrecacheModel( worldmodel )

    end

  end

  for k, v in pairs( RDMTables.auxiliary ) do
    local wep = weapons.Get( v )

    if wep ~= nil then

      local viewmodel = wep.ViewModel
      local worldmodel = wep.WorldModel

      print( "Precaching viewmodel " .. viewmodel )
      util.PrecacheModel( viewmodel )
      print( "Precaching worldmodel " .. worldmodel )
      util.PrecacheModel( worldmodel )

    end

  end

end

function tableLoad()

  -- Load the text blob from tables.txt
  local raw = file.Read( "randomdeathmatch/tables.txt", "DATA" )

  -- the blob will equal nil if the file cannot be read.
  if raw ~= nil then

    RDMTables = util.JSONToTable( raw ) -- Change the tables if the blob can be loaded

    tableLengths()

    return true -- Return true for success

  else

    print( "tableLoad: tables.txt does not exist or cannot be read!" ) -- Else throw an "error"
    print( "-- Don't worry if this is your first time launching RDM, this is meant to happen!" ) -- Let the user know this is to be expected for first launch

    return false -- Return false for failure

  end

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
    nodrop = {
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

  tableLengths()

end



function tableAdd( tab, val )

  if tab == "primary" then -- Check what table we're editing
    -- Just append the value to the table.
    table.insert( RDMTables.primary, val )

  elseif tab == "auxiliary" then

    table.insert( RDMTables.auxiliary, val )

  elseif tab == "melee" then

    table.insert( RDMTables.melee, val )

  elseif tab == "models" then

    table.insert( RDMTables.models, val )

  elseif tab == "nodrop" then

    table.insert( RDMTables.nodrop, val )

  else -- Error message if table isn't one of the "valid" tables

    print( "tableAdd: table '" .. tab .. "' is not a valid table" )

  end

  tableLengths()

end

function tableRemove( tab, val )

  if tab == "primary" then -- Check what table we're editing
    -- Just remove the value from the table.
    table.RemoveByValue( RDMTables.primary , val )

  elseif tab == "auxiliary" then

    table.RemoveByValue( RDMTables.auxiliary , val )

  elseif tab == "melee" then

    table.RemoveByValue( RDMTables.melee , val )

  elseif tab == "models" then

    table.RemoveByValue( RDMTables.models , val )

  elseif tab == "nodrop" then

    table.RemoveByValue( RDMTables.nodrop, val )

  else -- Error message if table isn't one of the "valid" tables

    print( "tableRemove: table '" .. tab .. "' is not a valid table" )

  end

  tableLengths()

end

function tableRemoveAll ( tab, val )

  if tab == "primary" then -- Check what table we're editing

    while has_value ( RDMTables.primary, val ) do -- While the table still contains the value

      tableRemove( "primary", val ) -- Remove said value.

    end

  elseif tab == "auxiliary" then

    table.RemoveByValue( RDMTables.auxiliary , val )

    while has_value ( RDMTables.auxiliary, val ) do

      tableRemove( "auxiliary", val )

    end

  elseif tab == "melee" then

    table.RemoveByValue( RDMTables.melee , val )

    while has_value ( RDMTables.melee, val ) do

      tableRemove( "melee", val )

    end

  elseif tab == "models" then

    table.RemoveByValue( RDMTables.models , val )

    while has_value ( RDMTables.models, val ) do

      tableRemove( "models", val )

    end

  elseif tab == "nodrop" then

    table.RemoveByValue( RDMTables.nodrop, val )

    while has_value ( RDMTables.nodrop, val ) do

      tableRemove( "nodrop", val )

    end

  else -- Error message if table isn't one of the "valid" tables

    print( "tableRemoveAll: table '" .. tab .. "' is not a valid table" )

  end

  tableLengths()

end



if !tableLoad() then -- Try to load the tables from tables.txt

  tableDefaults() -- Load some defaults if the tables can't be loaded.

end
precache()

-- Save the tables upon server shutdown
function GM:ShutDown()

  tableSave()

end



print(">Done!")
