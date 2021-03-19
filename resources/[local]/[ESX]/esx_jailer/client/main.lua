local IsJailed = false
local unjail = false
local JailTime = 0
local fastTimer = 0
local JailLocation = Config.JailLocation
local SpawnedPeds = {}
local HandcuffProp = nil
local isHandcuffed = false
local timeToFree = 0
local prop = nil

local jobDestination = nil
local CurrentAction = nil
local hasAlreadyEnteredMarker = false
local jobBlips = {}
local jobNumber = nil
local isWorking = false
local working = false
ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent('xjail:notify')
AddEventHandler('xjail:notify', function(fine, id, powod)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local name = data.firstname .. ' ' .. data.lastname
		--TriggerEvent('chat:addMessage', { args = { '^*PROKURATOR: ^5^*' .. name .. ' ^7^*otrzymał karę wiezięnia: ^2^*' .. fine .. ' lat. ^7^*Powód: ^3^*' .. powod}, color = { 147, 196, 109 } })
		TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(255, 0, 0, 0.4); border-radius: 3px;"><i class="fas fa-gavel"style="font-size:13px;color:rgb(255,255,255,0.5)"></i>&ensp;<font color="FFFFFF">{0}</font>&ensp;<font color="white">{1}</font></div>',
            args = { '^*PROKURATOR: ^5^*' .. name .. ' ^7^*otrzymał karę wiezięnia: ^2^*' .. fine .. ' lat.', '' }
        })

	end, id)

end)

RegisterNetEvent('xunjail:notify')
AddEventHandler('xunjail:notify', function(id)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local name = data.firstname .. ' ' .. data.lastname
		--TriggerEvent('chat:addMessage', { args = { '^*PROKURATOR: ^5^*' .. name .. ' ^7^*wyszedł z więzienia.'}, color = { 147, 196, 109 } })
		--[[TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(255, 0, 0, 0.4); border-radius: 3px;"><i class="fas fa-gavel"style="font-size:13px;color:rgb(255,255,255,0.5)"></i>&ensp;<font color="FFFFFF">{0}</font>&ensp;<font color="white">{1}</font></div>',
            args = { '^*PROKURATOR: ^5^*' .. name .. ' ^7^*wyszedł z więzienia.', '' }
		})]]
		TriggerEvent('chat:addMessage',  { args = { "[SĘDZIA]",  "^4" .. name .. "^7 wyszedł z więzienia"}, color = { 255, 166, 0 } })

	end, id)

end)

RegisterNetEvent('esx_jailer:jailhype')
AddEventHandler('esx_jailer:jailhype', function(jailTime)
		if IsJailed then -- don't allow multiple jails
			return
		end

		JailTime = jailTime
		local sourcePed = GetPlayerPed(-1)
		if DoesEntityExist(sourcePed) then
			CreateThread(function()
			
				-- Assign jail skin to user
				TriggerServerEvent("esx-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
				Cutscene()
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "wiezienie", 1.0)
				--[[TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].female)
					end
				end)]]
				
				-- Clear player
				SetPedArmour(sourcePed, 0)
				ClearPedBloodDamage(sourcePed)
				ResetPedVisibleDamage(sourcePed)
				ClearPedLastWeaponDamage(sourcePed)
				ResetPedMovementClipset(sourcePed, 0)
				
				SetEntityCoords(sourcePed, JailLocation.x, JailLocation.y, JailLocation.z)
				IsJailed = true
				unjail = false
				while JailTime > 0 and not unjail do
					sourcePed = GetPlayerPed(-1)
					RemoveAllPedWeapons(sourcePed, true)
					if IsPedInAnyVehicle(sourcePed, false) then
						ClearPedTasksImmediately(sourcePed)
					end

					if JailTime % 120 == 0 then
						TriggerServerEvent('esx_jailer:updateRemaininghype', JailTime)
					end

					Citizen.Wait(20000)

					-- Is the player trying to escape?
					if GetDistanceBetweenCoords(GetEntityCoords(sourcePed), JailLocation.x, JailLocation.y, JailLocation.z) > 100 then
						SetEntityCoords(sourcePed, JailLocation.x, JailLocation.y, JailLocation.z)
						TriggerEvent('chat:addMessage', { args = { _U('judge'), _U('escape_attempt') }, color = { 147, 196, 109 } })
					end
					
					JailTime = JailTime - 25
				end

				-- jail time served
				TriggerServerEvent('esx_jailer:unjailTimehype', -1)
				SetEntityCoords(sourcePed, Config.JailBlip.x, Config.JailBlip.y, Config.JailBlip.z)
				IsJailed = false

				-- Change back the user skin
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end)
		end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1)

		if JailTime > 0 and IsJailed then
			if fastTimer < 0 then
				fastTimer = JailTime
			end

			draw2dText(_U('remaining_msg', ESX.Round(fastTimer)), { 0.015, 0.935 } )
			fastTimer = fastTimer - 0.018
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('esx_jailer:unjailhype')
AddEventHandler('esx_jailer:unjailhype', function(source)
	unjail = true
	JailTime = 0
	fastTimer = 0
end)

