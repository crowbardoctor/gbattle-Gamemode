ENT.Base = "base_anim";
ENT.Type = "anim";

if SERVER then

	AddCSLuaFile()
	function ENT:Initialize()
		self:SetModel("models/Items/AR2_Grenade.mdl")
		self:PhysicsInitSphere( 5 )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:GetPhysicsObject():Wake()
		self:NextThink(CurTime())
	end

end