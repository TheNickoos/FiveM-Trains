--===================================================
-- Variables used BY the script, do NOT modify them
-- unless you know what you are doing!
-- Modifying these might/will result in undesired
-- behaviour and/or script breaking!
--===================================================
local IsPlayerNearMetro = false
local IsPlayerInMetro = false
local PlayerHasMetroTicket = false
local IsPlayerUsingTicketMachine = false
local ShowingExitMetroMessage = false
local EverythingisK = false
local Train = nil
local MetroTrain = nil
local MetroTrain2 = nil
local Driver1 = nil
local Driver2 = nil
local Driver3 = nil
local MetroTrainStopped = {}

--===================================================
-- These are radius locations (multiple per station)
-- to detect if the player can exit the Metro
--===================================================
local XNLMetroScanPoints = {
	{XNLStationid=0, x=230.82389831543, y=-1204.0643310547, z=38.902523040771},
	{XNLStationid=0, x=249.59216308594, y=-1204.7095947266, z=38.92488861084},
	{XNLStationid=0, x=270.33166503906, y=-1204.5366210938, z=38.902912139893},
	{XNLStationid=0, x=285.96697998047, y=-1204.2261962891, z=38.929733276367},
	{XNLStationid=0, x=304.13528442383, y=-1204.3720703125, z=38.892612457275},
	{XNLStationid=1, x=-294.53421020508, y=-353.38571166992, z=10.063089370728},
	{XNLStationid=1, x=-294.96997070313, y=-335.69766235352, z=10.06309223175},
	{XNLStationid=1, x=-294.66772460938, y=-318.29565429688, z=10.063152313232},
	{XNLStationid=1, x=-294.73403930664, y=-303.77200317383, z=10.063160896301},
	{XNLStationid=1, x=-294.84133911133, y=-296.04568481445, z=10.063159942627},
	{XNLStationid=2, x=-795.28063964844, y=-126.3436050415, z=19.950298309326},
	{XNLStationid=2, x=-811.87170410156, y=-136.16409301758, z=19.950319290161},
	{XNLStationid=2, x=-819.25689697266, y=-140.25764465332, z=19.95037651062},
	{XNLStationid=2, x=-826.06652832031, y=-143.90898132324, z=19.95037651062},
	{XNLStationid=2, x=-839.2587890625, y=-151.32421875, z=19.950378417969},
	{XNLStationid=2, x=-844.77874755859, y=-154.31440734863, z=19.950380325317},
	{XNLStationid=3, x=-1366.642578125, y=-440.04803466797, z=15.045327186584},
	{XNLStationid=3, x=-1361.4998779297, y=-446.50497436523, z=15.045324325562},
	{XNLStationid=3, x=-1357.4061279297, y=-453.40963745117, z=15.045320510864},
	{XNLStationid=3, x=-1353.4593505859, y=-461.88238525391, z=15.045323371887},
	{XNLStationid=3, x=-1346.1264648438, y=-474.15142822266, z=15.045383453369},
	{XNLStationid=3, x=-1338.1717529297, y=-488.97756958008, z=15.045383453369},
	{XNLStationid=3, x=-1335.0261230469, y=-493.50796508789, z=15.045380592346},
	{XNLStationid=4, x=-530.67529296875, y=-673.33935546875, z=11.808959960938},
	{XNLStationid=4, x=-517.35559082031, y=-672.76635742188, z=11.808965682983},
	{XNLStationid=4, x=-499.44836425781, y=-673.37664794922, z=11.808973312378},
	{XNLStationid=4, x=-483.1321105957, y=-672.68438720703, z=11.809024810791},
	{XNLStationid=4, x=-468.05545043945, y=-672.74371337891, z=11.80902671814},
	{XNLStationid=5, x=-206.90379333496, y=-1014.9454345703, z=30.138082504272},
	{XNLStationid=5, x=-212.65534973145, y=-1031.6101074219, z=30.208702087402},
	{XNLStationid=5, x=-212.65534973145, y=-1031.6101074219, z=30.208702087402},
	{XNLStationid=5, x=-217.0216217041, y=-1042.4768066406, z=30.573789596558},
	{XNLStationid=5, x=-221.29409790039, y=-1054.5914306641, z=30.13950920105},
	{XNLStationid=6, x=101.89681243896, y=-1714.7589111328, z=30.112174987793},
	{XNLStationid=6, x=113.05246734619, y=-1724.7247314453, z=30.111650466919},
	{XNLStationid=6, x=122.72943878174, y=-1731.7276611328, z=30.54141998291},
	{XNLStationid=6, x=132.55198669434, y=-1739.7276611328, z=30.109527587891},
	{XNLStationid=7, x=-532.24133300781, y=-1263.6896972656, z=26.901586532593},
	{XNLStationid=7, x=-539.62115478516, y=-1280.5207519531, z=26.908163070679},
	{XNLStationid=7, x=-545.18548583984, y=-1290.9525146484, z=26.901586532593},
	{XNLStationid=7, x=-549.92230224609, y=-1302.8682861328, z=26.901605606079},
	{XNLStationid=8, x=-872.75714111328, y=-2289.3198242188, z=-11.732793807983},
	{XNLStationid=8, x=-875.53247070313, y=-2297.67578125, z=-11.732793807983},
	{XNLStationid=8, x=-880.05035400391, y=-2309.1235351563, z=-11.732788085938},
	{XNLStationid=8, x=-883.25482177734, y=-2321.3303222656, z=-11.732738494873},
	{XNLStationid=8, x=-890.087890625, y=-2336.2553710938, z=-11.732738494873},
	{XNLStationid=8, x=-894.92395019531, y=-2350.4128417969, z=-11.732727050781},
	{XNLStationid=9, x=-1062.7882080078, y=-2690.7492675781, z=-7.4116077423096},
	{XNLStationid=9, x=-1071.6839599609, y=-2701.8503417969, z=-7.410071849823},
	{XNLStationid=9, x=-1079.0869140625, y=-2710.7033691406, z=-7.4100732803345},
	{XNLStationid=9, x=-1086.8758544922, y=-2720.0673828125, z=-7.4101362228394},
	{XNLStationid=9, x=-1095.3796386719, y=-2729.8442382813, z=-7.4101347923279},
	{XNLStationid=9, x=-1103.7401123047, y=-2740.369140625, z=-7.4101300239563}
}

