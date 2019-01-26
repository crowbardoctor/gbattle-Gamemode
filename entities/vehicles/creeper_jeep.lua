
-- Don't try to edit this file if you're trying to add new vehicles
-- Just make a new file and copy the format below.

local Category = "Half-Life 2"

local function HandleRollercoasterAnimation( vehicle, player )
	return player:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) 
end

local V = { 	
	-- Required information
	Name = "Creeper", 
	Class = "prop_vehicle_jeep_old",
	Category = Category,

	-- Optional information
	Author = "VALVe",
	Information = "The regular old jeep",
	Model = "models/buggy.mdl",

	KeyValues = {
		vehiclescript = "content/scripts/vehicles/creeper.txt"
	}
}
list.Set( "Gbattle", "Creeper", V )



-- Not adding this, because exit animation leaves you stuck in the middle
-- list.Set( "Vehicles", "phx_train", V )
