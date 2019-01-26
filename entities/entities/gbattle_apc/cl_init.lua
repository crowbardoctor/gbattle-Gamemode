include("shared.lua")

function ENT:Draw()

	self:DrawModel()
	cam.Start2D()
		surface.DrawLine(ScrW()/2,ScrH()/2,ScrW()/2,ScrH()/2+30)
	cam.End2D()

end