-- These are the 'exit points' to where the player is teleported with the short fade-out / fade-in
-- NOTE: XNLStationid is NOT used in this table, it's just here for user refrence!
local XNLMetroEXITPoints = {
	{XNLStationid=0, x=294.46011352539, y=-1203.5991210938, z=38.902496337891, h=90.168075561523},
	{XNLStationid=1, x=-294.76913452148, y=-303.44619750977, z=10.063159942627, h=185.19216918945},
	{XNLStationid=2, x=-839.20843505859, y=-151.43312072754, z=19.950380325317, h=298.70877075195},
	{XNLStationid=3, x=-1337.9787597656, y=-488.36145019531, z=15.045375823975, h=28.487064361572},
	{XNLStationid=4, x=-474.07037353516, y=-673.10729980469, z=11.809032440186, h=81.799621582031},
	{XNLStationid=5, x=-222.13038635254, y=-1054.5043945313, z=30.139930725098, h=155.81954956055},
	{XNLStationid=6, x=133.13328552246, y=-1739.5617675781, z=30.109495162964, h=231.40335083008},
	{XNLStationid=7, x=-550.79998779297, y=-1302.4467773438, z=26.901605606079, h=155.53070068359},
	{XNLStationid=8, x=-891.87664794922, y=-2342.6486816406, z=-11.732737541199, h=353.59387207031},
	{XNLStationid=9, x=-1099.6376953125, y=-2734.8957519531, z=-7.410129070282, h=314.91424560547}
}

