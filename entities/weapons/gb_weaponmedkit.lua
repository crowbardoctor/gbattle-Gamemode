if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="Medkit"
	SWEP.Author		="twity8149"
	SWEP.Slot		=2
	SWEP.SlotPos	=1
	SWEP.BobScale	=0.1
	SWEP.DrawCrosshair = false
end
SWEP.Spawnable		=true
SWEP.AdminSpawnable	=true
SWEP.ViewModel		="models/weapons/c_medkit.mdl"
SWEP.WorldModel		="models/weapons/w_medkit.mdl"
SWEP.UseHands = true
SWEP.m_WeaponDeploySpeed	= 1
SWEP.Droppable = false

SWEP.Primary.Ammo = "None"

function SWEP:PrimaryAttack()
	if SERVER then
		local trace = util.TraceLine({start = self.Owner:EyePos(), endpos = self.Owner:EyePos() + self.Owner:GetAimVector() * 60,
		filter = {self.Owner}})
		local medkit = ents.Create("gbattle_worldmedkit")
		medkit:SetPos(trace.HitPos - self.Owner:GetAimVector() * 10)
		medkit.Owner = self.Owner
		medkit:Spawn()
		medkit:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector()*300)
	end
	self.Weapon:SetNextPrimaryFire( CurTime() + 2 )
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()

end