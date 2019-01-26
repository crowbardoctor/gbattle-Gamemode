AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
--models/props_vehicles/apc_tire001.mdl
include("shared.lua")

ENT.ShootSound = "Weapon_AWP.Single"
print("updated")
ENT.Throttle = 100
ENT.ForwardSpeed = 3000
ENT.Gear = {}
ENT.Gear[1] = 0.5
ENT.Gear[2] = 0.65
ENT.Gear[3] = 1.1
ENT.Gear[4] = 1.4
ENT.Gear[5] = 1250
ENT.Gear[6] = 1400
ENT.Gear[7] = 3000
ENT.Gear[8] = 3100
ENT.Gear[9] = 3150
ENT.Gear[10] = 3500

ENT.GearCeiling = {}
ENT.GearCeiling[1] = 1
ENT.GearCeiling[2] = 5
ENT.GearCeiling[3] = 8.5
ENT.GearCeiling[4] = 45
ENT.GearCeiling[5] = 67
ENT.GearCeiling[6] = 8000
ENT.GearCeiling[7] = 8000
ENT.GearCeiling[8] = 8000
ENT.GearCeiling[9] = 8000
ENT.GearCeiling[10] = 8000

ENT.GearFloor = {}
ENT.GearFloor[1] = 0.5
ENT.GearFloor[2] = 1.5
ENT.GearFloor[3] = 2.5
ENT.GearFloor[4] = 45
ENT.GearFloor[5] = 67
ENT.GearFloor[6] = 8000
ENT.GearFloor[7] = 8000
ENT.GearFloor[8] = 8000
ENT.GearFloor[9] = 8000
ENT.GearFloor[10] = 8000

ENT.WeaponRPM = 400

local VehicleWheelsPos = {}
	VehicleWheelsPos[1] = Vector(50,75,-50)
	VehicleWheelsPos[2] = Vector(50,-75,-50)
	VehicleWheelsPos[3] = Vector(-50,75,-50)
	VehicleWheelsPos[4] = Vector(-50,-75,-50)
	

