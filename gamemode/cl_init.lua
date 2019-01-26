include ( "shared.lua" )
include( "cl_pickteam.lua" )
include( "cl_win.lua" )
include( "cl_endscreen.lua" )
include( "cl_deathnotification.lua" )
include( "VGUI/HUD.lua" )
include( "fonts.lua" )
include( "cl_playeridentifiers.lua")

LocalPlayer().LegHealth = 100


function GM:HUDPaintBackground()

end



function GM:HUDShouldDraw( name )
	if name == "CHudHealth" or name == "CHudAmmo" then
		return false
	end
	
	return true
end

net.Receive( "Leg_Health", function(  )
	LocalPlayer().LegHealth = net.ReadInt( 9 )

end )

function GM:CalcVehicleView( Vehicle, ply, view )
	if ( Vehicle.GetThirdPersonMode == nil || ply:GetViewEntity() != ply ) then
		-- This hsouldn't ever happen. also I copied this from the base.
		return
	end
	
	view.origin = Vehicle:GetPos() + ply:GetViewOffset()
	
	if !Vehicle.GetThirdPersonMode then
	
		view.origin = view.origin - view.angles:Forward() * 300
	
	end
	
	
	return view
end

function GM:Initialize()
	if ScrW() and ScrW() < 640 or ScrH() and ScrH() < 480 then
		local panel = vgui.Create( "DFrame" )
		panel:MakePopup()
		panel:SetTitle("Jimmies Russled")
		panel:SetSize(ScrW(),ScrH())
		
		local text = vgui.Create( "DListLayout" , panel)
		text:Add(Label("Your resolution appears to be smaller than 640x480,"))
		text:Add( Label("this will likely russel the jimmies of the gamemode!" ))
		text:Add( Label("In hindsight, I realize that this probably won't fit on the screen." ))
		text:Add( Label("Even still how do you play in a screen smaller than 640x480," ))
		text:Add( Label("most of the menus don't fit within the resolution I'm testing. ( 640x360 )" ))
		text:Add( Label("If you have made it this far, good for you, this was a challenge in itself." ))
		text:SetSize(ScrW(),ScrH())
		text:SetPos(10,30)
		
		
	end
end
DEFINE_BASECLASS( "gamemode_base" )



