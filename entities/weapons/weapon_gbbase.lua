if (SERVER) then
	AddCSLuaFile()
	SWEP.Weight	=5
	SWEP.AutoSwitchTo	=true
	SWEP.AutoSwitchFrom	=false
end

if (CLIENT) then
	SWEP.PrintName	="M16"
	SWEP.Author		="twity8149"
	SWEP.Slot		=0
	SWEP.SlotPos	=1
	SWEP.BobScale	=0.1
	SWEP.DrawCrosshair = false
end
SWEP.Spawnable		=true
SWEP.AdminSpawnable	=true
SWEP.ViewModel		="models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel		="models/weapons/w_rif_m4a1.mdl"
SWEP.Weight			=5
SWEP.UseHands = true
SWEP.Droppable = true

SWEP.IronSightsPos = Vector(-7.706, -7.454, 0.672)
SWEP.IronSightsAng = Angle(2.411, -1.354, -3.632)

SWEP.LowerPos = Vector(6.165, -1.254, -1.308)
SWEP.LowerAng = Vector(-8.759, 38.18, 3.081)
SWEP.CSMuzzleFlashes = true
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip	=false
SWEP.HoldType	="ar2"
SWEP.m_WeaponDeploySpeed	= 1
SWEP.Zoom					= 50
SWEP.ADSSpeed				= 150
SWEP.IronSightAnim			= false

SWEP.Primary.Damage		=1
SWEP.Primary.ClipSize	=30
SWEP.Primary.FireSelector = true
SWEP.Primary.Automatic	= true
SWEP.Primary.Spread			=0.005
SWEP.Primary.HipMultiplier	=0.08
SWEP.Primary.Projectiles 	=1
SWEP.Primary.Ammo		=	"gbattle_ammo556"
SWEP.Primary.RPM			=800
SWEP.Primary.ShootSound		="Weapon_M4A1.Single"
SWEP.Primary.Recoil			=Angle( -0.4, 0, 0 )	//( Vertical, horizontal, Dont use )
SWEP.Primary.VisualRecoil	=0.5
SWEP.Primary.SideRecoil = 1
SWEP.Primary.DefaultClip = 120
SWEP.Primary.RetractionRecoil = 1 -- the amount that the gun pushes back after each shot.
SWEP.VisualRecoil = 1
SWEP.ScopeSprite = nil


SWEP.Secondary.Ammo		=""

function SWEP:Initialize()
	self.Weapon.AimMultiplier = 0
	self.IronSights = false
	self:SetWeaponHoldType( self.HoldType )
	self.GetIronsights = false
	self.AnimEnd = CurTime()
	self.NextReloadTime = CurTime()
end

function SWEP:PrimaryAttack()
	
	local spreadcal = self.Primary.Spread
	local LastShootTime = self:LastShootTime()
	if self.GetIronsights == false then
		spreadcal = self.Primary.HipMultiplier
		print("big")
	elseif self.GetIronsights == true and self.Weapon.AimMultiplier >= 1 then
		spreadcal = self.Primary.Spread
		print("small")
	end
	
	if ( !self:CanPrimaryAttack() ) then return end

	self.Weapon:SetNextPrimaryFire(CurTime() + (60 / self.Primary.RPM) )
	self.NextReloadTime = CurTime() + 0.4
	self.Weapon:ShootBullet( self.Primary.Damage, self.Primary.Projectiles, spreadcal )
	self:TakePrimaryAmmo( 1 )
	self:EmitSound( self.Primary.ShootSound )
	if (CLIENT) or game.SinglePlayer() then
		self.Owner:SetEyeAngles( self.Owner:EyeAngles() + self.Primary.Recoil + Angle(0,math.random(-self.Primary.SideRecoil,self.Primary.SideRecoil),0))
	end
	self.Owner:ViewPunch( Angle( -0.05, 0, 0 ) )
	if self.IronSightAnim == false and self.GetIronsights == true then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)		//because css animations aren't meant for iron sights

	end
	if self.AnimCap then
	
		self.AnimEnd = CurTime() + self.AnimCap
	
	end
end


if CLIENT then

function SWEP:DrawHUD()
	local x = ScrW() / 2
	local y = ScrH() / 2 

    if self.ScopeSprite != nil and self.GetIronsights and self.Weapon.AimMultiplier >= 1 then
		surface.SetTexture(self.ScopeSprite)
		surface.SetDrawColor(0,0,0,255)
		surface.DrawTexturedRect(x-256,y-256,512,512)
		surface.DrawLine(x,0,x,ScrH())
		surface.DrawLine(0,y,ScrW(),y)
		surface.DrawRect(0,0,x-256,ScrH())
		surface.DrawRect(x-256,0,512,y-256)
		surface.DrawRect(x+256,0,x-256,ScrH())
		surface.DrawRect(x-256,y+256,512,y-256)
	end
	
	
