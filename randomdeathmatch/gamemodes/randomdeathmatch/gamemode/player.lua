print("player.lua")
--[[---------------------------------------------------------
	Name: gamemode:PlayerDeath()
	Desc: Called when a player dies.
-----------------------------------------------------------]]
function GM:PlayerDeath(ply, inflictor, attacker)
  	-- Don't spawn for at least 2 seconds
  	ply.NextSpawnTime = CurTime() + 2
  	ply.DeathTime = CurTime()

  	if ( IsValid( attacker ) && attacker:GetClass() == "trigger_hurt" ) then attacker = ply end

  	if ( IsValid( attacker ) && attacker:IsVehicle() && IsValid( attacker:GetDriver() ) ) then
  		attacker = attacker:GetDriver()
  	end

  	if ( !IsValid( inflictor ) && IsValid( attacker ) ) then
  		inflictor = attacker
  	end

  	-- Convert the inflictor to the weapon that they're holding if we can.
  	-- This can be right or wrong with NPCs since combine can be holding a
  	-- pistol but kill you by hitting you with their arm.
  	if ( IsValid( inflictor ) && inflictor == attacker && ( inflictor:IsPlayer() || inflictor:IsNPC() ) ) then

  		inflictor = inflictor:GetActiveWeapon()
  		if ( !IsValid( inflictor ) ) then inflictor = attacker end

  	end

  	if ( attacker == ply ) then

  		net.Start( "PlayerKilledSelf" )
  			net.WriteEntity( ply )
  		net.Broadcast()

  		MsgAll( attacker:Nick() .. " suicided!\n" )

  	return end

  	if ( attacker:IsPlayer() ) then

  		net.Start( "PlayerKilledByPlayer" )

  			net.WriteEntity( ply )
  			net.WriteString( inflictor:GetClass() )
  			net.WriteEntity( attacker )

  		net.Broadcast()

  		MsgAll( attacker:Nick() .. " killed " .. ply:Nick() .. " using " .. inflictor:GetClass() .. "\n" )

  	return end

  	net.Start( "PlayerKilled" )

  		net.WriteEntity( ply )
  		net.WriteString( inflictor:GetClass() )
  		net.WriteString( attacker:GetClass() )

  	net.Broadcast()

  	MsgAll( ply:Nick() .. " was killed by " .. attacker:GetClass() .. "\n" )
end


--[[---------------------------------------------------------
   Name: gamemode:DoPlayerDeath( )
   Desc: Carries out actions when the player dies. Drop weapons and ammo here.
---------------------------------------------------------]]
function GM:DoPlayerDeath(ply, attacker, dmginfo)
	ply:CreateRagdoll()

	ply:AddDeaths( 1 )

	if ( attacker:IsValid() && attacker:IsPlayer() ) then
		if ( attacker == ply ) then
			attacker:AddFrags( -1 )
		else
			attacker:AddFrags( 1 )

      if math(2) == 2 then
        if attacker:Armor() < 100 then
          if attacker:Armor() > 90 then
            attacker:SetArmor(100)
          else
            attacker:SetArmor(attacker:Armor() + 10)
          end

          attacker:ChatPrint("You got ten armor from that kill!")
        end
      end

      if firstBlood == false then
        firstBlood = true

        for k, v in pairs(player.GetAll()) do
      	   v:PrintMessage(HUD_PRINTCENTER, attacker:GetName() .. " has taken first blood!")
        end
      end
		end
	end

  if !has_value(noDrop, ply:GetActiveWeapon():GetClass()) then
    local wep = ply:GetActiveWeapon()
    local ammo = wep:GetPrimaryAmmoType()

    if ammo ~= nil then
      if wep:GetVar("HomeTable") == "weapons" then
        local count = ply:GetAmmoCount(ammo)

        if (wep:Clip1() >= 0) then count = count - wep:Clip1() end

        wep:SetVar("DropAmmo", count/2)
      end

      ply:SetAmmo(0, ammo)
    end

    wep:SetVar("DropTime", CurTime())
    ply:DropWeapon(wep)
  end

  for k, v in pairs(ply:GetWeapons()) do
    local class = v:GetClass()
    local ammo = v:GetPrimaryAmmoType()

    if ammo ~= nil then
      if v:GetVar("HomeTable") == "weapons" then
        local count = ply:GetAmmoCount(ammo)

        if (v:Clip1() >= 0) then count = count - v:Clip1() end

        v:SetVar("DropAmmo", count/2)
      end

      ply:SetAmmo(0, ammo)
    end

    if math.random(2) == 2 and !has_value(noDrop, class) then
      v:SetVar("DropTime", CurTime())
      ply:DropWeapon(v)
    else
      ply:StripWeapon(v:GetClass())
    end
  end