-- This is all our "Stop" station for the metro.
local MetroTrainstops = {
	-- Los Santos AirPort (airport front door entrance)
	{x=-1088.627, y=-2709.362, z=-7.137033},
	{x=-1081.309, y=-2725.259, z=-7.137033},

	-- Los Santos AirPort (car park/highway entrance)
	{x=-889.2755, y=-2311.825, z=-11.45941},
	{x=-876.7512, y=-2323.808, z=-11.45609},
	
	-- Little Seoul (near los santos harbor)
	{x=-545.3138, y=-1280.548, z=27.09238},
	{x=-536.8082, y=-1286.096, z=27.08238},
	
	-- Strawberry (near strip club)
	{x=270.2029, y=-1210.818, z=39.25398},
	{x=265.3616, y=-1198.051, z=39.23406},
	
	-- Rockford Hills (San Vitus Blvd)
	{x=-286.3837, y=-318.877, z=10.33625},
	{x=-302.6719, y=-322.995, z=10.33629},
	
	-- Rockford Hills (Near golf club)
	{x=-826.3845, y=-134.7151, z=20.22362},
	{x=-816.7159, y=-147.4567, z=20.2231},

	-- Del Perro (Near beach)
	{x=-1351.282, y=-481.2916, z=15.318},
	{x=-1341.085, y=-467.674, z=15.31838},
	
	-- Little Seoul
	{x=-496.0209, y=-681.0325, z=12.08264},
	{x=-495.8456, y=-665.4668, z=12.08244},

	-- Pillbox Hill (Downtown)
	{x=-218.2868, y=-1031.54, z=30.51112},
	{x=-209.6845, y=-1037.544, z=30.50939},

	-- Davis (Gang / hood area)
	{x=112.3714, y=-1729.233, z=30.24097},
	{x=120.0308, y=-1723.956, z=30.31433},
}

local TicketMachines = {'prop_train_ticket_02', 'prop_train_ticket_02_tu', 'v_serv_tu_statio3_'}
local anim = "mini@atmenter"

