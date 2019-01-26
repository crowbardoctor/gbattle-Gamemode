if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="G18"
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
SWEP.ViewModel		="models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel		="models/weapons/w_pist_glock18.mdl"
SWEP.Weight			=5
SWEP.UseHands = true

SWEP.IronSightsPos = Vector(-5.794, 0.057, 2.68)
SWEP.IronSightsAng = Vector(0.638, 0, -2.892)

SWEP.LowerPos = Vector(6.165, -1.254, -1.308)
SWEP.LowerAng = Vector(-8.759, 38.18, 3.081)


SWEP.ViewModelFlip	=false
SWEP.HoldType	="revolver"
SWEP.m_WeaponDeploySpeed	= 1
SWEP.Zoom					= 70
SWEP.ADSSpeed				= 150
SWEP.IronSightAnim			=true

SWEP.Primary.Damage		=45
SWEP.Primary.ClipSize	=19
SWEP.Primary.FireSelector = true
SWEP.Primary.Automatic	= true
SWEP.Primary.Spread			=0.008
SWEP.Primary.HipMultiplier	=0.08
SWEP.Primary.Projectiles 	=1
SWEP.Primary.Ammo		="gbattle_ammo9x19"
SWEP.Primary.RPM			=900
SWEP.Primary.ShootSound		=  Sound("weapons/glock/glock18-1.wav")
SWEP.Primary.Recoil			=Angle( -0.4, 0, 0 )	//( Vertical, horizontal, Dont use )
SWEP.Primary.VisualRecoil	=0.6
SWEP.Primary.SideRecoil		=0.3
SWEP.Primary.DefaultClip = 19*3
SWEP.Secondary.Ammo		=""