AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_pickteam.lua")
AddCSLuaFile("VGUI/team_select_menu.lua")
AddCSLuaFile("VGUI/HUD.lua")
AddCSLuaFile("cl_win.lua")
AddCSLuaFile("cl_endscreen.lua")
AddCSLuaFile("cl_deathnotification.lua")
AddCSLuaFile("fonts.lua")
AddCSLuaFile("cl_playeridentifiers.lua")


include( "shared.lua" )
include( "stats/stats.lua" )
include( "player.lua" )
include( "win.lua" )
include("player_class/player_custom.lua")

DEFINE_BASECLASS( "gamemode_base" )

util.AddNetworkString( "SendDeathNotice" )

Constant_ClassGear = {}
Constant_ClassGear[3] = {"gb_weaponmedkit"}

GameFinishDownTime = 5 --The time that the game will be inactive before starting


function GM:PlayerSpawn( ply )
	ply:SetModel("models/player/group01/male_07.mdl")
	player_manager.SetPlayerClass( ply, "player_custom" )
	ply:SetMaxHealth( 100 )
	ply:SetHealth( 100 )
	ply:SetRunSpeed(300)
	ply:SetWalkSpeed(150)
	ply:SetNWInt( "LegHealth", 100 )
	ply.LegHealth = ply:GetNWInt( "LegHealth", 100)
	ply:ClassGear()
	ply:SetViewOffset(Vector(0,0,58))
	ply:SetupHands() -- Create the hands and call GM:PlayerSetHandsModel
	ply:ChatPrint( "Press F1 to change Class" )
end

function GM:PlayerSpawn( ply )
	ply:SetModel("models/player/group01/male_07.mdl")
	player_manager.SetPlayerClass( ply, "player_b1" )
	ply:SetMaxHealth( 100 )
	ply:SetHealth( 100 )
	ply:SetRunSpeed(300)
	ply:SetWalkSpeed(150)
	ply:SetNWInt( "LegHealth", 100 )
	ply.LegHealth = ply:GetNWInt( "LegHealth", 100)
	ply:ClassGear()
	ply:SetViewOffset(Vector(0,0,58))
	ply:SetupHands() -- Create the hands and call GM:PlayerSetHandsModel
	ply:ChatPrint( "Press F1 to change Class" )
end

function GM:PlayerDeathThink( ply )
	if ( ply.NextSpawnTime and ply.NextSpawnTime > CurTime() or MatchStatus != 1 ) then return end
	if ply:KeyPressed( IN_ATTACK ) then
		ply:Spawn()
	end
	if ply:IsBot() then
		ply:Spawn()
		
	end
end


-- Choose the model for hands according to their player model.
function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end
	
end

function GM:Initialize()
	team.SetScore( 1, 0 )
	team.SetScore( 2, 0 )
	MatchStatus = 1 -- 0 = match has not been started, 1 = match is in play
	print( "gbattle successfully started" )
end

function GM:PlayerConnect ( name, ip )
	print("Player: " .. name .. ", has joined the game.")
	
end

function GM:PlayerInitialSpawn( ply )
	print("Player: " .. ply:Nick() .. ", has spawned for the first time.")
	
	PrintMessage( HUD_PRINTTALK, "Player: " .. ply:Nick() .. ", has spawned.")
	ply:SetGamemodeTeam( team.BestAutoJoinTeam( ) )
	ply:SetNWInt("class", 1)
	ply.primaryweapon = "gbattle_weapm16"
	ply.secondaryweapon = "gbattle_weapg18"
end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print("Player: " .. ply:Nick() .. ", is now authorised.")
	ply:SetNWInt( "Strikes", 3 )
	
	if !ply:IsBot() then
		ply:dbStart()
	end
end

function GM:PlayerDisconnected( ply )
	if !ply:IsBot() then
		ply:dbFindKD()
		ply:dbWrite()
	end
end

function GM:GetFallDamage ( ply, speed )
	ply:DealLegDamage(math.floor(speed/100)*2)
	return ( speed / 100)
end

function GM:PlayerShouldTakeDamage( ply, attacker )
/*if attacker != game.GetWorld() then
	if ply:Team() == attacker:Team() && attacker != ply then
		return false
	end
end	*/
	
	return true