Citizen.CreateThread(function()
	function LoadTrainModels() -- f*ck your rails, too!
		tempmodel = GetHashKey("freight")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freightcar")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freightgrain")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freightcont1")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freightcont2")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freighttrailer")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("tankercar")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("metrotrain")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("s_m_m_lsmetro_01")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end
		if Debug then
			if Debug then print("FiveM-Trains: Train Models Loaded" ) end
		end
	end

	LoadTrainModels()

	RegisterNetEvent("StartTrain")
	function StartTrain()
		randomSpawn = math.random(#TrainLocations)
		x,y,z = TrainLocations[randomSpawn][1], TrainLocations[randomSpawn][2], TrainLocations[randomSpawn][3] -- get some random locations for our spawn


		-- For those whom are interested: The yesorno variable determines the direction of the train ;)
		yesorno = math.random(0,100)
		if yesorno >= 50 then -- untested, but seems to work /shrug
			yesorno = true
		elseif yesorno < 50 then
			yesorno = false
		end

		Wait(100)
		Train = CreateMissionTrain(math.random(0,22), x,y,z,yesorno)
		if Debug then print("FiveM-Trains: Train 1 created (Freight)." ) end
		while not DoesEntityExist(Train) do
			Wait(800)
			if Debug then print("FiveM-Trains: Waiting for Freight to be created" ) end
		end
		
		if ShowTrainBlips then
			local TrainBlip = AddBlipForEntity(Train)      
			SetBlipSprite (TrainBlip, 660)
			SetBlipDisplay(TrainBlip, 4)
			SetBlipScale  (TrainBlip, 0.8)
			SetBlipColour (TrainBlip, 2)
			SetBlipAsShortRange(TrainBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Train")
			EndTextCommandSetBlipName(TrainBlip)
		end
		
		SetTrainCruiseSpeed(Train, 20.0)
		Wait(200) -- Added a small 'waiting' while the train is loaded (to prevent the)
				  -- random unexplained spawning of the freight train on the Metro Rails

		MetroTrain = CreateMissionTrain(24,40.2,-1201.3,31.0,true) -- these ones have pre-defined spawns since they are a pain to set up
		if Debug then print("FiveM-Trains: Train 2 created (Metro)." ) end
		while not DoesEntityExist(MetroTrain) do
			Wait(800)
			if Debug then print("FiveM-Trains: Waiting for Metro Train 1 to be created" ) end -- Also wait until the train entity has actually been created
		end
		
		if ShowTrainBlips then
			local MetroBlip = AddBlipForEntity(MetroTrain)      
			SetBlipSprite (MetroBlip, 660)
			SetBlipDisplay(MetroBlip, 4)
			SetBlipScale  (MetroBlip, 0.8)
			SetBlipColour (MetroBlip, 2)
			SetBlipAsShortRange(MetroBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Metro")
			EndTextCommandSetBlipName(MetroBlip)
		end
		
		SetTrainCruiseSpeed(MetroTrain, 15.0)
		Wait(200) -- Added a small 'waiting' while the train is loaded (to prevent the)
				  -- random unexplained spawning of the freight train on the Metro Rails

		if UseTwoMetros == 1 then
			MetroTrain2 = CreateMissionTrain(24,-618.0,-1476.8,16.2,true)
			if Debug then print("FiveM-Trains: Train 3 created (Metro #2)." ) end
			while not DoesEntityExist(MetroTrain2) do
				Wait(800)
				if Debug then  print("FiveM-Trains: Waiting for Metro Train 2 to be created" ) end -- Also wait until the train entity has actually been created
			end
			if ShowTrainBlips then
				local Metro2Blip = AddBlipForEntity(MetroTrain2)      
				SetBlipSprite (Metro2Blip, 660)
				SetBlipDisplay(Metro2Blip, 4)
				SetBlipScale  (Metro2Blip, 0.8)
				SetBlipColour (Metro2Blip, 2)
				SetBlipAsShortRange(Metro2Blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Metro")
				EndTextCommandSetBlipName(Metro2Blip)
			end
			
			SetTrainCruiseSpeed(MetroTrain2, 15.0)
		end
		Wait(200) -- Added a small 'waiting' while the train is loaded (to prevent the)
				  -- random unexplained spawning of the freight train on the Metro Rails

		TrainDriverHash = GetHashKey("s_m_m_lsmetro_01")

		-- By making a refrence to the drivers we can call them further on to make them invincible for example.
		Driver1 = CreatePedInsideVehicle(Train, 26, TrainDriverHash, -1, 1, true)
		Driver2 = CreatePedInsideVehicle(MetroTrain, 26, TrainDriverHash, -1, 1, true)

		if UseTwoMetros == 1 then
			Driver3 = CreatePedInsideVehicle(MetroTrain2, 26, TrainDriverHash, -1, 1, true) -- create peds for the trains
		end

		--=========================================================
		-- XNL 'Addition': This SHOULD prevent the train driver(s)
		-- from getting shot or fleeing out of the train/tram when
		-- being targeted by the player.
		-- We have had several instances where the tram driver just
		-- teleported out of the tram to attack the player when it
		-- it was targeted (even without holding a weapon).
		-- I suspect that this behaviour is default in the game
		-- unless you override it.
		--=========================================================
		SetBlockingOfNonTemporaryEvents(driver1, true)
		SetPedFleeAttributes(driver1, 0, 0)
		SetEntityInvincible(driver1, true)
		SetEntityAsMissionEntity(Driver1, true)


		SetBlockingOfNonTemporaryEvents(Driver3, true)
		SetPedFleeAttributes(Driver3, 0, 0)
		SetEntityInvincible(Driver3, true)
		SetEntityAsMissionEntity(Driver3, true)

		SetEntityAsMissionEntity(Train,true,true) -- dunno if this does anything, just throwing it in for good measure
		SetEntityAsMissionEntity(MetroTrain,true,true)

		SetEntityInvincible(Train, true)
		SetEntityInvincible(MetroTrain, true)

		if UseTwoMetros == 1 then
			SetBlockingOfNonTemporaryEvents(Driver2, true)
			SetPedFleeAttributes(Driver2, 0, 0)
			SetEntityInvincible(Driver2, true)
			SetEntityAsMissionEntity(Driver2, true)
			SetEntityAsMissionEntity(MetroTrain2,true,true)
			SetEntityInvincible(MetroTrain2, true)
		end

		-- Cleanup from memory
		SetModelAsNoLongerNeeded(TrainDriverHash)

		if Debug then print("FiveM-Trains: Train System Started, you are currently 'host' for the trains." ) end
	end

	AddEventHandler("StartTrain", StartTrain)
	EverythingisK = true -- Added this because the Event isn't fully registered when the Event PlayerSpawned trigger.
end)

Citizen.CreateThread(function()
	ShowedBuyTicketHelper = false
	ShowedLeaveMetroHelper = false
	while true do
		Wait(10)

		if IsPlayerNearTicketMachine then
			if not IsPlayerUsingTicketMachine  then
				if not ShowedBuyTicketHelper then
					DisplayHelpText(Message[Language]['buyticket'].." ($" .. TicketPrice .. ")")
					ShowedBuyTicketHelper = true
				end
			else
				ClearAllHelpMessages()
				DisableControlAction(0, 201, true)
				DisableControlAction(1, 201, true)
			end

			if IsControlJustPressed(0, 51) and PlayerHasMetroTicket then
				SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['already_got_ticket'], true)
				Wait(3500) -- To avoid people 'spamming themselves' with the message popup (3500ms is 'just enough' to take the fun out of it :P)
			end

			if IsControlJustPressed(0, 51) and not PlayerHasMetroTicket then
				IsPlayerUsingTicketMachine = true
				RequestAnimDict("mini@atmbase")
				RequestAnimDict(anim)
				while not HasAnimDictLoaded(anim) do
					Wait(1)
				end

				SetCurrentPedWeapon(playerPed, GetHashKey("weapon_unarmed"), true)
				TaskLookAtEntity(playerPed, currentTicketMachine, 2000, 2048, 2)
				Wait(500)
				TaskGoStraightToCoord(playerPed, TicketMX, TicketMY, TicketMZ, 0.1, 4000, GetEntityHeading(currentTicketMachine), 0.5)
				Wait(2000)
				TaskPlayAnim(playerPed, anim, "enter", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
				RemoveAnimDict(animDict)
				Wait(4000)
				TaskPlayAnim(playerPed, "mini@atmbase", "base", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
				RemoveAnimDict("mini@atmbase")
				Wait(500)
				PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

				RequestAnimDict("mini@atmexit")
				while not HasAnimDictLoaded("mini@atmexit") do
					Wait(1)
				end
				TaskPlayAnim(playerPed, "mini@atmexit", "exit", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
				RemoveAnimDict("mini@atmexit")
				Wait(500)

				--=====================================================================================
				-- Put here the actual 'reader'/function that your server uses
				-- to calculate/get the players bank account saldo and cash money!
				-- Now they are just set 'hardcoded' to an high amount to make the
				-- script work for people whom don't read a single line of code
				-- and then instantly post "Hey, i can't even buy a ticket, the script is broken" :P
				--
				-- Nope it's NOT broken, it just needs a BIT of adapting to your server and it's
				-- money handling. Since we use a custom banking system we have much different calls
				-- than others might have so i've decided to put it in here like this so that it
				-- functions for everyone when they want to test/try the script :)
				--=====================================================================================
				BankAmount = 10000    --StatGetInt("BANK_BALANCE",-1)
				PlayerCashAm = 10000  --StatGetInt("MP0_WALLET_BALANCE",-1)

				if PayWithBank == 1 then
					XNLUserMoney = BankAmount
				else
					XNLUserMoney = PlayerCashAm
				end

				--===================================================================
				-- Please note, that despite if you make your players pay with
				-- cash or by bank, it will always show the selected bank popup
				-- if the player doesn't have enough cash (this is NOT a bug!)
				-- if you want/need it differently you can adapt the code bellow ;)
				--==================================================================
				if XNLUserMoney < TicketPrice then
					if UserBankIDi == 1 then		  		-- Maze Bank
						BankIcon = "CHAR_BANK_MAZE"
						BankName = "Maze Bank"
					end
					if UserBankIDi == 2 then				-- Bank Of Liberty
						BankIcon = "CHAR_BANK_BOL"
						BankName = "Bank Of Liberty"
					end

					if UserBankIDi == 3 then		  		-- Fleeca (Default Fallback to!)
						BankIcon = "CHAR_BANK_FLEECA"
						BankName = "Fleeca Bank"
					end
					SMS_Message(BankIcon, BankName, Message[Language]['account_information'], Message[Language]['account_nomoney'], true)
				else
					if PayWithBank == 1 then
						-- Put YOUR code to deduct the amount from the players BANK account here
						-- 'Basic Example':  PlayerBankMoney = PlayerBankMoney - TicketPrice
					else
						-- Put YOUR code to deduct the amount from the players CASH money account here
						-- 'Basic Example':  PlayerCash = PlayerCash - TicketPrice
					end

					SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['ticket_purchased'], true)
					PlayerHasMetroTicket = true
				end

				IsPlayerUsingTicketMachine = false
			end
		else
			ShowedBuyTicketHelper = false
		end



		-- E/Action key (There will only be checked for trains when the player presses the action key)
		-- This Section is used to ENTER the Metro
		if IsControlJustPressed(0, 51) then
			playerPed = PlayerPedId()
			x,y,z = table.unpack(GetEntityCoords(playerPed, true))
			IsPlayerInVehicle = IsPedInAnyVehicle(playerPed, true)
			SkipReEnterCheck = false

			if IsPlayerInMetro then
				if XNLCanPlayerExitTrain() then
					if not XNLTeleportPlayerToNearestMetroExit() then
						SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['stop_toolate'], true)
					end
					SkipReEnterCheck = true -- This variable is used to prevent the character from directly trying to re-enter the Metro after leaving it.
				else
					XNLGenMess = "Sir"
					if XNLIsPedFemale(playerPed) then
						XNLGenMess = "Miss"
					end
					SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['sorry'].." "..Message[Language][XNLGenMess].." "..Message[Language]['exit_metro_random'], true)
				end
			end

			--===============================================
			-- Make sure the player is NOT in a vehicle and
			-- NOT already on the Metro
			--===============================================
			if not IsPlayerNearMetro and not IsPlayerInMetro and not SkipReEnterCheck then
				if not IsPlayerInVehicle then
					local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
					local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
					local Metro = getVehicleInDirection(coordA, coordB)
					if DoesEntityExist(Metro) then
						if GetEntityModel(Metro) == GetHashKey("metrotrain") then
							if not PlayerHasMetroTicket	then
									--==========================================================================
									-- Notify the player he/she needs to buy a ticket before entering the metro
									--==========================================================================
									SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['need_ticket'], true)
							else
								if IsPlayerWantedLevelGreater(PlayerId(), 0) and AllowEnterTrainWanted == 0 then
									--==========================================================================
									-- If the player's wanted level is greater than 0, he/she will be
									-- denied to ENTER the Metro.
									-- If he/she GETS WHILE wanted on the train, we will handle that furher on
									--==========================================================================
									SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['have_wantedlevel'], true)
								else
									CurrentMetro = Metro
									IsPlayerNearMetro = true
									if FreeWalk then
										MetroX, MetroY, MetroZ = table.unpack(GetOffsetFromEntityInWorldCoords(CurrentMetro, 0.0, 0.0, 0.0))
										SetEntityCoordsNoOffset(PlayerPedId(), MetroX, MetroY, MetroZ + 2.0)
									else							
										SetPedIntoVehicle(GetPlayerPed(-1), CurrentMetro, 1)
									end
									IsPlayerInMetro = true
									PlayerHasMetroTicket = false
									SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['entered_metro'], true)
								end
							end
						else
							IsPlayerNearMetro = false
						end
					else
						IsPlayerNearMetro = false
					end
				else
					if not DoesEntityExist(CurrentMetro) then
						IsPlayerNearMetro = false
					else
						if GetDistanceBetweenCoords(x,y,z, MetroX, MetroY, MetroZ, true) > 3.5 then
							IsPlayerNearMetro = false
						end
					end
				end
			end
		end


		--=============================================================
		-- Check if the player is in the Metro AND pressed the [E] key
		--=============================================================
		if IsPlayerInMetro then
			if ReportTerroristOnMetro == true then
				if GetPlayerWantedLevel(PlayerId()) < 4 then
					if IsPedShooting(GetPlayerPed(-1)) then
						SetPlayerWantedLevel(PlayerId(), 4, 0)
						SetPlayerWantedLevelNow(PlayerId(), 0)
						SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['terrorist'], true)
					end
				end
			end

			if not DoesEntityExist(CurrentMetro) then
				-- Not ANY clue on when this might happen haha, but it's a funny message and error handler in one :Phone_SoundSet_Default
				-- we have seen it happen once or so in MANY test rounds of the metro system that the metro just vanished, so this is to
				-- 'encounter' that POSSIBLE issue (which I presume has to do with de-syncing or so)
				IsPlayerNearMetro = false
				IsPlayerInMetro = false
				PlayerHasMetroTicket = true
				SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['no_metro_spawned'], true)
			else
				if IsPlayerInMetro then
					-- This will ensure that it will only show the 'how to leave metro' text while near/at a station
					if ShowingExitMetroMessage == true and not ShowedLeaveMetroHelper then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to leave the metro")
						ShowedLeaveMetroHelper = true
					end

					-- This part detects if the player is further away than 15.0 units from the Metro he/she used
					MetroX, MetroY, MetroZ = table.unpack(GetOffsetFromEntityInWorldCoords(CurrentMetro, 0.0, 0.0, 0.0))
					x,y,z = table.unpack(GetEntityCoords(playerPed, true))
					if GetDistanceBetweenCoords(x,y,z, MetroX, MetroY, MetroZ, true) > 15.0 then
						IsPlayerNearMetro = false
						IsPlayerInMetro = false
						SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['travel_metro'], true)
					end

				end
			end
		end

	end
