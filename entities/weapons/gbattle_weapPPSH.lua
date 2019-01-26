if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="PPSH 9MM"
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
SWEP.ViewModel		="models/weapons/v_nik_ppsh1.mdl"
SWEP.WorldModel		="models/weapons/w_smg_ppsh.mdl"
SWEP.Weight			=5
SWEP.UseHands = true

SWEP.IronSightsPos = Vector(5, -0.711, 0.027)
SWEP.IronSightsAng = Vector(-0.083, 0.07, 0.072)

SWEP.LowerPos = Vector(-2,0,0)
SWEP.LowerAng = Vector(-10,-10,0)


SWEP.ViewModelFlip	=true
SWEP.HoldType	="ar2"
SWEP.m_WeaponDeploySpeed	= 1
SWEP.Zoom					= 50
SWEP.ADSSpeed				= 2000

SWEP.Primary.Damage		=120
SWEP.Primary.ClipSize	=50
SWEP.Primary.FireSelector = true
SWEP.Primary.Automatic	= true
SWEP.Primary.Spread			=0.005
SWEP.Primary.HipMultiplier	=0.1
SWEP.Primary.Projectiles 	=1
SWEP.Primary.Ammo		="gbattle_ammo762x51"
SWEP.Primary.RPM			=1000
SWEP.Primary.ShootSound		="Weapon_UMP45.Single"
SWEP.Primary.Recoil			=Angle( -0.85, 0, 0 )	//( Vertical, horizontal, Dont use )
SWEP.Primary.VisualRecoil	=0.2
SWEP.Primary.SideRecoil		=0.3
SWEP.IronSightAnim			=true
--SWEP.AnimCap = 0.08 --(Optional) How long until the animation resets, don't put in weapons that don't need to reset.

