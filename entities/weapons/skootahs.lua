if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.HoldType	="ar2"
end

if (CLIENT) then
	SWEP.PrintName	="Skootahs peece"
	SWEP.Author		="twity8149"
	SWEP.Slot		=2
	SWEP.SlotPos	=1
end

SWEP.Spawnable		=true
SWEP.AdminSpawnable	=true
SWEP.ViewModel		="models/weapons/c_pistol.mdl"
SWEP.WorldModel		="models/weapons/w_pistol.mdl"
SWEP.Weight			=5
SWEP.AutoSwitchTo	=false
SWEP.AutoSwitchFrom	=false
SWEP.UseHands = true

SWEP.Primary.Damage		=17
SWEP.Primary.ClipSize	=21

SWEP.Primary.Automatic		=false
SWEP.Primary.Ammo			="smg1"
SWEP.Primary.Spread			=0.1
SWEP.Primary.Projectiles 	=1
SWEP.Secondary.Ammo			=""

function SWEP:PrimaryAttack()

	
	if ( !self:CanPrimaryAttack() ) then return end
		self.Weapon:ShootBullet( self.Primary.Damage, self.Primary.Projectiles, self.Primary.Spread)
		self:TakePrimaryAmmo( 1 )
		self:EmitSound( "Weapon_Pistol.Single" )
		timer.Create( "bullet_fire", 0.03, 2, function()
		self.Weapon:ShootBullet( self.Primary.Damage, 1, 0.01)
		self:TakePrimaryAmmo( 1 )
		self:EmitSound( "Weapon_Pistol.Single" )
		end )
		timer.Start( "bullet_fire" )
		if timer.RepsLeft( "bullet_fire" ) < 1 then
			timer.Destroy( "bullet_fire" )
		end
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.1) 
end

function SWEP:SecondaryAttack()

	return

end

zoom = nil

function SWEP:Tick()

	if( self.Owner:KeyDown( IN_ATTACK2 ) ) then
		self.Weapon:GetOwner():SetFOV( 65, 0.8 )
		else self.Weapon:GetOwner():SetFOV( 0, 0.8 )
	end
end





