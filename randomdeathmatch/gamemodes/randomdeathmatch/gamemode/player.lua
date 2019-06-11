print("player.lua")

-- Function to drop player's items.
-- This will be called when a player dies via the DoPlayerDeath hook.
function dropItems(ply)

  -- Drop the player's active weapon as long as it is not in the noDrop table.
  if !has_value(RDMTables.noDrop, ply:GetActiveWeapon():GetClass()) then
    local wep = ply:GetActiveWeapon();

    -- Switch the player's active weapon to fists
    -- This should send a sort of "unequip" signal to the weapon so that it can
    -- stop playing music, etc. before being dropped.
    ply:SelectWeapon("weapon_fists")

    -- Do the drop.
    ply:DropWeapon(wep)
  end

  -- Drop the other weapons in the player's inventory.
  for i, wep in pairs(ply:GetWeapons()) do
    -- Store the weapon class for checking against tables.
    local class = wep:GetClass()

    -- Drop about half of weapons that are not in the noDrop table.
    if math.random(2) == 2 and !has_value(RDMTables.noDrop, class) then
      ply:DropWeapon(wep);
    else -- Otherwise simply strip them, for cleanliness upon respawn.
      ply:StripWeapon(class)
    end
  end
end

-- Function to give a player a random weapon from a table of weapon classes
-- This will be used in randomLoadout and the PlayerLoadout hook
-- Returns the weapon entity that was given.
function giveFromTable(tab, ply)
  local class = tab[math.random(#tab)]

  ply:Give(class)

  return ply:GetWeapon(class)
end

-- Function to give a random loadout (from RDMTables) to a player.
-- This will be called when a player spawns via the PlayerLoadout hook.
function randomLoadout(ply)
  -- Every player will have at least their fists.
  ply:Give("weapon_fists");

  -- Get a random number up to 100 for calculating chances.
  local rand = math.random(100)

  -- 50% chance of a player getting a melee weapon from the melee table.
  if rand <= 50 then
    giveFromTable(RDMTables.melee, ply);
  end

  -- 25% chance of getting a weapon from the auxiliary table.
  if rand <= 25 then
    giveFromTable(RDMTables.auxiliary, ply)
  end

  -- Give the player their primary weapon.
  local weapon = giveFromTable(RDMTables.primary, ply)
  -- Generate a random amount of ammo to give the player based off of the clip size
  -- of the primary weapon. Some weapons (such as grenades or rpg) are a pain in
  -- the ass, and have a maximum clip size of -1. A quick and dirty if statement
  -- can fix that.
  local ammo = 0

  if weapon:GetMaxClip1() == -1 then
    ammo = math.random(2, 4)
  else
    ammo = weapon:GetMaxClip1() * math.random(2, 4)
  end

  -- Set the player's ammo equal to the random amount generated.
  ply:SetAmmo(ammo, weapon:GetPrimaryAmmoType())

  ply:SelectWeapon("weapon_fists")
end



-- Function that we will add to the PlayerDeath hook
function playerDeath(ply, attacker, inflictor)
  -- Nothing in here yet.
end

-- Function that we will add to the DoPlayerDeath hook.
-- This should cause the victim to drop their weapons, and maybe give the attacker some health or armor as a bonus.
function doPlayerDeath(ply, attacker, dmg)
  dropItems(ply)
  -- Create the player's ragdoll.
  ply:CreateRagdoll();
end

-- Function that we will add to the PlayerSpawn hook.
function playerSpawn(ply)
  -- Nothing here yet.
end

-- Function that we will ad to the PlayerInitialSpawn hook
-- Just sets the player's model, because something in here broke the default method to do so.
-- **TEMPORARY FIX**, hopefully.
function playerJoin(ply)
  ply:SetModel(RDMTables.models[math.random(#RDMTables.models)]);
end



-- We are overwriting the base PlayerLoadout method because otherwise we have to
-- create our own player class just to get rid of the pistol that player's spawn
-- with.
function GM:PlayerLoadout(ply)
  randomLoadout(ply)
end

-- Also just overwrite the fall damage method, because that maximum of 10 is just stupid.
-- This was stolen from the GMod wiki. It's meant to imitate CS:S fall damage.
function GM:GetFallDamage( ply, speed )
	return math.max( 0, math.ceil( 0.2418*speed - 141.75 ) )
end



-- Add the hooks
hook.Add( "DoPlayerDeath", "RDMDoPlayerDeath", doPlayerDeath )
hook.Add( "PlayerDeath", "RDMPlayerDeath", playerDeath )
hook.Add( "PlayerSpawn", "RDMPlayerSpawn", playerSpawn )
hook.Add( "PlayerInitialSpawn", "RDMPlayerJoin", playerJoin )

print(">Done!")
