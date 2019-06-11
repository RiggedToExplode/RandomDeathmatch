print("[Random Deathmatch] Loading...")

DeriveGamemode( "base" )

AddCSLuaFile( "rdm_cl.lua" )
AddCSLuaFile( "rdm_sh.lua" )

include( "rdm_sv.lua" )

print("[Random Deathmatch] Loaded!")