-- When player respawns / joins
AddEventHandler('playerSpawned', function(spawn)
	if IsJailed then
		SetEntityCoords(GetPlayerPed(-1), JailLocation.x, JailLocation.y, JailLocation.z)
	else
		TriggerServerEvent('esx_jailer:checkJailhype')
	end
end)

-- When script starts
CreateThread(function()
	Citizen.Wait(2000) -- wait for mysql-async to be ready, this should be enough time
	TriggerServerEvent('esx_jailer:checkJailhype')
end)

-- Create Blips
CreateThread(function()
	local blip = AddBlipForCoord(Config.JailBlip.x, Config.JailBlip.y, Config.JailBlip.z)
	SetBlipSprite (blip, 188)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.5)
	SetBlipColour (blip, 0)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Wiezienie')
	EndTextCommandSetBlipName(blip)
end)

function draw2dText(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end

function round(x)
	return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end




CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsJailed then
			if not working then
				CreateJob()
			else
				local isInMarker = false
				local coords = GetEntityCoords(PlayerPedId())
				if Config.Marker == true then
					DrawMarker(Config.Jobs.Marker.Type, jobDestination.Pos.x, jobDestination.Pos.y, jobDestination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Jobs.Marker.Size.x, Config.Jobs.Marker.Size.y, Config.Jobs.Marker.Size.z, Config.Jobs.Marker.Color.r, Config.Jobs.Marker.Color.g, Config.Jobs.Marker.Color.b, 100, false, true, 2, false, false, false, false)	
				end		
					if GetDistanceBetweenCoords(coords, jobDestination.Pos.x, jobDestination.Pos.y, jobDestination.Pos.z, true) < 20 then
						--ESX.ShowHelpNotification('Wcisnij ~INPUT_CONTEXT~ aby pracowac')
						DrawText3D(jobDestination.Pos.x, jobDestination.Pos.y, jobDestination.Pos.z + 1.0,'~py~[E] ~g~Aby pracowac')
						if IsControlJustReleased(0, 38) then
							StartWork()
							CreateJob()
						end
					end
			end			
		end
	end
end)

function CreateJob()
	local newJob
	repeat
		newJob = math.random(1, #Config.Jobs.List)
		Citizen.Wait(1)
	until newJob ~= jobNumber

	working = true
	jobNumber = newJob
	jobDestination = Config.Jobs.List[jobNumber]
	CreateBlip(jobDestination)
end



function CreateBlip(cords)
	if jobBlips['job'] ~= nil then
		RemoveBlip(jobBlips['job'])
	end

	jobBlips['job'] = AddBlipForCoord(cords.Pos.x, cords.Pos.y, cords.Pos.z)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Praca więzienna ' .. cords.Name)
	EndTextCommandSetBlipName(jobBlips['job'])
	if not IsJailed then
		RemoveBlip(jobBlips['job'])
	end
end

function StartWork()
	isWorking = true
	local delay = math.random(5000, 10000)
	if Config.Notify == true then
		TriggerEvent("pNotify:SetQueueMax", "work", 2)
		TriggerEvent("pNotify:SendNotification", {
			text = "Zaczynasz pracować",
			type = "error",
			queue = "work",
			timeout = 5000,
			layout = "CenterLeft"
		})
	else
		ESX.ShowAdvancedNotification('Wiezienie', 'Praca', 'Zaczales pracowac', 'CHAR_BLOCKED', 8)
	end
	FreezeEntityPosition(PlayerPedId(), true)

	CreateThread(function()
		Citizen.Wait(delay)
		isWorking = false

		local minusTime = Config.Usuntimeessen
		JailTime = JailTime - minusTime
		TriggerServerEvent('esx_jailer:updateRemaining', JailTime)
		fastTimer = fastTimer - minusTime
		if Config.Notify == true then
			TriggerEvent("pNotify:SetQueueMax", "work", 2)
			TriggerEvent("pNotify:SendNotification", {
				text = "Od twojej odsiadki odjeto " .. minusTime ..  " miesiecy!",
				type = "error",
				queue = "work",
				timeout = 5000,
				layout = "CenterLeft"
			})
		else
			ESX.ShowAdvancedNotification('Wiezienie', 'Praca', 'Od twojej odsiadki odjeto ~g~' .. minusTime .. ' ~w~miesiecy!', 'CHAR_BLOCKED', 8)
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.03, 41, 11, 41, 90)
end


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for i=1, #SpawnedPeds, 1 do
			DeleteEntity(SpawnedPeds[i].e)
			DeleteEntity(HandcuffProp)
		end
	end

	if DoesEntityExist(prop) then
		DeleteEntity(prop)
		DisablePlayerFiring(playerPed, false)
	end

	StopAllAlarms(true)
end)

