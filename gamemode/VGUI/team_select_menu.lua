
classprimaryweapons = {}
classprimaryweapons[1] = {"gbattle_weapm16","gbattle_weapak47","gbattle_weapscar"}
classprimaryweapons[2] = {"gbattle_weapl96", "gbattle_weapscout"}
classprimaryweapons[3] = {"gbattle_weapm16"}
classprimaryweapons[4] = {"gbattle_weapm16"}

classsecondaryweapons = {"gbattle_weapg18", "gbattle_weapusp"}
if CLIENT then
classselectedprimaryweapon = "gbattle_weapm16"
classselectedsecondaryweapon = "gbattle_weapg18"


function drawprimaryweaponbuttons()
	local ycreate = 1
	classselectedprimaryweapon = classprimaryweapons[class][1]
	if primaryheader then
		primaryheader:Remove()
		primaryheader = nil
		
	end
	if secondaryheader then
		secondaryheader:Remove()
		secondaryheader = nil
		
	end
	
	if primaryweaponbuttons then
		for i, k in pairs(primaryweaponbuttons) do 
			if k then
				k:Remove();
				k = nil;
				print("deleted")
				else break;
			end
		end
		primaryweaponbuttons = nil;
	end
	if secondaryweaponbuttons then
		for i, k in pairs(secondaryweaponbuttons) do 
			if k then
				k:Remove();
				k = nil;
				print("deleted")
				else break;
			end
		end
		secondaryweaponbuttons = nil;
	end
	primaryheader = Label("Primary:", classframe )
	primaryheader:SetPos( 150, 20 +(30 * ycreate) )
	primaryheader:SetVisible( true )
	ycreate = ycreate + 0.5
	
	
	primaryweaponbuttons = {}
	for index, weapon in pairs(classprimaryweapons[class]) do
		
		local b = primaryweaponbuttons[index]
		primaryweaponbuttons[index] = vgui.Create( "Button", classframe )
		primaryweaponbuttons[index]:SetSize( 120,20 )
		primaryweaponbuttons[index]:SetPos( 150, 20 +(30 * ycreate) )
		primaryweaponbuttons[index]:SetVisible( true )
		primaryweaponbuttons[index]:SetText( list.Get("Weapon")[weapon].PrintName )
		primaryweaponbuttons[index].SetWeapon = weapon
		local b = primaryweaponbuttons[index]
		function b:OnMousePressed( ply )
			classselectedprimaryweapon = primaryweaponbuttons[index].SetWeapon
			DModelPrimaryPanel:SetModel(weapons.Get(classselectedprimaryweapon).WorldModel)
			DModelPrimaryLabel:SetText("Primary Selected: " .. weapons.Get(classselectedprimaryweapon).PrintName)
			DModelPrimaryLabel:SizeToContents()
		end
		ycreate = ycreate + 1
	
	end
	
	secondaryheader = Label("Secondary:", classframe )
	secondaryheader:SetPos( 150, 20 +(30 * ycreate) )
	secondaryheader:SetVisible( true )
	ycreate = ycreate + 0.5
	
	secondaryweaponbuttons = {}
	for index, weapon in pairs(classsecondaryweapons) do
		
		local b = secondaryweaponbuttons[index]
		secondaryweaponbuttons[index] = vgui.Create( "Button", classframe )
		secondaryweaponbuttons[index]:SetSize( 120,20 )
		secondaryweaponbuttons[index]:SetPos( 150, 20 +(30 * ycreate) )
		secondaryweaponbuttons[index]:SetVisible( true )
		secondaryweaponbuttons[index]:SetText( list.Get("Weapon")[weapon].PrintName )
		secondaryweaponbuttons[index].SetWeapon = weapon
		local b = secondaryweaponbuttons[index]
		function b:OnMousePressed( ply )
			classselectedsecondaryweapon = secondaryweaponbuttons[index].SetWeapon
			DModelSecondaryPanel:SetModel(weapons.Get(classselectedsecondaryweapon).WorldModel)
			DModelSecondaryLabel:SetText("Secondary Selected: " .. weapons.Get(classselectedsecondaryweapon).PrintName)
			DModelSecondaryLabel:SizeToContents()
		end
		ycreate = ycreate + 1
	
	end
end

