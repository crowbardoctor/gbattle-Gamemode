local DeathTable = {}
function	AddDeathNotification(victim, attacker)
	local CurrentDeath = attacker .. " killed " .. victim
	table.insert( DeathTable,1 , CurrentDeath)
end

function DeathNotificationDraw()
	
end