local cinema = false
function ToggleHUD(bool)
	if bool == true then
		cinema = true
		TriggerEvent('es:setMoneyDisplay', 0.0)
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
		DisplayRadar(false)
	else
		cinema = false
		TriggerEvent('es:setMoneyDisplay', 1.0)
		ESX.UI.HUD.SetDisplay(1.0)
		TriggerEvent('esx_status:setDisplay', 1.0)
	end
end

function SpawnCam(cam)
	RenderScriptCams(false, false, 0, true, true)

	local camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(camera, cam.coord.x, cam.coord.y, cam.coord.z)
	SetCamRot(camera, cam.rot.x, cam.rot.y, cam.rot.z)

	RenderScriptCams(true, false, 0, true, true)
end

CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('rcmme_amanda1', function()
					TaskPlayAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
				end)		
			end			
		else
			if prop ~= nil then
				DisablePlayerFiring(playerPed, true)
			else
				DisablePlayerFiring(playerPed, false)
			end

			Citizen.Wait(500)
		end
	end
end)

function CuffAnim()
	isHandcuffed = not isHandcuffed

	local playerPed = GetPlayerPed(-1)

	if isHandcuffed then
		RequestAnimDict('rcmme_amanda1')

		while not HasAnimDictLoaded('rcmme_amanda1') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 8.0, 3.0, -1, 50, 0, 0, 0, 0)

		if not DoesEntityExist(HandcuffProp) then
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			HandcuffProp = CreateObject(GetHashKey('p_cs_cuffs_02_s'), x, y, z,  true,  true, true)
			AttachEntityToEntity(HandcuffProp, playerPed, GetPedBoneIndex(playerPed, 60309), -0.0302, 0.0, 0.070, 110.0, 90.0, 100.0, 1, 0, 0, 0, 0, 1)
		end

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		DisplayRadar(false)
	else
		if DoesEntityExist(HandcuffProp) then
			DeleteEntity(HandcuffProp)
		end

		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, true)
	end
end

function TakeUniform()
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			local clothesSkin = Config.Uniforms.prison_wear.male
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		else
			local clothesSkin = Config.Uniforms.prison_wear.female
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end