function ENT:Initialize()
	self.NextDriveTime = CurTime()
	self.Revs = 1
	print("initialised")
	self.deletetime = CurTime() + 10
	self.NextThrottleTime = CurTime() + 1;
	self:SetModel("models/props_vehicles/apc001.mdl")
	self:SetPos(self:GetPos() + Vector(0,0,100))
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self.SteerAngle = 0
	
	self.VehicleWheels = {}
	
	
	
	
	self.VehicleSteerers = ents.Create("prop_physics")
	self.VehicleSteerers:SetModel( "models/props_phx/construct/metal_plate1.mdl" )
	self.VehicleSteerers:SetPos(self:GetPos())
	self.VehicleSteerers:PhysicsInit( SOLID_VPHYSICS )
	self.VehicleSteerers:SetMoveType( MOVETYPE_VPHYSICS )
	self.VehicleSteerers:SetSolid( SOLID_VPHYSICS )
	constraint.Elastic(self,self.VehicleSteerers,0,0,self.VehicleSteerers:GetPos()+Vector(0,200,0),Vector(0,100,0),5000000,100,0.1,nil,0,false) 
	print(self.VehicleSteerers:GetPhysicsObject():SetMass( 1000 ))
	for v, k in pairs( VehicleWheelsPos ) do
	
	self.VehicleWheels[v] = ents.Create( "prop_physics" )
	self.VehicleWheels[v]:SetModel("models/props_vehicles/apc_tire001.mdl")
	self.VehicleWheels[v]:SetPos(self:GetPos() + k)
	if v > 2 then
		self.VehicleWheels[v]:SetAngles(Angle(180,0,0))
		else self.VehicleWheels[v]:SetAngles(self:GetAngles())
	end

	self.VehicleWheels[v]:PhysicsInitSphere( 30 )
	--self.VehicleWheels[v]:PhysicsInitSphere( 50, "rubbertire" )
	self.VehicleWheels[v]:SetMoveType( MOVETYPE_VPHYSICS )
	self.VehicleWheels[v]:SetSolid( SOLID_VPHYSICS )
	self.VehicleWheels[v]:GetPhysicsObject():SetMaterial( "rubbertire")
	--self.VehicleWheels[v]:SetParent( self )
	if v == 2 or v == 4 then
		--constraint.Axis(self.VehicleWheels[v],self,0,0,Vector(0,0,0),Vector(0,0,0),0,0,1,1,Vector(1,0,0))
		else --constraint.Axis(self.VehicleSteerers[v],self,0,0,Vector(0,0,0),Vector(0,0,0),0,0,1,1,Vector(0,0,1))
		--constraint.(self.VehicleSteerers[v],self,0,0,0,true,0)
		--constraint.Axis(self.VehicleWheels[v],self.VehicleSteerers[v],0,0,Vector(0,0,0),Vector(0,0,0),0,0,1,1,Vector(1,0,0))
		constraint.NoCollide(self,self.VehicleWheels[v],0,0)
	end
	if !self.SteerWeld then
		--self.SteerWeld = constraint.Weld(self.VehicleSteerers[1],self.VehicleSteerers[3],0,0,0,true,false)
	end
	if v == 2 or v == 4 then
		constraint.AdvBallsocket(self.VehicleWheels[v],self,0,0,Vector(0,0,0),Vector(0,0,0),0,0,-180,-0.1,-0.1,180,0.1,0.1,0,0,0,1,1)
		constraint.Rope(self,self.VehicleWheels[v],0,0,Vector(0,-100,0),Vector(0,0,0),Vector(0,-100,0):Distance(VehicleWheelsPos[v]),0,0,0,0,true)
		constraint.Rope(self,self.VehicleWheels[v],0,0,Vector(0,50,0),Vector(0,0,0),Vector(0,50,0):Distance(VehicleWheelsPos[v]),0,0,0,0,true)
		constraint.Elastic(self,self.VehicleWheels[v],0,0,Vector(0,-75,100),Vector(0,0,0),5000000,100,0.1,"",0,false)
	--constraint.Rope(self,self.VehicleWheels[v],0,0, Vector(0,0,0),Vector(0,50,0),Vector(0,50,0):Distance(self.VehicleWheels[v]:GetPos()),0,0,0,"",true)
	else
		constraint.AdvBallsocket(self.VehicleWheels[v],self.VehicleSteerers,0,0,Vector(0,0,0),Vector(0,0,0),0,0,-180,-0.1,0.1,180,0.1,0.1,0,0,0,1,1)
		constraint.Rope(self,self.VehicleWheels[v],0,0,Vector(0,-50,0),Vector(0,0,0),Vector(0,-50,0):Distance(VehicleWheelsPos[v]),0,0,0,0,true)
		constraint.Rope(self,self.VehicleWheels[v],0,0,Vector(0,75,0),Vector(0,0,0),Vector(0,75,0):Distance(VehicleWheelsPos[v]),0,0,0,0,true)
		constraint.Elastic(self,self.VehicleWheels[v],0,0,Vector(0,75,100),Vector(0,0,0),5000000,100,0.1,0,0,false)
	end
	constraint.Rope(self,self.VehicleWheels[v],0,0,VehicleWheelsPos[v]+Vector(0,0,15),Vector(0,0,0),15,0,0,1,0,false)
	print("y pos" .. self:GetPos().y)
	print(self.VehicleWheels[v]:GetPhysicsObject():GetMass())
	self.VehicleWheels[v]:GetPhysicsObject():SetMass(2000)
	
	

	end
	constraint.Axis(self.VehicleSteerers,self,0,0,Vector(0,0,0),Vector(0,0,0),0,0,1,1,Vector(0,0,1))
	constraint.AdvBallsocket(self.VehicleSteerers,self,0,0,Vector(0,0,0),Vector(0,0,0),0,0,-0.1,-0.1,-35,0.1,0.1,35,0,0,0,1,1)
	
	
	self.ApcChair = ents.Create("prop_vehicle_prisoner_pod")
	self.ApcChair:SetModel("models/nova/airboat_seat.mdl")
	self.ApcChair:SetPos(self:GetPos() + Vector(0,-25,-10))
	self.ApcChair:SetAngles(Angle(0,0,0))
	self.ApcChair:PhysicsInit( SOLID_VPHYSICS )
	self.ApcChair:SetMoveType( MOVETYPE_VPHYSICS )
	self.ApcChair:SetSolid( SOLID_VPHYSICS )
	constraint.Weld(self,self.ApcChair,0,0,0,1,0)
	
	if self:GetPhysicsObject() then
		self:GetPhysicsObject():SetMass(2000)--self:GetPhysicsObject():GetMass()*15)
		--self:GetPhysicsObject():Wake()
	end
	self.postinitialized = false
	self.CurrentGear = 1
	self.PrevSteerAngle = 0
	--because its in the fucking ground
	
	/*self.TurretBody = ents.Create("prop_physics")
	self.TurretBody:SetModel("models/props_phx/construct/metal_dome360.mdl")
	self.TurretBody:SetPos(self:GetPos() + Vector(0,25,45))
	self.TurretBody:PhysicsInit( SOLID_VPHYSICS )
	self.TurretBody:SetMoveType( MOVETYPE_VPHYSICS )
	self.TurretBody:SetSolid( SOLID_VPHYSICS )
	self.TurretBody:GetPhysicsObject():SetMass(10)
	self.TurretBody:SetColor(Color(0,100,0))
	--constraint.Axis(self.TurretBody,self,0,0,Vector(0,0,0),Vector(0,0,0),0,0,1,1,Vector(0,0,1))*/
	
	self.TurretGun = ents.Create("prop_physics")
	self.TurretGun:SetModel("models/PHXtended/bar2x.mdl")
	self.TurretGun:SetPos(self:GetPos() + Vector(0,25,75))
	self.TurretGun:PhysicsInit( SOLID_VPHYSICS )
	self.TurretGun:SetMoveType( MOVETYPE_VPHYSICS )
	self.TurretGun:SetSolid( SOLID_VPHYSICS )
	self.TurretGun:GetPhysicsObject():SetMass(5)
	--constraint.NoCollide(self.TurretGun,self,0,0)
	constraint.Ballsocket(self,self.TurretGun,0,0,Vector(0,0,0),0,0,1)
	--constraint.Axis(self.TurretGun,self.TurretBody,0,0,Vector(0,0,0),Vector(0,0,0),0,0,1,1,Vector(1,0,0))
	--models/PHXtended/bar2x.mdl
	print("Next throttle time:" .. self.NextThrottleTime)
	self:SetNWInt("Health", 1000)
	constraint.NoCollide(self.ApcChair,self.VehicleSteerers,0,0)
