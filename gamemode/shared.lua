GM.Name = "gbattle"
GM.Author = "twitybailie"
GM.Email = "N/A"
GM.Website = "N/A"

resource.AddFile( "materials/teamscore.vtf" )
resource.AddFile( "materials/teamscore.vmt" )

include( "VGUI/team_select_menu.lua" )

game.AddAmmoType({
	name = "gbattle_ammo556"
})
game.AddAmmoType({
	name = "gbattle_ammo762x39"
})
game.AddAmmoType({
	name = "gbattle_ammo762x51"
})

game.AddAmmoType({
	name = "gbattle_ammo9x19"
})

game.AddAmmoType({
	name = "gbattle_ammoRocket"
})

if CLIENT then
	
end

GM.TeamBased = true



function GM:CreateTeams()
	Destruct = 2
	team.SetUp(Destruct, "Destruct Task Force", Color(0,100,0), true)
	team.SetSpawnPoint( Destruct, {"info_player_counterterrorist", "info_player_combine", "info_player_deathmatch", "info_player_axis"})
	Militia = 1
	team.SetUp(Militia, "Gmod Militia", Color(0,0,100), true)
	team.SetSpawnPoint( Militia, {"info_player_terrorist", "info_player_rebel", "info_player_deathmatch", "info_player_allies"})
end

function math.Sign( number )
	if number >= 0 then
		return 1
		else return -1
	end

end



DEFINE_BASECLASS( "gamemode_base" )