end
end


function SWEP:SecondaryAttack()
	self:Firemode()
	return

end

zoom = nil

function SWEP:Tick()
	if(self.lasttime) then
		self.deltatime = CurTime() - self.lasttime

	end
		self.lasttime = CurTime()
	if( self.Owner:KeyPressed( IN_ATTACK2 ) && !self.Owner:KeyDown( IN_SPEED ) ) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		self.GetIronsights = true
		self.Weapon:GetOwner():SetFOV( self.Zoom, 0.3 )
		elseif( self.Owner:KeyReleased( IN_ATTACK2 ) or self.Owner:KeyDown( IN_SPEED ) ) then
		self.Weapon:GetOwner():SetFOV( 0, 0.3 )
		self.GetIronsights = false	
	end
	if(self.VisualRecoil > 0 and self.deltatime) then
		self.VisualRecoil = self.VisualRecoil - self.deltatime*10
		else self.VisualRecoil = 0
	end
	
	if self.AnimEnd and self.AnimEnd < CurTime() and self.GetIronsights == true then
	
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		self.AnimEnd = nil
		
	end
	
end

function SWEP:Firemode()

	if self.Owner:KeyDown( IN_USE ) and self.Primary.FireSelector then
		if self.Primary.Automatic then
			print("automatic");
			self.Primary.Automatic = false
			else self.Primary.Automatic = true;
			print("semi-automatic")
		end
	end

end

function SWEP:Reload()
	if self.NextReloadTime > CurTime() then return end
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
	self.GetIronsights = false
	self.Weapon:GetOwner():SetFOV( 0, 0.8 )
end

if CLIENT or game.SinglePlayer() then --added this
local IRONSIGHT_TIME = 0.25
function SWEP:GetViewModelPosition( pos, ang )
	
	if !self.Owner:IsValid() or !self.deltatime then return pos, ang end
	if self.GetIronsights == true then
		self.Weapon.AimMultiplier = math.Clamp(self.Weapon.AimMultiplier + self.deltatime*2,0,1)
		else self.Weapon.AimMultiplier = math.Clamp(self.Weapon.AimMultiplier - self.deltatime*2,0,1)
	end
	
	ang:RotateAroundAxis(ang:Up(), self.IronSightsAng.y * self.Weapon.AimMultiplier)
	ang:RotateAroundAxis(ang:Right(), self.IronSightsAng.x + self.VisualRecoil * self.Weapon.AimMultiplier)
	ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * self.Weapon.AimMultiplier)
	pos = pos + self.IronSightsPos.x * ang:Right() * self.Weapon.AimMultiplier
	pos = pos + self.IronSightsPos.y * ang:Forward() * self.Weapon.AimMultiplier
	pos = pos + self.IronSightsPos.z * ang:Up() * self.Weapon.AimMultiplier
	--pos = WorldToLocal(pos, ang, self.IronSightsPos * self.Weapon.AimMultiplier, Angle(0,0,0)  )
	
	return pos, ang

end

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

function SWEP:ShootBullet( damage, num_bullets, aimcone )
	
	local bullet = {}
	bullet.Num 		= num_bullets
	bullet.Src 		= self.Owner:GetShootPos() - Vector(0,0,1)			-- Source
	bullet.Spread 	= Vector( aimcone, aimcone, 0 )		-- Aim Cone
	bullet.Tracer	= 5									-- Show a tracer on every x bullets 
	bullet.Force	= 20									-- Amount of force to give to phys objects
	bullet.Damage	= damage
	bullet.AmmoType = "Pistol"
	bullet.Dir 		= self.Owner:GetAimVector() -- Vector( math.random(0, aimcone), math.random(0, aimcone) - self.VisualRecoil, 0 ) -- + Vector(0,self.VisualRecoil,0)			-- Dir of bullet
	bullet.Dir:Add(Vector(0,0,self.VisualRecoil/36))
	
	
	if self.VisualRecoil < 6 then
		self.VisualRecoil = self.VisualRecoil + self.Primary.VisualRecoil
	end
	if true then --remove this pls -yourself
		self.Owner:FireBullets( bullet )
	end
	
	self:ShootEffects()
	
end
function SWEP:AdjustMouseSensitivity()
	local fovdifference = 90 - self.Owner:GetFOV()
	if self.GetIronsights == true then
		return math.Clamp((1/fovdifference)*15,0,1)
		else return 1
	end
	
end