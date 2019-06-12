print( "rdm_player.lua" )



function GM:PlayerLoadout( ply ) -- Redefine loadout to give random weapons

  local begin = SysTime() -- Save time value for benchmark later

  ply:Give( "weapon_fists" ) -- Every player starts with fists

  local wep = ply:Give( RDMTables.primary[ math.random( RDMTablesLength.primary ) ] ) -- Give the player their primary weapon and store the entity

  local clip = 0 -- Make sure the clip size is at least 1 (grenades & rpg will claim to have a clip size of -1)
  if wep:GetMaxClip1() <= 0 then
    clip = 1
  else
    clip = wep:GetMaxClip1()
  end

  ply:SetAmmo( math.random( 2, 4 ) * clip, wep:GetPrimaryAmmoType() ) -- Give the player some ammo for their primary weapon

  local num = math.random( 8 ) -- Generate a number for chance calculations

  if num <= 4 then -- 50% chance to get melee weapon

    ply:Give( RDMTables.melee[ math.random( RDMTablesLength.melee ) ] )

  end

  if num <= 5 and num >= 4 then -- 25% chance to get aux weapon

    ply:Give( RDMTables.auxiliary[ math.random( RDMTablesLength.auxiliary ) ] )

  end

  ply:SelectWeapon( "weapon_fists" ) -- Start every player with fists selected

  print( "Loadout completed in " .. tostring(SysTime() - begin) .. " seconds." )

end

function GM:GetFallDamage( ply, speed )

	return math.max( 0, math.ceil( 0.2418*speed - 141.75 ) )

end



function dropItems( ply, attacker, dmg )

  local wep = ply:GetActiveWeapon() -- Save the active weapon

  ply:SelectWeapon( "weapon_fists" ) -- Switch weapons in order to send holster signal to current weapon

  if !has_value( RDMTables.nodrop, wep:GetClass() ) then

    wep:SetVar( "dropped", 1 )
    wep:SetVar( "droppedTime", 0 )
    ply:DropWeapon( wep ) -- Drop the "current" weapon

  end

  for k, v in pairs( ply:GetWeapons() ) do

    if !has_value( RDMTables.nodrop, v:GetClass() ) and math.random( 2 ) == 2 then

      v:SetVar( "dropped", 1 )
      v:SetVar( "droppedTime", 0 )
      ply:DropWeapon( v )

    end

  end

end
hook.Add( "DoPlayerDeath", "RDMItemDrop", dropItems )

function playerSpawn( ply ) -- Assign each new player the proper class

  player_manager.SetPlayerClass( ply, "player_default" )

end
hook.Add( "PlayerSpawn", "RDMPlayerJoin", playerSpawn )

function giveAmmo( ply, wep )

  local prev = ply:GetAmmoCount( wep:GetPrimaryAmmoType() )

  local clip = 0 -- Make sure the clip size is at least 1 (grenades & rpg will claim to have a clip size of -1)
  if wep:GetMaxClip1() <= 0 then
    clip = 1
  else
    clip = wep:GetMaxClip1()
  end

  ply:GiveAmmo( math.random( 1, 2 ) * clip, wep:GetPrimaryAmmoType(), true ) -- Give the player some ammo for their primary weapon

end
hook.Add( "PlayerCanPickupWeapon", "RDMGiveAmmo", giveAmmo )


print(">Done!")
