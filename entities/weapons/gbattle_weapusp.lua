if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="USP"
	SWEP.Author		="twity8149"
	
	SWEP.SlotPos	=1
	SWEP.BobScale	=0.1
	SWEP.DrawCrosshair = false
end
SWEP.Slot		=1
SWEP.Base = "weapon_gbbase"
SWEP.Spawnable		=true
SWEP.AdminSpawnable	=true
--SWEP.ViewModel		="models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.ViewModel		="models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel		="models/weapons/w_pist_usp.mdl"
SWEP.Weight			=5
SWEP.UseHands = true

SWEP.IronSightsPos = Vector(-5.86, 0.074, 2.717)
SWEP.IronSightsAng = Vector(-0.009, 0.14, 0)

SWEP.LowerPos = Vector(6.165, -1.254, -1.308)
SWEP.LowerAng = Vector(-8.759, 38.18, 3.081)
SWEP.AnimCap = 0.1 --(Optional) How long until the animation resets, don't put in weapons that don't need to reset.

SWEP.ViewModelFlip	=false
SWEP.HoldType	="revolver"
SWEP.m_WeaponDeploySpeed	= 1
SWEP.Zoom					= 70
SWEP.ADSSpeed				= 150
SWEP.IronSightAnim			=true

SWEP.Primary.Damage		=66
SWEP.Primary.ClipSize	=12
SWEP.Primary.FireSelector = false
SWEP.Primary.Automatic	= false
SWEP.Primary.Spread			=0.008
SWEP.Primary.HipMultiplier	=0.05
SWEP.Primary.Projectiles 	=1
SWEP.Primary.Ammo		="gbattle_ammo9x19"
SWEP.Primary.RPM			=666
SWEP.Primary.ShootSound		=  Sound("weapons/usp/usp_unsil-1.wav")
SWEP.Primary.Recoil			=Angle( -0.4, 0, 0 )	//( Vertical, horizontal, Dont use )
SWEP.Primary.VisualRecoil	=0.6
SWEP.Primary.SideRecoil		=0.1
SWEP.Primary.DefaultClip = 12*3
SWEP.Secondary.Ammo		=""