AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local heal_rate = 20
local heal_sound = "HealthKit.Touch"
local occupied_sound = "WallHealth.Deny"

function ENT:Initialize()
	self.NextSound = CurTime();
	self.NextUse = CurTime();
	self:SetNWInt("uses", 5)
	self:SetModel("models/weapons/w_medkit.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:GetPhysicsObject():Wake()
end

function ENT:OnRemove()
end

function ENT:Use( activator, caller )
	if self.NextUse < CurTime()  and caller:Health() < caller:GetMaxHealth()then
	
		if (caller:Health() + heal_rate < caller:GetMaxHealth()) then
			caller:SetHealth(caller:Health() + heal_rate)
			caller:SetNWInt( "LegHealth", 100)
			else caller:SetHealth(caller:GetMaxHealth())
		end
		
		if self.Owner and caller != self.Owner then
			self.Owner.db["xp"] = self.Owner.db["xp"] + 50
			print( self.Owner:Nick() .. " Healed " .. caller:Nick() )
		end
		if CurTime() > self.NextSound then self:EmitSound( heal_sound );
			self.NextSound = CurTime() + 0.5 end
		self:SetNWInt("uses", self:GetNWInt("uses") - 1)
		self.NextUse = CurTime() + 0.5
		else if CurTime() > self.NextSound then self:EmitSound( occupied_sound );
			self.NextSound = CurTime() + 0.5  end
	end
end

function ENT:OnTakeDamage( damagetype )
	self:Remove()
end



function ENT:PostIntialize()

end
 




function ENT:Think()

	if self.NextUse > CurTime() then
	
		self:SetColor(Color(100,0,0))
		else self:SetColor(Color(255,255,255))
	
	end
	if self:GetNWInt("uses") < 1 then
		self:Remove()
	end
	self:NextThink( CurTime() )
	return true
end