end


--[[---------------------------------------------------------
	Name: gamemode:PlayerSpawn()
	Desc: Called when a player spawns.
-----------------------------------------------------------]]
function GM:PlayerSpawn(ply)
  ply:SetVar("Spawning", true)
	-- Stop observer mode
	ply:UnSpectate()

	ply:SetupHands()

	player_manager.OnPlayerSpawn(ply)
	player_manager.RunClass(ply, "Spawn")

	-- Call item loadout function
	hook.Call("PlayerLoadout", GAMEMODE, ply)

	-- Set player model
	hook.Call("PlayerSetModel", GAMEMODE, ply)

  ply:SetVar("SpawnTime", CurTime())
  ply:SetVar("Spawning", false)
end


--[[---------------------------------------------------------
	Name: gamemode:PlayerLoadout()
	Desc: Give the player their random weapons/ammo.
-----------------------------------------------------------]]
function GM:PlayerLoadout(ply)
  ply:Give("weapon_fists")

  local rand = math.random(100)

  if rand <= 50 then
    local class = spawnMelee[math.random(#spawnMelee)]

    ply:Give(class)
    ply:GetWeapon(class):SetVar("HomeTable", "melee")
    ply:GetWeapon(class):SetVar("SpawnWep", true)
  end

  if rand <= 25 then
    local class = spawnAuxiliary[math.random(#spawnAuxiliary)]

    ply:Give(class)
    ply:GetWeapon(class):SetVar("HomeTable", "auxiliary")
    ply:GetWeapon(class):SetVar("SpawnWep", true)
  end

  local weaponClass = spawnWeapons[math.random(#spawnWeapons)]
  ply:Give(weaponClass)
  local weapon = ply:GetWeapon(weaponClass)
  local ammo = weapon:Clip1() * math.random(4)

  if ammo <= 0 then
    ammo = math.random(4)
  end

  ply:SetAmmo(ammo, weapon:GetPrimaryAmmoType())
  weapon:SetVar("HomeTable", "weapons")
  weapon:SetVar("SpawnWep", true)

  ply:SelectWeapon("weapon_fists")
end


--[[---------------------------------------------------------
	Name: gamemode:PlayerSetModel()
	Desc: Set the player's model
-----------------------------------------------------------]]
function GM:PlayerSetModel(ply)
  ply:SetModel("models/player/odessa.mdl")
end


--[[---------------------------------------------------------
	Name: gamemode:GetFallDamage()
	Desc: return amount of damage to do due to fall (emulate CS:S fall damage)
-----------------------------------------------------------]]
function GM:GetFallDamage(ply, speed)
	return math.max(0, math.ceil( 0.2418*speed - 141.75 ))
end


function GM:PlayerCanPickupWeapon(ply, wep)
  if ply:GetVar("Spawning") == true then
    return true
  else
    if wep:GetVar("HomeTable") == "weapons" then
      local ammo = wep:GetVar("DropAmmo")

      if (ammo == nil) then ammo = wep:Clip1() * math.random(2) end
      if (ammo == nil) then ammo = math.random(50) end

	    ply:GiveAmmo(wep:GetVar("DropAmmo"), wep:GetPrimaryAmmoType())
    end
    return true
  end
end


function GM:PlayerInitialSpawn(ply)
  for k, v in pairs(player.GetAll()) do
	   v:ChatPrint(ply:GetName() .. " joined the fight!")
  end
end

function GM:PlayerDeathThink(ply)
  if respawn == true and ply.NextSpawnTime and ply.NextSpawnTime < CurTime() then
    if ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) then
	  ply:Spawn()
	  return true
	end
  else
    return false
  end
end
print(">Done!")