end

function ENT:OnRemove()
	if self then
	for v, k in pairs( self.VehicleWheels ) do
		k:Remove()
	end
	self.ApcChair:Remove()
	self.VehicleSteerers:Remove()
	--self.TurretBody:Remove()
	self.TurretGun:Remove()
	end
end

function ENT:Use( activator, caller )
	self:GetUp()
    self:GetPhysicsObject():SetVelocity(caller:GetAimVector()*50)
	caller:EnterVehicle( self.ApcChair )

 
end

function ENT:apcDestroy()
	for v, k in pairs( self.VehicleWheels ) do
		k:Remove()
	end
	self.ApcChair:Remove()
	self.VehicleSteerers:Remove()
	--self.TurretBody:Remove()
	self.TurretGun:Remove()
end

function ENT:OnTakeDamage( damagetype )
	if damagetype:GetAttacker() == self.ApcChair:GetDriver() then return end
	self:SetNWInt("Health", self:GetNWInt("Health") - damagetype:GetDamage())
	if self:GetNWInt("Health") < 0 and damagetype:GetInflictor() != self then
		util.BlastDamage(self, damagetype:GetAttacker(),self:GetPos()+Vector(0,0,100),250,150)
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetScale(5)
		util.Effect("Explosion", effectdata)
		self:apcDestroy()
	end

