if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
	/*resource.AddFile( "models/weapons/v_rif_scar.mdl" )
	resource.AddFile( "models/weapons/w_rif_scar.mdl" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/SCAR_diff.vmt" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/scar_exponent.vtf" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/scar_diff.vtf" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/scar_bump.vtf" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/Mag_Pad_N.vtf" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/Mag_Pad.vtf" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/Mag_Pad.vmt" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/mag_exponent.vtf" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/mag_diff.vtf" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/mag_diff.vmt" )
	resource.AddSingleFile( "materials/models/weapons/v_models/slayers_scarh/mag_bump.vtf" )*/
end

if (CLIENT) then
	SWEP.PrintName	="SCAR"
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
SWEP.ViewModel		="models/weapons/v_rif_scar.mdl"
SWEP.WorldModel		="models/weapons/w_rif_scar.mdl"
SWEP.Weight			=5
SWEP.UseHands = true

SWEP.IronSightsPos = Vector(-2.77, -0.711, 0.027)
SWEP.IronSightsAng = Vector(-0.083, 0.07, 0.072)

SWEP.LowerPos = Vector(6.165, -1.254, -1.308)
SWEP.LowerAng = Vector(-8.759, 38.18, 3.081)


SWEP.ViewModelFlip	=false
SWEP.HoldType	="ar2"
SWEP.m_WeaponDeploySpeed	= 1
SWEP.Zoom					= 50
SWEP.ADSSpeed				= 2000

SWEP.Primary.Damage		=120
SWEP.Primary.ClipSize	=20
SWEP.Primary.FireSelector = true
SWEP.Primary.Automatic	= true
SWEP.Primary.Spread			=0.005
SWEP.Primary.HipMultiplier	=0.2
SWEP.Primary.Projectiles 	=1
SWEP.Primary.Ammo		="gbattle_ammo762x51"
SWEP.Primary.RPM			=650
SWEP.Primary.ShootSound		="Weapon_GALIL.Single"
SWEP.Primary.Recoil			=Angle( -0.85, 0, 0 )	//( Vertical, horizontal, Dont use )
SWEP.Primary.VisualRecoil	=0.8
SWEP.Primary.SideRecoil		=0.3
SWEP.IronSightAnim			=true
SWEP.AnimCap = 0.08 --(Optional) How long until the animation resets, don't put in weapons that don't need to reset.

