ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(2000)
	PlayerData = ESX.GetPlayerData()
end)

local PlayerData = {}

local Status = true

local enabled = false

local incharacterselection = false

local isInMarker   = false

local guiEnabled   = false

local hasIdentity  = false

local keepDecor    = false

local Ped = {
	Active = false,
	Id = 0,
	Alive = false,
	Available = false,
	Visible = false,
	InVehicle = false,
	OnFoot = false,
	Vehicle = nil,
	VehicleClass = nil,
	VehicleStopped = true,
	VehicleEngine = false,
	VehicleCurrentGear = nil,
	VehicleHighGear = nil,
	Ped = nil,
	Coords = nil,
	Zone = nil,
	Direction = nil,
	StreetLabel = {},
	CurrentTimeHours = nil,
	CurrentTimeMinutes = nil,
	ShowGears = false,
	currentFuel = nil,
	Health = 0,
	Armor = 0,
	Stamina = 0,
	Underwater = false,
	UnderwaterTime = 0,
	Driver = false,
	PhoneVisible = false,
}





Config = {
	Identities = {
		{
			Position = { x = -1052.45, y = -2766.13, z = 20.50 },
			Blip = {
				Sprite  = 307,
				Display = 4,
				Scale   = 1.15,
				Color   = 76,
				Label   = "Lotnisko"
			}
		},
		{
			Position = { x = 1775.6317, y = 2552.0938, z = 44.615 },
			Jail = true
		},
		{
			Position = { x = -1824.4376, y = 3290.0005, z = 31.8642 }
		},
	},
	Marker = {
		Type = 1,
		Distance = 100.0,
		Color = { r = 102, g = 0, b = 102 },
		Size = { x = 1.5, y = 1.5, z = 1.0 }
	},

	Keys = {

		["E"] = 38
	}
}



Citizen.CreateThread(function()
	for k, v in pairs(Config.Identities) do
		if v.Blip then
			local blip = AddBlipForCoord(v.Position.x, v.Position.y, v.Position.z)
			SetBlipSprite (blip, v.Blip.Sprite)
			SetBlipDisplay(blip, v.Blip.Display)
			SetBlipScale  (blip, v.Blip.Scale)
			SetBlipColour (blip, v.Blip.Color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.Blip.Label)
			EndTextCommandSetBlipName(blip)
			Citizen.Wait(0)
		end
	end
end)

local connected = false

AddEventHandler("playerSpawned", function()
	if not connected then
		TriggerServerEvent("rocademption:playerConnected")
		connected = true
	end
end)

Citizen.CreateThread(function()
	while true do
		if isInMarker then
			Citizen.Wait(10)
			SetTextComponentFormat('STRING')
			AddTextComponentString('Naciśnij ~INPUT_CONTEXT~ aby oddać bilet kuzynowi')

			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, Config.Keys['E'])  then
				ESX.TriggerServerCallback('Primecharacter:fetchcharacters', function(characters)
					local elements = {}
					
					if characters[1] ~= nil and characters[1].identifier ~= PlayerData.identifier then
						table.insert(elements, {label = characters[1].firstname..' '..characters[1].lastname, value = '1'})
					end
					if characters[2] ~= nil and characters[2].identifier ~= PlayerData.identifier then
						table.insert(elements, {label = characters[2].firstname..' '..characters[2].lastname, value = '2'})
					end
					if characters[3] ~= nil and characters[3].identifier ~= PlayerData.identifier then
						table.insert(elements, {label = characters[3].firstname..' '..characters[3].lastname, value = '3'})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'identities', {
						title = 'Rodzina',
						align = 'center',
						elements = elements
					}, function (data, menu)
						menu.close()
						TriggerServerEvent('Primecharacter:selectcharacter', data.current.value)
						FreezeEntityPosition(Ped.Id, false)
						SetPlayerInvincible(PlayerId(), false)
						SetEntityInvincible(PlayerPedId(), false)
					end, function (data, menu)
						menu.close()
					end)
				end)
			end
		else
			Citizen.Wait(0)
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local inMarker, coords = false, GetEntityCoords(PlayerPedId())
		for k, v in pairs(Config.Identities) do
			local distance = #(coords - vec3(v.Position.x, v.Position.y, v.Position.z))
			if distance < Config.Marker.Distance then
				DrawMarker(Config.Marker.Type, v.Position.x, v.Position.y, v.Position.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Marker.Size.x, Config.Marker.Size.y, Config.Marker.Size.z, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, 100, false, true, 2, false, false, false, false)
				if distance < Config.Marker.Size.x then
					inMarker  = true
				end
			end
		end

		if inMarker and not isInMarker then
			isInMarker = true
		end
		
		if not inMarker and isInMarker then
			isInMarker = false
			ESX.UI.Menu.CloseAll()
		end
	end
end)
RegisterNetEvent('Primecharacter:spawncharacter')
AddEventHandler('Primecharacter:spawncharacter', function()
	exports['AriviRP']:reloadmewhynot()
	TriggerServerEvent('es:firstJoinProper')
	TriggerEvent('es:allowedToSpawn')
    SetTimecycleModifier('default')
	TriggerEvent('esx-qalle-jail:checkCharacter')
	TriggerServerEvent('gcPhone:allUpdate')
    ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
        if isDead then
            SetEntityHealth(GetPlayerPed(-1), 0)
        end
    end)
    
end)

CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('hardcap:playerActivated')

			return
		end
	end
end)