end)

Citizen.CreateThread(function()
	--=======================================================================================
	-- Note only do this 'check' every 550ms to prevent
	-- to much load in the game (taking in account many other scripts also running of course)
	--=======================================================================================
	ShowedEToEnterMetro = false
	while true do
		Wait(550)
		if IsPlayerInMetro then
			if XNLCanPlayerExitTrain() then
				ShowingExitMetroMessage = true
			else
				ShowingExitMetroMessage = false
				ShowedLeaveMetroHelper = false
			end
			ShowedEToEnterMetro = false
		end

		-- We only have to check this part if the player is NOT on the metro.
		if not IsPlayerInMetro then
			playerPed = PlayerPedId()
			IsPlayerInVehicle = IsPedInAnyVehicle(playerPed, true)

			-- And then ONLY check it if the player isn't in a vehicle either
			-- Note: The way i'm using the metro, the game doesn't recognize it as being
			-- on/in a vehicle.
			if not IsPlayerInVehicle then

				-- Yes, yes I know, the function is called 'XNLCanPlayerEXITTrain', but it
				-- is also used to detect if the player is at one of the stations on foot :)
				if PlayerHasMetroTicket and XNLCanPlayerExitTrain() then
					if not ShowedEToEnterMetro then
						DisplayHelpText(Message[Language]['press_to_enter'])
						ShowedEToEnterMetro = true
					end
				else
					ShowedEToEnterMetro = false
				end

				-- Only show the "Press [E] to buy...." message near the ticket machine if the player does NOT own a ticket already
				-- Do note that it IS possible to 'activate' the ticket machine again though (but will give a different message ;) )
				x,y,z = table.unpack(GetEntityCoords(playerPed, true))
				-- And then only need to keep checking (scanning cords) if the player is not near the Ticket Machine (anymore)
				if not IsPlayerNearTicketMachine then
					for k,v in pairs(TicketMachines) do
						TicketMachine = GetClosestObjectOfType(x, y, z, 0.75, GetHashKey(v), false)
						if DoesEntityExist(TicketMachine) then
							currentTicketMachine = TicketMachine
							TicketMX, TicketMY, TicketMZ = table.unpack(GetOffsetFromEntityInWorldCoords(TicketMachine, 0.0, -.85, 0.0))
							IsPlayerNearTicketMachine = true
						end
					end
				else
					if not DoesEntityExist(currentTicketMachine) then
						IsPlayerNearTicketMachine = false -- If for some (weird) reasons the ticked machine (suddenly)
					else								  --doesn't exist anymore, tell the script that the player isn't near one anymore
						if GetDistanceBetweenCoords(x,y,z, TicketMX, TicketMY, TicketMZ, true) > 2.0 then
							IsPlayerNearTicketMachine = false -- And do the same if the player is more than a radius of 2.0 away from the ticket machine
						end
					end
				end
			end
		end
	end