end

function ENT:CanPrimaryAttack()
	if self.NextShootTime and self.NextShootTime > CurTime() then return false end
	return true
end

function ENT:PostIntialize()

	if !self.postinitialized then
		self:SetPos(self:GetPos() + Vector(0,0,100))
		self.postinitialized = true
		for v, k in pairs( VehicleWheelsPos ) do
			self.VehicleWheels[v]:SetPos(self:GetPos() + k)
		end
		self.NextThrottleTime = 1
		self.VehicleSteerers:SetPos(self:GetPos() + VehicleWheelsPos[1])
		hook.Remove( "PostIntializeHook" )
	end
	

end

function ENT:SwitchGear( Gear )
	if self.LastGear and self.LastGear == Gear then return end
	self.CurrentGear = Gear
	self.NextDriveTime = CurTime() + 1
	self.LastGear = self.CurrentGear
end

function ENT:ShootHERound(ply)
	if ply:IsValid() then return end
	
	local ShotTrace = util.TraceLine({start = self.TurretGun:GetPos(),
	endpos = self.TurretGun:GetPos() + ply:EyeAngles():GetRight()*10000,
	filter = {self,self.TurretGun}})
	print(ShotTrace.Entity)
	
	util.BlastDamage(self, ply,ShotTrace.HitPos,50,150)
	local effectdata = EffectData()
	effectdata:SetOrigin(ShotTrace.HitPos)
	effectdata:SetScale(5)
	util.Effect("Explosion", effectdata)
end

function ENT:DriveAtSpeed( ThrottleAmound )
	self.VehicleWheels[4]:GetPhysicsObject():ApplyForceOffset(ThrottleAmound*20*math.Clamp(5/self.DistanceTraveled,1,10),self.VehicleWheels[4]:GetPos()+self:GetAngles():Up()*10)
	self.VehicleWheels[2]:GetPhysicsObject():ApplyForceOffset(ThrottleAmound*20*math.Clamp(5/self.DistanceTraveled,1,10),self.VehicleWheels[2]:GetPos()+self:GetAngles():Up()*10)

end

function ENT:Decelerate()

	--self:GetPhysicsObject():SetVelocity(self:GetVelocity()*1)

end

function ENT:PhysicsUpdate()
	
end

function ENT:VehBrake()
	local brakeamount = 0.3
	
	if self.DistanceTraveled < 1 then
	
		brakeamount = 0.5
	
	end

	self.VehicleWheels[4]:GetPhysicsObject():AddAngleVelocity(-(self.VehicleWheels[4]:GetPhysicsObject():GetAngleVelocity()*brakeamount))
	self.VehicleWheels[2]:GetPhysicsObject():AddAngleVelocity(-(self.VehicleWheels[2]:GetPhysicsObject():GetAngleVelocity()*brakeamount))

end

function ENT:ThrottleFunction(driver)
	if self.NextThrottleTime and CurTime() > self.NextThrottleTime then
		
		local OnGroundTrace = util.TraceLine({start = self:GetPos(),
			endpos = self:GetPos() + self:GetAngles():Up()*-150,
			filter = {self, self.VehicleSteerers, self.ApcChair}})
			
		if self.Revs then
			print("Revs: " .. self.Revs)
		end
		
		local forwarddrivepos = self:GetAngles()
		forwarddrivepos:RotateAroundAxis(self:GetAngles():Forward(),1)
		

		print(self.NextDriveTime .. " " .. CurTime())
		
		if driver:KeyDown(IN_FORWARD) then
			if self.Revs < 500 then self.Revs = self.Revs + 10 end
			self.DriveDirection = -1
		elseif driver:KeyDown(IN_BACK) then
			if self.Revs < 500 then self.Revs = self.Revs + 10 end
			self.DriveDirection = 0.3
			else self.DriveDirection = 0
		end
		if forwarddrivepos and OnGroundTrace.Hit and self.Revs > 50   then
			self:DriveAtSpeed(forwarddrivepos:Right()*self.Revs*self.Gear[self.CurrentGear]*self.DriveDirection) 
			print(self.DriveDirection)
		end
		if self.Revs != nil then self.Revs = self.Revs * 0.99 else self.Revs = 1 end
		
		if driver:KeyDown(IN_JUMP) then
			self:VehBrake()
		end
		
		self.NextThrottleTime = CurTime() + 0
	end
