if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="AKM"
	SWEP.Author		="twity8149"
	
	SWEP.SlotPos	=1
	SWEP.BobScale	=0.1
	SWEP.DrawCrosshair = false
end
SWEP.Slot		=0
SWEP.Base = "weapon_gbbase"
SWEP.ViewModel		="models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel		="models/weapons/w_rif_ak47.mdl"



SWEP.IronSightsPos = Vector(-6.533, -8.99, 2.526)
SWEP.IronSightsAng = Vector(2.355, 0.07, 0)
SWEP.Primary.Damage		=100
SWEP.Primary.ShootSound		="Weapon_AK47.Single"
SWEP.Primary.Automatic	= true
SWEP.Primary.VisualRecoil	=0.7
SWEP.Primary.RPM			=600
SWEP.Primary.Recoil			=Angle( -1, 0, 0 )
SWEP.Primary.SideRecoil = 0.1
SWEP.Primary.Ammo = "gbattle_ammo762x39"
SWEP.IronSightAnim			=true
SWEP.AnimCap = 0.1 --(Optional) How long until the animation resets, don't put in weapons that don't need to reset.