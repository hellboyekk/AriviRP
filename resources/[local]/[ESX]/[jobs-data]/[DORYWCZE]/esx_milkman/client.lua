local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}
Config = {}
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.2 }
Config.MarkerColor                = { r = 0, g = 130, b = 204 }
Config.MainMenu = {
	{x = 2500.960, y = 4800.750, z = 34.740}
}
ESX                           = nil
local PlayerData                = {}
local menuIsShowed 				 = false
local hasAlreadyEnteredMarker 	 = false
local hasAlreadyEnteredMarkerr 	 = false
local lastZone 					 = nil
local isInJoblistingMarker 		 = false
local isInJoblistingMarkerr 		 = false
local bet = 0
local wtrakcie = false
local model = "prop_bucket_02a"
local bagModel = "prop_bucket_02a"
local bagspawned = nil
local maitem = false
local tekst = 0
Citizen.CreateThread(function()
    while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	  PlayerData.name = name
end)


	Citizen.CreateThread(function()
		while true do

			Citizen.Wait(1)
			local coords = GetEntityCoords(GetPlayerPed(-1))

			if (GetDistanceBetweenCoords(coords, 2441.460, 4755.190, 33.70, true) < 30.0) and PlayerData.job.name == 'krowa' then
			
						ESX.Game.Utils.DrawText3D({ x = 2441.06, y = 4755.05, z = 33.85 }, '~y~[E] ~w~Dojenie krowy', 0.6)		
						ESX.Game.Utils.DrawText3D({ x = 2443.96, y = 4764.95, z = 33.85 }, '~y~[E] ~w~Dojenie krowy', 0.6)	
						ESX.Game.Utils.DrawText3D({ x = 2434.870, y = 4764.150, z = 33.80 }, '~y~[E] ~w~Dojenie krowy', 0.6)				
						ESX.Game.Utils.DrawText3D({ x = 2430.76, y = 4773.95, z = 33.85 }, '~y~[E] ~w~Dojenie krowy', 0.6)				
				
		end
		end
	end)



	Citizen.CreateThread(function()
		while true do

			Wait(15)
			local coords      = GetEntityCoords(GetPlayerPed(-1))


			if(GetDistanceBetweenCoords(coords, 2441.460, 4755.190, 33.70, true) < 2.0) or (GetDistanceBetweenCoords(coords, 2443.870, 4764.750, 33.20, true) < 2.0) or (GetDistanceBetweenCoords(coords, 2434.870, 4764.150, 33.20, true) < 2.0) then


				local coords      = GetEntityCoords(GetPlayerPed(-1))
				local isInMarker  = false
				local currentZone = nil
		local zaplata = 0


						if ESX.GetPlayerData().job.name == 'krowa' then
									if IsControlJustReleased(0, Keys['E']) then
										if wtrakcie == false then
										zbieranie()
										end
									end
							end
			end -- od getdistance
			end -- od while
	end)

	function zbieranie()
	TriggerServerEvent('smerfikcraft:zlomiarzzbier2')
	wtrakcie = true
	end
	RegisterNetEvent('wiadro:postaw')
	AddEventHandler('wiadro:postaw', function()
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local forward   = GetEntityForwardVector(playerPed)
		local x, y, z   = table.unpack(coords + forward * 1.0)
	if maitem == false then
		ESX.Game.SpawnObject(model, {
			x = x,
			y = y,
			z = z
		}, function(obj)
			SetEntityHeading(obj, GetEntityHeading(playerPed))
			PlaceObjectOnGroundProperly(obj)
			Citizen.Wait(10000)
			DeleteObject(obj)
		end)
	end
	end)


	RegisterNetEvent('smerfik:zamrozcrft222')
	AddEventHandler('smerfik:zamrozcrft222', function()
		playerPed = PlayerPedId()	
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(playerPed, true)
	end)
	RegisterNetEvent('smerfik:odmrozcrft222')
	AddEventHandler('smerfik:odmrozcrft222', function()
		playerPed = PlayerPedId()
		FreezeEntityPosition(playerPed, false)
		ClearPedTasks(PlayerPedId())

		

		TriggerEvent('podlacz:propa22')
		maitem = true

	Citizen.Wait(500)
		wtrakcie = false

	end)


	RegisterNetEvent('smerfik:craftanimacja222')
	AddEventHandler('smerfik:craftanimacja222', function()
		TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	Citizen.Wait(2000)
	end)



	function loadAnimDict(dict)
		while (not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Citizen.Wait(10)
		end
	end
	Citizen.CreateThread(function()
	
		RequestModel(GetHashKey("a_c_cow"))
		while not HasModelLoaded(GetHashKey("a_c_cow")) do
			Wait(155)
		end

			local ped =  CreatePed(4, GetHashKey("a_c_cow"), 2441.06, 4755.95, 33.35, -149.404, false, true)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			while true do
				Citizen.Wait(10000)
				TaskPedSlideToCoord(ped, 2441.76, 4755.95, 33.45, -149.404, 10)
			end
	end)
	Citizen.CreateThread(function()

	RequestModel(GetHashKey("a_c_cow"))
	while not HasModelLoaded(GetHashKey("a_c_cow")) do
		Wait(155)
	end

		local ped =  CreatePed(4, GetHashKey("a_c_cow"), 2443.96, 4764.95, 33.35, -349.404, false, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		while true do
			Citizen.Wait(10000)
			TaskPedSlideToCoord(ped, 2443.76, 4764.95, 33.45, -349.404, 10)
		end
	end)
	Citizen.CreateThread(function()

	RequestModel(GetHashKey("a_c_cow"))
	while not HasModelLoaded(GetHashKey("a_c_cow")) do
		Wait(155)
	end

		local ped =  CreatePed(4, GetHashKey("a_c_cow"), 2434.76, 4764.95, 33.35, 149.404, false, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		while true do
			Citizen.Wait(10000)
			TaskPedSlideToCoord(ped, 2434.76, 4764.95, 33.45, 749.404, 10)
		end
	end)
	Citizen.CreateThread(function()

	RequestModel(GetHashKey("a_c_cow"))
	while not HasModelLoaded(GetHashKey("a_c_cow")) do
		Wait(155)
	end

		local ped =  CreatePed(4, GetHashKey("a_c_cow"), 2430.76, 4773.95, 33.45, 749.404, false, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		while true do
			Citizen.Wait(10000)
			TaskPedSlideToCoord(ped, 2430.76, 4773.95, 33.45, 749.404, 10)
		end
	end)

	Citizen.CreateThread(function()
		while true do

			Wait(5)
			local coords  = GetEntityCoords(GetPlayerPed(-1))



			if PlayerData.job.name == 'krowa' then
		ESX.Game.Utils.DrawText3D({ x = 2512.870, y = 4761.850, z = 34.90 }, '~y~[E] ~w~Szatnia', 0.6)	
			
				local coords      = GetEntityCoords(GetPlayerPed(-1))

							local zaplata = 0

								local coords = GetEntityCoords(GetPlayerPed(-1))
								for i=1, #Config.MainMenu, 1 do
									if(GetDistanceBetweenCoords(coords, Config.MainMenu[i].x, Config.MainMenu[i].y, Config.MainMenu[i].z, true) < 10)  then
										sleep = false
										if not IsPedInAnyVehicle(PlayerPedId(-1), true) then
											DrawMarker(22, Config.MainMenu[i].x, Config.MainMenu[i].y, Config.MainMenu[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 500, false, true, 10, false, false, false, false)
										end
									end
								end
					
								local currentZone = nil
								for i=1, #Config.MainMenu, 1 do
								if(GetDistanceBetweenCoords(coords, Config.MainMenu[i].x, Config.MainMenu[i].y, Config.MainMenu[i].z, true) < Config.MarkerSize.x) then
									SetTextComponentFormat('STRING')
									AddTextComponentString("~o~Naciśnij ~INPUT_CONTEXT~ aby wlać mleko do maszyny")
									DisplayHelpTextFromStringLabel(0, 0, 1, -1)
									if IsControlJustReleased(0, Keys['E']) then

										skup()
									end
								end
								end
		

									
									if(GetDistanceBetweenCoords(coords, 2512.740, 4761.850, 34.90, true) < 5.0) then
								
										if IsControlJustReleased(0, Keys['E']) then
											
										ubrania()
									end
		
									
							
			end
		end
		end
	end)
	function ubrania()
		if ESX.GetPlayerData().job.name == 'krowa' then
		TriggerEvent('skinchanger:getSkin', function(skin)
		
			if skin.tshirt_1 == 15 and skin.torso_1 == 43 then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
					end)
					
				else
					local clothesSkin = {
						['tshirt_1'] = 15, ['tshirt_2'] = 0,
						['torso_1'] = 43, ['torso_2'] = 0,
						['arms'] = 37, ['arms_2'] = 0,
						['pants_1'] = 27, ['pants_2'] = 3,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['shoes_1'] = 4, ['shoes_2'] = 1
						}
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
			end
		end)
	end
	end
	RegisterNetEvent('podlacz:propa22')
	AddEventHandler('podlacz:propa22', function()
		local ad = "anim@heists@box_carry@"
		loadAnimDict( ad )
		TaskPlayAnim( PlayerPedId(), ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )

		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

	if maitem == false then
			bagspawned = CreateObject(GetHashKey(bagModel), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(bagspawned, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, -0.24, 0.355, -75.0, 470.0, 0.0, true, true, false, true, 1, true)
			
	end
	Citizen.Wait(10000)
	end)
	RegisterNetEvent('sprzedawanie:jablekanim22')
	AddEventHandler('sprzedawanie:jablekanim22', function()

		local playerPed = PlayerPedId()
		local lib, anim = 'gestures@m@standing@casual', 'gesture_easy_now'
		FreezeEntityPosition(playerPed, true)
		ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
	end)
	function skup()

		TriggerServerEvent('smerfikcraft:skup22')

	Citizen.Wait(3500)
		Citizen.Wait(13000)
		FreezeEntityPosition(PlayerPedId(), false)

		wtrakcie = false
	end
		
	RegisterNetEvent('odlacz:propa3')
	AddEventHandler('odlacz:propa3', function()
		DetachEntity(bagspawned, 1, 1)
		ClearPedSecondaryTask(PlayerPedId())

	end)
	RegisterNetEvent('odlacz:propa2')
	AddEventHandler('odlacz:propa2', function()
		DeleteObject(bagspawned)

		maitem = false

		FreezeEntityPosition(PlayerPedId(), false)
	end)

	local blips = {

		{title="Krowy", colour=4, id=141, x = 2438.240, y = 4765.890, z = 35.00},
		{title="Przebieralnia mleczarzy", colour=4, id=366, x = 2512.990, y = 4762.750, z = 34.90},
		{title="Maszyna mleczarzy", colour=4, id=402, x = 2502.120, y = 4801.250, z = 43.740}

	}      
	CreateThread(function()
		if PlayerData.job ~= nil and PlayerData.job.name == 'krawiec' then
			for _, info in pairs(blips) do
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 1.0)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end

	end)

	local UI = { 

		x =  0.000 ,	-- Base Screen Coords 	+ 	 x
		y = -0.001 ,	-- Base Screen Coords 	+ 	-y

	}
	RegisterNetEvent('smerfik:tekstjab22')
	AddEventHandler('smerfik:tekstjab22', function()
	while true do
		Citizen.Wait(1)
		if wtrakcie == true then

		drawTxt(UI.x + 0.9605, UI.y + 0.962, 1.0,0.98,0.4, "~y~[~w~".. tekst .. "%~y~]", 255, 255, 255, 255)

	end
	end
	end)
	function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
		SetTextFont(4)
		SetTextProportional(0)
		SetTextScale(scale, scale)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(2, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x - width/2, y - height/2 + 0.005)
	end
	RegisterNetEvent('smerfik:zdejmijznaczek22')
	AddEventHandler('smerfik:zdejmijznaczek22', function()
	wtrakcie = false
	end)
	RegisterNetEvent('zacznijtekst22')
	AddEventHandler('zacznijtekst22', function()
		Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1
	Citizen.Wait(74)
	tekst = tekst + 1

	Citizen.Wait(1500)
	tekst = 0
	end)

	function loadAnimDict(dict)
		while (not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Citizen.Wait(5)
		end
	end