function Cutscene(fine)
	--[[DoScreenFadeOut(100)

	Citizen.Wait(250)

	local Male = GetHashKey("mp_m_freemode_01")

	TriggerEvent('skinchanger:getSkin', function(skin)
		if GetHashKey(GetEntityModel(PlayerPedId())) == Male then
TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].male)
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

		else
TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].female)
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)

	LoadModel(-1320879687)

	local PolicePosition = Config.Cutscene["PolicePosition"]
	local Police = CreatePed(5, -1320879687, PolicePosition["x"], PolicePosition["y"], PolicePosition["z"], PolicePosition["h"], false)
	TaskStartScenarioInPlace(Police, "WORLD_HUMAN_PAPARAZZI", 0, false)

	local PlayerPosition = Config.Cutscene["PhotoPosition"]
	local PlayerPed = PlayerPedId()
	SetEntityCoords(PlayerPed, PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
	SetEntityHeading(PlayerPed, PlayerPosition["h"])
	FreezeEntityPosition(PlayerPed, true)

	Cam()

	Citizen.Wait(1000)

	DoScreenFadeIn(100)

	Citizen.Wait(10000)

	DoScreenFadeOut(250)

	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"])
	DeleteEntity(Police)
	SetModelAsNoLongerNeeded(-1320879687)

	Citizen.Wait(1000)

	DoScreenFadeIn(250)

	TriggerServerEvent("InteractSound_SV:PlayOnSource", "wiezienie", 0.3)

	RenderScriptCams(false,  false,  0,  true,  true)
	FreezeEntityPosition(PlayerPed, false)
	DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])]]
	local PlayerConfig = Config.ArrestedCutScene.Player
	DoScreenFadeOut(50)

	RequestModel(GetHashKey("s_m_m_prisguard_01"))

	while not HasModelLoaded(GetHashKey("s_m_m_prisguard_01")) do
		Citizen.Wait(1)
	end

	SetEntityCoords(GetPlayerPed(-1), PlayerConfig.coord.x, PlayerConfig.coord.y, PlayerConfig.coord.z-0.95)
	SetEntityHeading(GetPlayerPed(-1), PlayerConfig.head)

	RemoveAllPedWeapons(PlayerPedId(), true)

	for i=1, #Config.ArrestedCutScene.NPC, 1 do
		local guardConfig = Config.ArrestedCutScene.NPC[i]		

		local gurad = CreatePed(5, GetHashKey(guardConfig.ped), guardConfig.coord.x, guardConfig.coord.y, guardConfig.coord.z, guardConfig.head, true)

		GiveWeaponToPed(gurad, GetHashKey("WEAPON_CARBINERIFLE"), 100, true, true)
		TaskGoToCoordAnyMeans(gurad, guardConfig.dest.x, guardConfig.dest.y, guardConfig.dest.z, 0.7, false, false, 786603, 1.0)
		table.insert(SpawnedPeds, {e = gurad, c = guardConfig})
	end

	TaskGoToCoordAnyMeans(GetPlayerPed(-1), PlayerConfig.dest.x, PlayerConfig.dest.y, PlayerConfig.dest.z, 0.15, false, false, 786603, 1.0)
	SetEntityMaxSpeed(GetPlayerPed(-1), 1.6)
	CuffAnim()
	ToggleHUD(true)
	SpawnCam(Config.ArrestedCutScene.Cams["Cam0"])
	Citizen.Wait(2500)
	DoScreenFadeIn(450)
	Citizen.Wait(2500)
	SpawnCam(Config.ArrestedCutScene.Cams["Cam1"])
	Citizen.Wait(5000)
	SpawnCam(Config.ArrestedCutScene.Cams["Cam2"])
	Citizen.Wait(6000)
	SetEntityMaxSpeed(GetPlayerPed(-1), 100.6)
	DoScreenFadeOut(1800)
	Citizen.Wait(2000)
	RenderScriptCams(false,  false,  0,  true,  true)
	--ToggleHUD(false)
	-- Play epic soundeffect
	for i=1, #SpawnedPeds, 1 do
		DeleteEntity(SpawnedPeds[i].e)
	end	

	SetEntityCoords(GetPlayerPed(-1), Config.PrisonZones["SPos"].coord.x, Config.PrisonZones["SPos"].coord.y, Config.PrisonZones["SPos"].coord.z-0.95)
	SetEntityHeading(GetPlayerPed(-1), Config.PrisonZones["SPos"].heading)
	Citizen.Wait(500)
	TakeUniform()
	DoScreenFadeIn(450)
	--------------- NEXT STAGE
	TaskGoToCoordAnyMeans(GetPlayerPed(-1), 1757.14,  2513.82,  45.57, 1.0, false, false, 786603, 1.0)
	
	local guardConfig = Config.PrisonZones["9AB"].peds

	local gurad = CreatePed(5, GetHashKey(guardConfig.ped), guardConfig.coord.x, guardConfig.coord.y, guardConfig.coord.z, guardConfig.head, true)

	FreezeEntityPosition(gurad, true)
	GiveWeaponToPed(gurad, GetHashKey("WEAPON_CARBINERIFLE"), 100, true, true)

	ESX.ShowNotification('~b~Zostałeś zakwaterowany do budynku ~o~[7]')
	SetFollowPedCamViewMode(4)
	Citizen.Wait(26000)
	SpawnCam(Config.ArrestedCutScene.Cams["Cam3"])
	TaskGoToCoordAnyMeans(GetPlayerPed(-1), 1759.31,  2513.23,  45.76, 1.0, false, false, 786603, 1.0)
	Citizen.Wait(1000)	
	FreezeEntityPosition(gurad, false)
	RequestAnimDict("mp_arresting")
	Citizen.Wait(1000)
	SetCurrentPedWeapon(gurad, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	TaskPlayAnim(gurad, "mp_arresting", "a_uncuff", 8.0, 3.0, 2000, 26, 1, 0, 0, 0)
	Citizen.Wait(2000)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'uncuff', 0.3)
	CuffAnim()
	ClearPedSecondaryTask(GetPlayerPed(-1))
	RenderScriptCams(false,  false,  0,  true,  true)
	ToggleHUD(false)
	SetFollowPedCamViewMode(1)
	DoScreenFadeOut(200)
	Citizen.Wait(500)
	DeleteEntity(gurad)
	Citizen.Wait(1500)
	timeToFree = fine
	isInJail = true
	sawGPS = false
	outOfPrison = false
	DoScreenFadeIn(800)
	--ESX.ShowNotification('~b~Zostałeś skazany na '..fine..' miesięcy.')
	ESX.ShowNotification('~b~Witaj w pełni monitorowanym zakładzie penitarnym ~o~[Bolingbroke]!')
	ESX.ShowNotification('~b~Na początek twojej odsiadki radzimy podjąć się pracy więziennej lub dostępnych rozrywek.')

	
end