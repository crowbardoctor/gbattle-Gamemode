ENT.Base = "base_anim";
ENT.Type = "anim";

if SERVER then
AddCSLuaFile()
function ENT:Initialize()
	self.CreateTime = CurTime()
	--self:SetModel("models/weapons/w_missile.mdl")
	self:SetModel("models/weapons/w_missile_launch.mdl")
	self:PhysicsInitSphere( 5 )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:GetPhysicsObject():Wake()
	self:NextThink(CurTime())
end

function ENT:PhysicsUpdate(phys, dt)
	self:GetPhysicsObject():ApplyForceCenter(self:GetForward()*100)
end

function ENT:Think()
	
	self:NextThink(CurTime())
	return true

end

function ENT:PhysicsCollide(dat, col )

	util.BlastDamage(self, self.Owner,self:GetPos()+Vector(0,0,1),150,450)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale(0.1)
	util.Effect("Explosion", effectdata)
	self:Remove()
end

end

if CLIENT then 

function ENT:Draw()
	self:DrawModel()
end
function ENT:DrawTranslucent()

	self:Draw()
	
end
	
end