end)

-- This is the function which is used to display 'SMS Style messages'
-- If you need more/other icons to display, then make sure to check out:
-- https://wiki.gtanet.work/index.php?title=Notification_Pictures
-- YES YES, I KNOW! it's 'a competitor' :P but it's definitly a good
-- resource for fellow modders :)
function SMS_Message(NotiPic, SenderName, Subject, MessageText, PlaySound)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(MessageText)
    SetNotificationBackgroundColor(140)
    SetNotificationMessage(NotiPic, NotiPic, true, 4, SenderName, Subject, MessageText)
    DrawNotification(false, true)
	if PlaySound then
		PlaySoundFrontend(GetSoundId(), "Text_Arrive_Tone", "Phone_SoundSet_Default", true)
	end
end

-- This is the text 'helper' which is used at the top left for messages like 'Press [E] to buy ticket ($25)'
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	EndTextCommandDisplayHelp(0, 0, true, 2000)
end

-- Using a RayCast to detect if the player is trying to get into the train
-- This is needed since it's not possible (yet) to detect the train model with
-- the normal native calls
function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end


--==============================================
-- Simple yet effective function to check if
-- player is female or male (sine we only use
-- mp_f_freemode_01 and mp_m_freemode_01 on our
-- server) We need(ed) this function because for
-- some weird reason IsPedMale had some issues
-- with some scripts.
--==============================================
function XNLIsPedFemale(ped)
	if IsPedModel(ped, 'mp_f_freemode_01') then
		return true
	else
		return false
	end
