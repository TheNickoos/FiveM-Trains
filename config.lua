--=============================================================
-- Settings you CAN change and are meant to be changed, YAY :P
-- I do NOT use these on my server but have implemented it for
-- other users to make it more easy to adapt to their roleplay
-- server for example.
--=============================================================
Language 					= 'en'	-- Language used in the script
									-- Language available actually :
									-- en (English)
									-- fr (French)
									-- es (Spanish)

ShowTrainBlips			= true		-- If you want to show Train's Blips on the map
FreeWalk				= true		-- If you want people can walk around in the train, set true or false if you prefer they sit in the train (experimental)
PayWithBank 			= 25		-- Change this to 1 if you want users to pay with bank card (NOTE: Do implement your OWN banking system here please!)
UserBankIDi 			= 3			-- 1 = Maze, 2 = Bank Of Liberty, 3 = Fleeca  (This will show the corresponding message when the player doesn't have enoug money)
AllowEnterTrainWanted	= 1			-- Change to 1 if you want to allow players to ENTER the train when they have a wanted level
									-- The wanted level WILL NOT WORK if you desactivated it (With EssentialMode for example)
TicketPrice				= 25		-- Change to any value YOU think is suitable for a Metro Ticket in your (RP) Server
StationsExitScanRadius	= 15.0		-- I would RECOMMEND to leave it at 15 for best detection in trains, this variable sets the 'scan radius size' per station marker.
									-- NOTE: The StationsExitScanRadius HAS TO BE A FLOAT! (15.0 for example (which is the default!))

UseTwoMetros			= 1			-- KEEP IN MIND: When using two Metro's, players on one of the trams CAN be 'thrown out' when the trams pass eachother
									-- since the Metro's will PASS THROUGH EACH OTHER at some point! (this is inevitable! since the Metro track is just ONE TRACK!)
									-- it looks like they are two tracks in the game, but at both ends it will make a large 'u turn'!
									-- so if you do NOT want your players to be thrown out (and POSSIBLY killed) by a Metro, then set this value to 0!
									-- When set to 0, the script will only spawn ONE Metro Train instead of two (each in opposite direction)

ReportTerroristOnMetro	= true		-- When set to true the player will get an INSTANT wanted level of 4 when shooting on the Metro,
									-- this to 'contribute' to 'terroristic behavior' realism on (Real-Life) RP servers (where it's not normal either to
									-- just (randomly) shoot while on/in public transportation!) if you want to ENABLE shooting from the Metro (as passenger)
									-- then change this value to false

Debug					= true		-- Do you want some debug message ?


-- These are the locations of which 'the host' (well his/her script) will
-- pick a random location to spawn a new (Freight) train
TrainLocations = {
	{2533.0,2833.0,38.0},
	{2606.0,2927.0,40.0},
	{2463.0,3872.0,38.8},
	{1164.0,6433.0,32.0},
}

-- You don't need to modify below.
Message = {}
