if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="M16"
	SWEP.Author		="twity8149"
	SWEP.SlotPos	=1
	SWEP.BobScale	=0.1
	SWEP.DrawCrosshair = false
end
SWEP.Slot		=0
SWEP.Base = "weapon_gbbase"
SWEP.Spawnable		=true
SWEP.AdminSpawnable	=true
--SWEP.ViewModel		="models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.ViewModel		="models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel		="models/weapons/w_rif_m4a1.mdl"
SWEP.Weight			=5
SWEP.UseHands = true

SWEP.IronSightsPos = Vector(-7.706, -7.454, 0.672)
SWEP.IronSightsAng = Vector(2.411, -1.354, -3.632)

SWEP.LowerPos = Vector(6.165, -1.254, -1.308)
SWEP.LowerAng = Vector(-8.759, 38.18, 3.081)


SWEP.ViewModelFlip	=false
SWEP.HoldType	="ar2"
SWEP.m_WeaponDeploySpeed	= 1
SWEP.Zoom					= 50
SWEP.ADSSpeed				= 150

SWEP.Primary.Damage		=60--45
SWEP.Primary.ClipSize	=30
SWEP.Primary.FireSelector = true
SWEP.Primary.Automatic	= true
SWEP.Primary.Spread			=0.005
SWEP.Primary.HipMultiplier	=0.08
SWEP.Primary.Projectiles 	=1
SWEP.Primary.Ammo		="gbattle_ammo556"
SWEP.Primary.RPM			=800
SWEP.Primary.ShootSound		="Weapon_M4A1.Single"
SWEP.Primary.Recoil			=Angle( -0.4, 0, 0 )	//( Vertical, horizontal, Dont use )
SWEP.Primary.VisualRecoil	=0.4
SWEP.Primary.SideRecoil		=0.15
SWEP.IronSightAnim			=false


SWEP.Secondary.Ammo		=""