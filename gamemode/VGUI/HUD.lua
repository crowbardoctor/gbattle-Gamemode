if CLIENT then
EndTime = 0

hook.Add( "HUDPaint", "ScoreDrawHook", ScoreDraw ) 
local teamscoretex = surface.GetTextureID( "teamscore.vtf" )
function ScoreDraw()

	surface.SetDrawColor(0,0,0,200)
	surface.SetTexture( teamscoretex )
	surface.DrawTexturedRect( ScrW() / 2 - 128, ScrH() - 90, 256, 128 )
	draw.SimpleText( team.GetScore( 1 ) .. "       " .. team.GetScore( 2 ), "Score", (ScrW() / 2) + 1, ScrH() - 1 - 25, Color( 100, 100, 100, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	draw.SimpleText( team.GetScore( 1 ) .. "       " .. team.GetScore( 2 ), "Score", ScrW() / 2, ScrH() - 25, Color_White, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	
end

function CrippledLegs()
	if(LocalPlayer():GetNWInt( "LegHealth" ) and LocalPlayer():GetNWInt( "LegHealth" )<0)then
		
	end
end

function GM:HUDDrawTargetID()
	
	local tracer1 = util.GetPlayerTrace( LocalPlayer() )
	local tracer2 = util.TraceLine( tracer1 )
	local FriendLeghealth = tracer2.Entity:GetNWInt( "LegHealth", 100 )
	if(tracer2.Hit and tracer2.HitNonWorld  and tracer2.Entity:IsPlayer() and LocalPlayer():Team() == tracer2.Entity:Team()) then
		draw.SimpleText( "Friend: " .. tracer2.Entity:Nick(), "Score",ScrW()/2+3,ScrH()/2+13,Color(0,0,0,255),TEXT_ALIGN_CENTER)
		draw.SimpleText( "Friend: " .. tracer2.Entity:Nick(), "Score",ScrW()/2,ScrH()/2+10,Color(55,145,10,255),TEXT_ALIGN_CENTER)
		print( FriendLeghealth )
		end
	
	return
end

function GM:HUDDrawHealth()
	draw.SimpleText("Health: " .. LocalPlayer():Health(), "Score", 8, ScrH()+3,Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText("Health: " .. LocalPlayer():Health(), "Score", 5, ScrH(),Color_White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	if LocalPlayer():GetNWInt( "LegHealth", 100 ) > 0 then
		draw.SimpleText("Legs Health: " .. LocalPlayer():GetNWInt( "LegHealth", 100 ), "Score", 8, ScrH()-22,Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Legs Health: " .. LocalPlayer():GetNWInt( "LegHealth", 100 ), "Score", 5, ScrH()-25,Color_White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		else draw.SimpleText("Your legs are crippled, find a medic!", "Score", 8, ScrH()-22,Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Your legs are crippled, find a medic!", "Score", 5, ScrH()-25,Color_White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
end

function DeathTimer()
	local DisplayTime = 4-math.floor(CurTime() - EndTime)
	surface.SetFont("Score")
	surface.SetTextPos(0,0)
	if DisplayTime > 0 then
		surface.DrawText("Next round in: " .. DisplayTime)
	end

end

function GM:HUDPaint()
	hook.Run( "HUDDrawTargetID" )
	hook.Run("HUDDrawHealth")

end
hook.Add( "HUDPaint", "DeathNoticeDrawHook", DeathNotificationDraw )
hook.Add( "HUDPaint", "ScoreDrawHook", ScoreDraw )
hook.Add( "HUDPaint", "CrippledLegsHook", CrippledLegs )
hook.Add( "HUDPaint", "ResetTimeHud", DeathTimer)
end