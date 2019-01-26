

net.Receive( "end_game", function( len, ply) 
	local winnerteam = net.ReadInt(3)
	timer.Create("win_timer", 1, 1, function()
		
		endgame( winnerteam )
		timer.Destroy("win_timer")

	end)
	
	
end)

function endgame( winnerteam )
	
	EndTime = CurTime()
	local Panel = vgui.Create( "DFrame" )
	Panel:MakePopup()
	Panel:SetSize( 640, 480 )
	Panel:ShowCloseButton( true	)
	Panel:SetTitle( "" )
	Panel:SetVisible( true )
	Panel:Center()
	Panel:SetDraggable( false )
	
	local WinStatusText = vgui.Create( "DLabel", Panel )
	if LocalPlayer():Team() == winnerteam then
		WinStatusText:SetColor(Color(0,155,0))
		WinStatusText:SetText("Victory!")
		else WinStatusText:SetColor(Color(155,0 ,0))
		WinStatusText:SetText("Failure!")
	end
	WinStatusText:SetFont("Title")
	WinStatusText:SizeToContents()
	WinStatusText:SetPos(0,10)
	WinStatusText:CenterHorizontal()
	
	local TeamScore1 = vgui.Create( "DLabel", Panel )
	TeamScore1:SetText(" " .. team.GetScore(1).. ": Team1")
	TeamScore1:SetFont("Score")
	TeamScore1:SetPos(0,150)
	TeamScore1:SizeToContents()
	local TeamScore2 = vgui.Create( "DLabel", Panel )
	TeamScore2:SetText("Team2 :" .. team.GetScore(2) .. " ")
	TeamScore2:SetFont("Score")
	TeamScore2:SetPos(600,150)
	TeamScore2:SizeToContents()
	TeamScore2:AlignRight()
	
	local Team1NamesList = vgui.Create(  "DListView" , Panel )
	Team1NamesList:SetPos(0,200)
	Team1NamesList:SetSize( 320, 250 )
	Team1NamesList:AddColumn( "Name" )
	Team1NamesList:AddColumn( "Score" )
	Team1NamesList:AddColumn( "Deaths" )
	for v, k in pairs(team.GetPlayers(1)) do
	
		Team1NamesList:AddLine( k:Nick(), k:Frags(), k:Deaths() )
	
	end
	
	local Team2NamesList = vgui.Create(  "DListView" , Panel )
	Team2NamesList:SetPos(0,200)
	Team2NamesList:SetSize( 320, 250 )
	Team2NamesList:AddColumn( "Name" )
	Team2NamesList:AddColumn( "Score" )
	Team2NamesList:AddColumn( "Deaths" )
	for v, k in pairs(team.GetPlayers(2)) do
	
		Team2NamesList:AddLine( k:Nick(), k:Frags(), k:Deaths() )
	
	end
	Team2NamesList:AlignRight()
		
end


