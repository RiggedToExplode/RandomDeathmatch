print( "rdm_sv.lua ")

util.AddNetworkString( "RDMNumRequest" )
util.AddNetworkString( "RDMNumReturn" )

include( "rdm_sh.lua" )
include( "rdm_utils.lua" )
include( "rdm_tables.lua" )
include( "rdm_commands.lua" )
include( "rdm_player.lua" )
include( "rdm_post.lua" )

print( ">Done!" )