end



function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	local LegHealth = ply:GetNWInt("LegHealth", 0)
	if ( hitgroup == HITGROUP_HEAD ) then
 
		dmginfo:ScaleDamage( 4 )
 
	end
	
	if (hitgroup == HITGROUP_LEFTLEG or
	hitgroup == HITGROUP_RIGHTLEG) then
		if(LegHealth >= 0) then
			ply:DealLegDamage( dmginfo:GetDamage())
			dmginfo:ScaleDamage( 0 )
			else dmginfo:ScaleDamage(1)
		end
	end

		
		
	if ( hitgroup == HITGROUP_LEFTARM or
		 hitgroup == HITGROUP_RIGHTARM or 

		 hitgroup == HITGROUP_GEAR ) then
 
		dmginfo:ScaleDamage( 0.25 )
 
	 end

end



function GM:DoPlayerDeath( ply, attacker, dmginfo )
	if ply:GetActiveWeapon():IsValid() then
		ply:DropWeapon(ply:GetActiveWeapon())
	
	end
	
	if attacker:IsPlayer() and !attacker:IsBot() and attacker != ply and ply:Team() != attacker:Team() then
		attacker.db["kills"] = attacker.db["kills"] + 1
		attacker.db["xp"] = attacker.db["xp"] + 100
		if ( dmginfo.hitgroup == HITGROUP_HEAD ) then
 
			attacker.db["xp"] = attacker.db["xp"] + 50
			print("Headshot")
 
		end
	end
	
	if !ply:IsBot() then
		ply.db["deaths"] = ply.db["deaths"] + 1
	end

	ply:CreateRagdoll()
	
	ply:AddDeaths( 1 )
	
	if ( attacker:IsValid() && attacker:IsPlayer() ) then
	
		if ( attacker == ply or ply:Team() == attacker:Team() ) then
			if attacker != ply then
				attacker:TakeStrike(1)
				attacker:ChatPrint( "DON'T kill team mates!" )
				else ply:ChatPrint( "Try to avoid killing yourself." )
			end
			attacker:AddFrags( -1 )
		else
			attacker:AddFrags( 1 )
			team.AddScore( attacker:Team(), 1 )
		end
		
	end
	
	
end



concommand.Add( "gb_setscore", function( ply, cmd, args )
	team.SetScore( args[1], args[2] )
end )

concommand.Add( "bot_kill", function( ply, cmd, args ) 

	for i, k in pairs(player.GetAll()) do
		if k:IsBot() then
			k:Kill()
		end
	end

end)

function GM:Tick()
	for l, j in pairs(player.GetAll()) do
	
	if j.PressedKeysInitalTable then
		for v, k in pairs(j.PressedKeysInitalTable) do
			if !j:KeyDown(k) then
				table.remove(j.PressedKeysInitalTable, v)
				print("removed")
			end

		end
		
	end
	
	end
end

function GM:PlayerTick( ply, cmd)
	if cmd:KeyPressed(IN_JUMP) then

		cmd:SetVelocity(cmd:GetVelocity()*0.7)

	end
	
	
	if cmd:KeyPressed(IN_JUMP) and cmd:KeyDown(IN_USE) and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon().Droppable == true  then
	
		ply:DropWeapon( ply:GetActiveWeapon() )
	
	end
end


function GM:Think( )
	CheckScore()
end


function GM:EntityTakeDamage( entity, di )


	if entity:IsPlayer() then
		entity:ViewPunch(Angle(-di:GetDamage()/20,0,0))
		if di:IsDamageType(DMG_BULLET) then
			entity:SetVelocity(-entity:GetVelocity())
		end
	end


end

function GM:PlayerCanPickupWeapon( ply, wep )
	
	for v, k in pairs(ply:GetWeapons()) do
		if k.Slot == wep.Slot and !ply:GetWeapon(wep:GetClass()):IsValid() then
			return false
		end
	
	end
	
	
	return true
end

concommand.Add("gb_bot", function()

	local bot = ents.Create("PlayerBot")
	bot:Spawn()

end)
