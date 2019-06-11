print("rdm_commands.lua")



concommand.Add( "rdm_tableprint", function ()

  PrintTable(RDMTables)

end )

concommand.Add( "rdm_tablereload", function()

  tableLoad()

end )

concommand.Add( "rdm_tablesave", function()

  tableSave()

end )

concommand.Add( "rdm_tabledefault", function()

  tableDefault()

end )



concommand.Add( "rdm_primary_add", function( ply, cmd, args )

  for k, v in pairs( args ) do

    if string.sub( v, -2 ) == "^*" then

      local weps = weapons.GetList()

      for h, i in pairs( weps ) do

        if string.sub( i.ClassName, 1, string.len( v ) - 2 ) == string.sub( v, 1, -3 ) then

          tableAdd( "primary", i.ClassName )

        end

      end
    else

      tableAdd( "primary", v )

    end

  end

end )

concommand.Add( "rdm_melee_add", function( ply, cmd, args )

  for k, v in pairs( args ) do

    if string.sub( v, -2 ) == "^*" then

      local weps = weapons.GetList()

      for h, i in pairs( weps ) do

        if string.sub( i.ClassName, 1, string.len( v ) - 2 ) == string.sub( v, 1, -3 ) then

          tableAdd( "melee", i.ClassName )

        end

      end
    else

      tableAdd( "melee", v )

    end

  end

end )

concommand.Add( "rdm_aux_add", function( ply, cmd, args )

  for k, v in pairs( args ) do

    if string.sub( v, -2 ) == "^*" then

      local weps = weapons.GetList()

      for h, i in pairs( weps ) do

        if string.sub( i.ClassName, 1, string.len( v ) - 2 ) == string.sub( v, 1, -3 ) then

          tableAdd( "auxiliary", i.ClassName )

        end

      end
    else

      tableAdd( "auxiliary", v )

    end

  end

end )

concommand.Add( "rdm_nodrop_add", function( ply, cmd, args )

  for k, v in pairs( args ) do

    if string.sub( v, -2 ) == "^*" then

      local weps = weapons.GetList()

      for h, i in pairs( weps ) do

        if string.sub( i.ClassName, 1, string.len( v ) - 2 ) == string.sub( v, 1, -3 ) then

          tableAdd( "nodrop", i.ClassName )

        end

      end
    else

      tableAdd( "nodrop", v )

    end

  end

end )



concommand.Add( "rdm_primary_remove", function( ply, cmd, args )

  for k, v in pairs( args ) do

    tableRemove( "primary", v )

  end

end )

concommand.Add( "rdm_melee_remove", function( ply, cmd, args )

  for k, v in pairs( args ) do

    tableRemove( "melee", v )

  end

end )

concommand.Add( "rdm_aux_remove", function( ply, cmd, args )

  for k, v in pairs( args ) do

    tableRemove( "auxiliary", v )

  end

end )

concommand.Add( "rdm_nodrop_remove", function( ply, cmd, args )

  for k, v in pairs( args ) do

    tableRemove( "nodrop", v )

  end

end )



concommand.Add( "rdm_primary_removeall", function( ply, cmd, args )

  for k, v in pairs( args ) do

    if string.sub( v, -2 ) == "^*" then


      for h, i in pairs( RDMTables.primary ) do

        if string.sub( i, 1, string.len( v ) - 2 ) == string.sub( v, 1, -3 ) then

          tableRemoveAll( "primary", i )

        end

      end

    else

      tableRemoveAll( "primary", v )

    end

  end

end )

concommand.Add( "rdm_melee_removeall", function( ply, cmd, args )

  for k, v in pairs( args ) do

    if string.sub( v, -2 ) == "^*" then


      for h, i in pairs( RDMTables.melee ) do

        if string.sub( i, 1, string.len( v ) - 2 ) == string.sub( v, 1, -3 ) then

          tableRemoveAll( "melee", i )

        end

      end

    else

      tableRemoveAll( "melee", v )

    end

  end

end )

concommand.Add( "rdm_aux_removeall", function( ply, cmd, args )

  for k, v in pairs( args ) do

    if string.sub( v, -2 ) == "^*" then


      for h, i in pairs( RDMTables.auxiliary ) do

        if string.sub( i, 1, string.len( v ) - 2 ) == string.sub( v, 1, -3 ) then

          tableRemoveAll( "auxiliary", i )

        end

      end

    else

      tableRemoveAll( "auxiliary", v )

    end

  end

end )

concommand.Add( "rdm_nodrop_removeall", function( ply, cmd, args )

  for k, v in pairs( args ) do

    if string.sub( v, -2 ) == "^*" then


      for h, i in pairs( RDMTables.nodrop ) do

        if string.sub( i, 1, string.len( v ) - 2 ) == string.sub( v, 1, -3 ) then

          tableRemoveAll( "nodrop", i )

        end

      end

    else

      tableRemoveAll( "nodrop", v )

    end

  end

end )



print(">Done!")