end

function XNLCanPlayerExitTrain()
	playerPed = PlayerPedId()
	for _, item in pairs(XNLMetroScanPoints) do
		Px,Py,Pz = table.unpack(GetEntityCoords(playerPed, true))
		if GetDistanceBetweenCoords(Px,Py,Pz, item.x, item.y, item.z, true) < StationsExitScanRadius then
			return true -- The function DID detected the player within one of the radius markers at the stations
		end
	end
	return false -- The function did NOT detected the player within one of the radius markers at the stations
end

function XNLTeleportPlayerToNearestMetroExit()
	playerPed = PlayerPedId()
	for _, item in pairs(XNLMetroScanPoints) do
		Px,Py,Pz = table.unpack(GetEntityCoords(playerPed, true))
		if GetDistanceBetweenCoords(Px,Py,Pz, item.x, item.y, item.z, true) < StationsExitScanRadius then
			for _, item2 in pairs(XNLMetroEXITPoints) do
				if item.XNLStationid == item2.XNLStationid  then
					DoScreenFadeOut(800)
					while not IsScreenFadedOut() do
						Wait(10)
					end
					XNLNewX = item2.x -- The 'new' Player X position
					XNLNewY = item2.y -- The 'new' Player Y position
					XNLNewZ = item2.z -- The 'new' Player Z position
					XNLNewH = item2.h -- The 'new' Player Heading Direction

					SetEntityCoordsNoOffset(PlayerPedId(), XNLNewX, XNLNewY, XNLNewZ)
					SetEntityHeading(PlayerPedId(), XNLNewH)

					DoScreenFadeIn(800)
					while not IsScreenFadedIn() do
						Wait(10)
					end
					return true
				end
			end
		end
	end
	return false -- The function did NOT detected the player within one of the radius markers at the stations
