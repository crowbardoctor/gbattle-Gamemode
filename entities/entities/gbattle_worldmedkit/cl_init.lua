include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
	--Using good ol' trig to point the numbers towards the player
	local xdist = self:GetPos().x - LocalPlayer():GetPos().x
	local ydist = self:GetPos().y - LocalPlayer():GetPos().y
	local drawangle = math.atan2(ydist, xdist) * 180 / math.pi
	--draws the amount of uses above the medkit
	cam.Start3D2D(self:GetPos()+ Vector(0,0,20), Angle(0,drawangle-90,90), 0.25/3)
		surface.SetFont( "Title" )
		--Draw the shadow
		surface.SetTextColor( 50,50,50, 255 )
		surface.SetTextPos( 2,2)
		surface.DrawText(self:GetNWInt("uses"))
		--Draw the surface
		surface.SetTextColor( 255, 255, 255, 255 )
		surface.SetTextPos( 0,0)
		surface.DrawText(self:GetNWInt("uses"))
	cam.End3D2D()

end