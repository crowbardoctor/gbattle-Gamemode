local ply = FindMetaTable("Player")

util.AddNetworkString( "Leg_Health" )

function ply:ClassGear()
	self:StripWeapons()
	self:StripAmmo()
	self:Give(self.primaryweapon)
	self:Give(self.secondaryweapon)
	--Give us additional Gear for the class
	if Constant_ClassGear[self:GetNWInt("class")] then
	
		for j, k in pairs( Constant_ClassGear[self:GetNWInt("class")] ) do
			self:Give(k)
		end
	
	end

end

function ply:SetGamemodeTeam( n )

	if !team.Valid( n ) then return false end
	
	self:SetTeam( n )
	
	if n == 2
		then self:SetPlayerColor( Vector( 0,1,0 ) )
	elseif n == 1
		then self:SetPlayerColor( Vector( 0,0,1 ) )
	end
	
	return true
end

function ply:SetLegHealth( health )
	self:SetNWInt( "LegHealth", health )
	self.Leghealth = ply:GetNWInt( "LegHealth", 100 )
	if self.LegHealth < 0 then
		self:CrippledLegs()
	end
end




function ply:DealLegDamage( damage )
	self:SetNWInt( "LegHealth", self:GetNWInt("LegHealth", 100) - damage )
	self.LegHealth = self:GetNWInt( "LegHealth", 100 ) 
	if self.LegHealth < 0 then
		self:CrippledLegs()
	end
end

function ply:SendLegHealth()
	net.Start( "Leg_Health" )
	net.WriteInt( self.LegHealth, 9 )
	net.Send( self )
end

function ply:CrippledLegs()
	self:SetRunSpeed(150)
	self:SetWalkSpeed(50)
	print(self:Nick() .. " Has been Crippled")
end

function ply:TakeStrike( amount )
	self:SetNWInt( "Strikes", self:GetNWInt( "Strikes", 3 ) - amount)
	if( self:GetNWInt("Strikes") < 1 ) then
		self:Kick( "Lost all strikes." )
	end
end



ply.PressedKeysInitalTable = {}

function ply:KeyPressedInitial( key )
	local KeyJustPressed = false
	if self:KeyDown(key) then
		for v, k in pairs(ply.PressedKeysInitalTable) do
			if k == key then
				return false
			end
		end
		
		table.insert(ply.PressedKeysInitalTable, 1, key);
		return true;
	end
end
function ply:GetAllowWeaponsInVehicle()

	return true

end





