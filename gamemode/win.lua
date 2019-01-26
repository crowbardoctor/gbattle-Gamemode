util.AddNetworkString( "end_game" )


function CheckScore()
	local maxscore = GetConVarNumber( "gb_maxscore" )
	local teamscore1 = tonumber(team.GetScore( 1 ))
	local teamscore2 = tonumber(team.GetScore( 2 ))
	if teamscore1 >= maxscore and MatchStatus == 1 then
		gamefinish(	1 )
	end
	
	if teamscore2 >= maxscore and MatchStatus == 1  then
		gamefinish(	2 )
	end
end

function gamefinish( winnerteam )
	MatchStatus = 0
	print(  "Team: " .. winnerteam .. " has won" )
	for k, v in pairs( player.GetAll() ) do
		v:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0, 250 ), 1, GameFinishDownTime - 1 )
		v:KillSilent()
		print( v )
	end
	net.Start( "end_game" )
		net.WriteInt(winnerteam,3)
	net.Broadcast()
	timer.Create("GameRestart_Timer", GameFinishDownTime, 1, function()
		GameRestart()
		timer.Destroy("GameRestart_Timer")
	end)
end

function GameRestart()
	team.SetScore( 1, 0 )
	team.SetScore( 2, 0 )
	MatchStatus = 1

end