end

function	ENT:DriveFunction( driver )

	if driver:KeyPressedInitial( IN_MOVELEFT) then
		self.SteerAngle = 25;
		elseif driver:KeyPressedInitial( IN_MOVERIGHT) then
		print("right")
		self.SteerAngle = -25;
		elseif !driver:KeyDown(IN_MOVELEFT) and !driver:KeyDown(IN_MOVERIGHT) then 
			self.SteerAngle = 0;
	end

	if self.SteerAngle != self.PrevSteerAngle then
		if self.SteerWeld then self.SteerWeld:Remove() end
		self.SteerWeld = nil
	end
	local AxleVector, AxleAngles = LocalToWorld(Vector(0,0,0),Angle(0,self.SteerAngle,0),self:GetPos(),self:GetAngles())
	self.VehicleSteerers:GetPhysicsObject():AddAngleVelocity(Vector(0,0,self.SteerAngle*15) - self.VehicleSteerers:GetPhysicsObject():GetAngleVelocity())
	--print(self.Throttle)
	self:ThrottleFunction(driver)
	
	
	print(AxleAngles)
	self.PrevSteerAngle = self.SteerAngle
  
		
	if self.DistanceTraveled then
		print("Gear: " .. self.CurrentGear)
		for i = 1, 10, 1 do
			
			if self.GearCeiling[self.CurrentGear] and self.DistanceTraveled > self.GearCeiling[self.CurrentGear] then 
				
				self:SwitchGear(i);
				break;
			end
			
		end
		for i = 1, 10, 1 do
			
			if self.GearFloor[self.CurrentGear] and self.DistanceTraveled < self.GearCeiling[i] - 2 then
				
				self:SwitchGear(i);
				break;
			end
			
		end
		
	end

	--self.TurretBody:SetAngles(Angle(0,driver:EyeAngles().y-90,0))
	self.TurretGun:SetAngles(driver:EyeAngles() - Angle(90,0,90))--Angle(driver:EyeAngles().x-0,driver:EyeAngles().y-90,0))

	if driver:KeyDown(IN_ATTACK) and self:CanPrimaryAttack() then
		self:EmitSound(self.ShootSound)
		local BulletTab = {}
		BulletTab.Attacker = driver
		BulletTab.Damage = 10
		BulletTab.Force = 100
		BulletTab.Dir = driver:GetAimVector() 
		BulletTab.Src = driver:GetPos() + driver:GetViewOffset() + Vector(0,0,10)
		self.TurretGun:FireBullets(BulletTab)
		self.NextShootTime = CurTime() + 1/self.WeaponRPM*60
		
	end
	driver:SetViewOffset(((self.ApcChair:GetPos() - self.TurretGun:GetPos())*-1) + self.TurretGun:GetForward()*5 + self.TurretGun:GetRight()*-5 + self.TurretGun:GetUp()*-5)
	
end

/*local BulletTab = {}
		BulletTab.Attacker = driver
		BulletTab.Damage = 1000
		BulletTab.Force = 100
		BulletTab.Dir = driver:GetAimVector() 
		BulletTab.Src = driver:GetPos() + driver:GetViewOffset() + Vector(0,0,10)
		self.TurretGun:FireBullets(BulletTab)*/

function ENT:Think()


	self:PostIntialize()
	if self.ApcChair:GetDriver():IsPlayer() then
		
		self:DriveFunction( self.ApcChair:GetDriver() )
	end
	if self.LastPos then
		self.DistanceTraveled = self:GetPos():Distance(self.LastPos);
		print("Speed: " .. self.DistanceTraveled )
	end
	self.LastPos = self:GetPos()

	self:NextThink( CurTime() )
	return true
end


