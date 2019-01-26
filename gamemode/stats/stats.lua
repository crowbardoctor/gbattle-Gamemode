local ply = FindMetaTable("Player")




function ply:dbCreate()
	self.db = {}
	self.db["Name"] = self:Nick()
	self.db["xp"] = 0
	self.db["kills"] = 0
	self.db["deaths"] = 0
	self.db["KD"] = 0
	file.CreateDir( "server/gbattle/player/" .. self.id .. "/" )
	self:dbWrite()
end

function ply:dbStart()
	self.id = tostring( self:SteamID() )
	self.id = string.Replace( self.id, "STEAM_0:0:", "" )
	self.id = string.Replace( self.id, "STEAM_0:1:", "" )
	

	local check = "server/gbattle/player/" .. self.id .. "/database.txt"
	if file.Exists( check, "Data" ) then
		self:dbRead()
	else 
		self:dbCreate()
		print( "checking in" .. check )
	end
	self:SetNWInt( "xp", self.db["xp"] )
	self:SetNWInt( "kills", self.db["kills"] )
	self:SetNWInt( "deaths", self.db["deaths"] )
	self:SetNWInt( "KD", self.db["KD"] )
end

function ply:dbWrite()
	local str = util.TableToKeyValues( self.db )
	file.Write( "server/gbattle/player/" .. self.id .. "/database.txt", str )
	print( "writing to" .. "server/gbattle/player/" .. self.id .. "/database.txt" )
end

function ply:dbRead()
	local str = file.Read( "server/gbattle/player/" .. self.id .. "/database.txt" )
	self.db = util.KeyValuesToTable( str )
end

function ply:dbFindKD()
	self.db["KD"] = self.db["kills"] / self.db["deaths"]
	print( "KD is " .. self.db["KD"] )
end