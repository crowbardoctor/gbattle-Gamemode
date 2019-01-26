if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="AT4"
	SWEP.Author		="twity8149"
	SWEP.Slot		=2
	SWEP.SlotPos	=1
	SWEP.BobScale	=0.1
	SWEP.DrawCrosshair = false
end
SWEP.Spawnable		=true
SWEP.AdminSpawnable	=true
SWEP.ViewModel		="models/weapons/c_rpg.mdl"
SWEP.WorldModel		="models/weapons/w_missile_launch.mdl"
SWEP.UseHands = true

SWEP.m_WeaponDeploySpeed	= 1
SWEP.Primary.ClipSize	= 1
SWEP.Primary.Ammo		=	"gbattle_ammoRocket"
SWEP.Primary.DefaultClip = 4

SWEP.Secondary.Ammo = ""

SWEP.Droppable = false
SWEP.HoldType = "models/weapons/c_rpg.mdl"


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self:TakePrimaryAmmo( 1 )
	if SERVER then
		local trace = util.TraceLine({start = self.Owner:EyePos(), endpos = self.Owner:EyePos() + self.Owner:GetAimVector() * 60,
		filter = {self.Owner}})
		local rocket = ents.Create("gbattle_AT4Rocket")
		rocket:SetPos(trace.HitPos - self.Owner:EyeAngles():Forward() * 10 + self.Owner:EyeAngles():Right() * 3)
		rocket:SetAngles(self.Owner:EyeAngles())
		rocket.Owner = self.Owner
		rocket:Spawn()
		if rocket:GetPhysicsObject():IsValid() then rocket:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector()*1000) end
	end
	self:EmitSound( "weapon_m4a1.Single" )
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.1 )
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

end

function SWEP:CanPrimaryAttack()

	if ( self.Weapon:Clip1() <= 0 ) then
		--self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false
		
	end
	
	if self.Owner:KeyDown( IN_SPEED ) then
	
		self:SetNextPrimaryFire( CurTime() + 0.25 )
		return false
		
	end

	return true

end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
end