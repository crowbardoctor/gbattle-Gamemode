if SERVER then

	AddCSLuaFile();

end

ENT.Base = "base_nextbot"

function ENT:Initialize()

	self:SetModel("models/player/group01/male_07.mdl")

end


function ENT:Think()

	if !self:Alive() then
		self:Spawn()
	end

end