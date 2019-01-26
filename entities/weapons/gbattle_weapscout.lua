if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="Scout"
	SWEP.Author		="twity8149"
	
	SWEP.SlotPos	=1
	SWEP.BobScale	=0.1
	SWEP.DrawCrosshair = false
	SWEP.ScopeSprite = surface.GetTextureID("scope/scope_normal.vtf")
end
SWEP.Slot		=0
SWEP.Base = "weapon_gbbase"
SWEP.ViewModel		="models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel		="models/weapons/w_snip_scout.mdl"

SWEP.Zoom		=20
SWEP.IronSightAnim			=true

SWEP.IronSightsPos = Vector(0,0,0)
SWEP.IronSightsAng = Vector(0,0,0)
SWEP.Primary.Damage		=120
SWEP.Primary.ShootSound		="Weapon_Scout.Single"
SWEP.Primary.Automatic	= false
SWEP.Primary.VisualRecoil	=0.7
SWEP.Primary.RPM			=60
SWEP.Primary.Recoil			=Angle( -2, 0, 0 )
SWEP.Primary.SideRecoil = 0.2
SWEP.Primary.Spread			=0.001
SWEP.Primary.HipMultiplier	=0.2
SWEP.Primary.ClipSize	=9
SWEP.Primary.Ammo = "gbattle_ammo762x51"