function teamselectmenu()

	classframe = vgui.Create( "DFrame" ) --the frame to house everything.
	classframe:SetPos( 5,5 )
	classframe:SetSize( 480, 300 )
	classframe:SetTitle( "Team Select" )
	classframe:SetVisible( true )
	classframe:SetDraggable( true )
	classframe:ShowCloseButton( true )
	classframe:MakePopup()
	-- class buttons
	local class1 = vgui.Create( "Button", classframe )
	class1:SetSize( 120,20 )
	class1:SetPos( 20, 50 )
	class1:SetVisible( true )
	class1:SetText( "Rifleman" )
	function class1:OnMousePressed( ply )
		class = 1
		drawprimaryweaponbuttons()
	end
	
	local class2 = vgui.Create( "Button", classframe )
	class2:SetSize( 120,20 )
	class2:SetPos( 20, 80 )
	class2:SetVisible( true )
	class2:SetText( "Scout Sniper" )
	function class2:OnMousePressed( ply )
		class = 2
		drawprimaryweaponbuttons()
	end
	
	local class3 = vgui.Create( "Button", classframe )
	class3:SetSize( 120,20 )
	class3:SetPos( 20, 110 )
	class3:SetVisible( true )
	class3:SetText( "Medic" )
	function class3:OnMousePressed( ply )
		class = 3
		drawprimaryweaponbuttons()
	end
	
	local class4 = vgui.Create( "Button", classframe )
	class4:SetSize( 120,20 )
	class4:SetPos( 20, 140 )
	class4:SetVisible( true )
	class4:SetText( "Rocket Soldier" )
	function class4:OnMousePressed( ply )
		class = 4
		drawprimaryweaponbuttons()
	end


	
	DModelPrimaryPanel = vgui.Create("DModelPanel", classframe)
	DModelPrimaryPanel:SetSize(150,150)
	DModelPrimaryPanel:SetPos(270, 10)
	DModelPrimaryPanel:SetModel(weapons.Get(classselectedprimaryweapon).WorldModel)
	function DModelPrimaryPanel:LayoutEntity( ent )
		DModelPrimaryPanel:SetLookAt(Vector(0,0,10))
		DModelPrimaryPanel:SetFOV(25)
	end
	DModelPrimaryLabel = Label("Primary Selected: " .. weapons.Get(classselectedprimaryweapon).PrintName, classframe )
	DModelPrimaryLabel:SetPos(270, 25)
	DModelPrimaryLabel:SizeToContents()
	
	
	DModelSecondaryPanel = vgui.Create("DModelPanel", classframe)
	DModelSecondaryPanel:SetSize(150,150)
	DModelSecondaryPanel:SetPos(270, 150)
	DModelSecondaryPanel:SetModel(weapons.Get(classselectedsecondaryweapon).WorldModel)
	function DModelSecondaryPanel:LayoutEntity( ent )
		DModelSecondaryPanel:SetLookAt(Vector(0,0,2))
		DModelSecondaryPanel:SetFOV(15)
	end
	DModelSecondaryLabel = Label("Secondary Selected: " .. weapons.Get(classselectedsecondaryweapon).PrintName, classframe )
	DModelSecondaryLabel:SetPos(270, 150 + 25)
	DModelSecondaryLabel:SizeToContents()
	
	local suicideticker = vgui.Create("DCheckBox", classframe) --A tick box to allow the player to kill themself
	suicideticker:SetPos(57, 255)
	local suicidelabel = Label( "Suicide:", classframe )
	suicidelabel:SetPos(20,252)
	--suicidelabel:SetSize(10,50)
	
	local finish = vgui.Create( "Button", classframe ) --A button to confirm loadout
	finish:SetSize(460,20)
	finish:SetPos(10, 275)
	finish:SetVisible( true )
	finish:SetText("OK")
	function finish:OnMousePressed( mouse )
		net.Start( "select_class", false )
		net.WriteBool( suicideticker:GetChecked() )
		net.WriteInt( class, 4 )
		net.WriteString( classselectedprimaryweapon )
		net.WriteString( classselectedsecondaryweapon )
		net.SendToServer()
		classframe:Remove()
		print( finish )
	end

end


net.Receive( "open_menu", function( len, ply ) 
	teamselectmenu()
end )




concommand.Add( "gb_setclass", teamselectmenu  )

elseif SERVER then

util.AddNetworkString( "open_menu" )
util.AddNetworkString( "select_class" )
util.AddNetworkString( "select_class2" )

function GM:PlayerInitialSpawn( ply )
end

function GM:PlayerSpawn( ply )

		

end

function GM:ShowHelp( ply )
	net.Start( "open_menu" )
	
	net.Send( ply )
end

net.Receive( "select_class",  function( len, ply ) 
	local ShouldISuicide = net.ReadBool()
	if ply:Alive() and ShouldISuicide then
		ply:Kill();
		else ply:ChatPrint("You will spawn with your new loadout.")
	end
	ply:SetNWInt("class", net.ReadInt( 4 ));
	ply.primaryweapon = net.ReadString();
	ply.secondaryweapon = net.ReadString();
	print( "kk it works here" );
end)

function GM:Initialize()
end

concommand.Add( "class1", setclass1 )

end