end

Citizen.CreateThread(function()
	while EverythingisK == false do Citizen.Wait(0) end
	while true do
		Citizen.Wait(0)
		local closest = 10
		if DoesEntityExist(MetroTrain) then
			if not MetroTrainStopped[MetroTrain] then
				local coords = GetEntityCoords(MetroTrain)
				if coords then
					for k,v in ipairs(MetroTrainstops) do
						if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) <= closest then
							StopTrain(MetroTrain)
						end
					end
				end
			end
		end
		if DoesEntityExist(MetroTrain2) then
			if not MetroTrainStopped[MetroTrain2] then
				local coords = GetEntityCoords(MetroTrain2)
				if coords then
					for k,v in ipairs(MetroTrainstops) do
						if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) <= closest then
							StopTrain(MetroTrain2)
						end
					end
				end
			end
		end
	end
end)

function StopTrain(train)
	if (NetworkHasControlOfEntity(train)) then
		table.insert(MetroTrainStopped, train) 
		SetTrainCruiseSpeed(train, 0.0) -- We stop the train
		Citizen.Wait(100)
		if train ~= nil then
			local stoppedTimer = GetGameTimer();
			repeat 
				Citizen.Wait(0)
			until GetEntitySpeed(train) <= 0
			while (GetGameTimer() - stoppedTimer < (20 * 1000)) do -- We stop the train for 20 sec. With a Citizen.wait, our variable is destroyed. So we need to keep up.
				Citizen.Wait(0)
			end
		end
		Citizen.Wait(100)
		SetTrainCruiseSpeed(train, 15.0) -- Bye bye train !
		local timer = GetGameTimer();
		while (GetGameTimer() - timer < 5000) do -- After 5 sec, we can tell that train have "finished" their stop.
			removebyKey(MetroTrainStopped, train)
			Citizen.Wait(0)
		end
	end
end

-- Added for OneSync
local firstspawn = 0 -- By default, Its the first spawn of the player. So, I don't recommend to restart the script with already player in the server.

AddEventHandler('playerSpawned', function()
	while EverythingisK == false do Citizen.Wait(0) end -- The Event "StartTrain" is fully registered. We can continue now.
	if firstspawn == 0 then -- First spawn of the player ? Check if they are already trains
		TriggerServerEvent('FiveM-Trains:PlayerSpawned')
		firstspawn = 1 -- Just for making not trigger the event if he respawn after die.
	end
end)

-- This is added if we restart the ressource.
-- Needed for the dev. May be I will remove it later.
-- This remove all train
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	DeleteMissionTrain(MetroTrain)
	DeleteMissionTrain(MetroTrain2)
	DeleteMissionTrain(Train)
end)