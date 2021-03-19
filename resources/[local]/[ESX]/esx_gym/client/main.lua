local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}
local training = false
local resting = false
local membership = false

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


RegisterNetEvent('esx_gym:trueMembership')
AddEventHandler('esx_gym:trueMembership', function()
	membership = true
end)

RegisterNetEvent('esx_gym:falseMembership')
AddEventHandler('esx_gym:falseMembership', function()
	membership = false
end)

-- LOCATION (START)

local arms = {
	{x = -1202.9837,y = -1565.1718,z = 4.6115},
}

local pushup = {
	{x = -1203.3242,y = -1570.6184,z = 4.6115},
}

local yoga = {
	{x = -1204.7958,y = -1560.1906,z = 4.6115},
}

local gym = {
	{x = -1195.6551,y = -1577.7689,z = 4.6115},
}

local chins = {
	{x = -1200.1284,y = -1570.9903,z = 4.6115},
}

-- LOCATION (END)


CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(arms) do
            DrawMarker(21, arms[k].x, arms[k].y, arms[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(pushup) do
            DrawMarker(21, pushup[k].x, pushup[k].y, pushup[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(yoga) do
            DrawMarker(21, yoga[k].x, yoga[k].y, yoga[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)


CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(gym) do
            DrawMarker(21, gym[k].x, gym[k].y, gym[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(chins) do
            DrawMarker(21, chins[k].x, chins[k].y, chins[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)



CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(gym) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)

            if dist <= 0.5 then
				hintToDisplay('Kliknij ~INPUT_CONTEXT~ aby otworzyć menu ~b~Siłowni')
				
				if IsControlJustPressed(0, Keys['E']) then
					OpenGymMenu()
				end			
            end
        end
    end
end)

local cfgme = {

	czekaj = "Musisz poczekać~r~ 60 sekund ~w~przed następnymi ćwiczeniami",
	needczlonkostwo = "Potrzebujesz członkostwa aby móc ~r~Ćwiczyć",
	aktualnie = "Aktualnie ~g~Ćwiczysz~w~...",
	musisz = "Musisz odpocząć...",
	icon = 'CustomLogo',
	empty = '',

}

CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(arms) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, arms[k].x, arms[k].y, arms[k].z)

            if dist <= 0.5 then
				hintToDisplay('Kliknij ~INPUT_CONTEXT~ aby ćwiczyć ~g~Sztangą')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification(cfgme.aktualnie)
						Citizen.Wait(1000)					
					
						if membership == true then
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_muscle_free_weights", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							ESX.ShowNotification(cfgme.czekaj)
							
							--TriggerServerEvent('esx_gym:trainArms') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification(cfgme.needczlonkostwo)
						end
					elseif training == true then
						ESX.ShowNotification(cfgme.musisz)
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(chins) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chins[k].x, chins[k].y, chins[k].z)

            if dist <= 0.5 then
				hintToDisplay('Kliknij ~INPUT_CONTEXT~ aby ćwiczyć ~g~Ramiona')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification(cfgme.aktualnie)
						Citizen.Wait(1000)					
					
						if membership == true then
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							ESX.ShowNotification(cfgme.czekaj)
							
							--TriggerServerEvent('esx_gym:trainChins') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification(cfgme.needczlonkostwo)
						end
					elseif training == true then
						ESX.ShowNotification(cfgme.musisz)
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(pushup) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pushup[k].x, pushup[k].y, pushup[k].z)

            if dist <= 0.5 then
				hintToDisplay('Kliknij ~INPUT_CONTEXT~ aby ćwiczyć ~g~Pompki')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification(cfgme.aktualnie)
						Citizen.Wait(1000)					
					
						if membership == true then				
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_push_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							ESX.ShowNotification(cfgme.czekaj)
						
							--TriggerServerEvent('esx_gym:trainPushups') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification(cfgme.needczlonkostwo)
						end							
					elseif training == true then
						ESX.ShowNotification(cfgme.musisz)
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(yoga) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, yoga[k].x, yoga[k].y, yoga[k].z)

            if dist <= 0.5 then
				hintToDisplay('Kliknij ~INPUT_CONTEXT~ aby ćwiczyć ~g~Jogę')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification(cfgme.aktualnie)
						Citizen.Wait(1000)					
					
						if membership == true then	
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							ESX.ShowNotification(cfgme.czekaj)
						
							--TriggerServerEvent('esx_gym:trainYoga') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification(cfgme.needczlonkostwo)
						end
					elseif training == true then
						ESX.ShowNotification(cfgme.musisz)
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)


function OpenGymMenu()

        local elements = {
            {label = 'Sklep', value = 'shop'},
			{label = 'Członkostwo', value = 'ship'},
			{label = 'Szatnia', value = 'szatnia'},
        }
    
        if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
          table.insert(elements,{label = 'Szafka Policyjna', value = 'policemembership'})
        end
  
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'dokumentyszmato',
      {
        title    = 'Legitymacje',
        align    = 'center',
        elements = elements
        },
            function(data, menu)
            if data.current.value == 'shop' then
				OpenGymShopMenu()
			 elseif data.current.value == 'ship' then
				OpenGymShipMenu()
			 elseif PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice') and data.current.value == 'policemembership' then
				OpenPoliceMenu()
			 elseif data.current.value == 'szatnia' then
                OpenSzatniaMenu()
             end
  
            end,
            function(data, menu)
            menu.close()
          end)
  end 

function OpenSzatniaMenu()
  ESX.UI.Menu.CloseAll()

  local elements1 = {}

  local elementMezcz = {
   -- {label = 'Własne ubranie', value = 'ubranie'},
    {label = 'Ubranie Cywilna', value = 'cywil'},
    {label = 'Strój Sportowy 1', value = 'ubranieM1'},
    {label = 'Strój Sportowy 2', value = 'ubranieM2'},
    {label = 'Strój Sportowy 3', value = 'ubranieM3'},
  }
  
  local elementKobt = {
	--{label = 'Własne ubranie', value = 'ubranie'},
	{label = 'Ubranie Cywilna', value = 'cywil'},
    {label = 'Strój Sportowy 1', value = 'ubranieK1'},
    {label = 'Strój Sportowy 2', value = 'ubranieK2'},
    {label = 'Strój Sportowy 3', value = 'ubranieK3'},
  }

  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
      elements1 = elementMezcz
    elseif skin.sex == 1 then
      elements1 = elementKobt
    end
  end)

  ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'szatnia',
      {
          title    = 'Siłownia - Szatnia',
          align    = 'left',
          elements = elements1
      },
      function(data, menu)
          local akcja = data.current.value
          if akcja == 'ubranie' then
			--exports['esx_property']:OpenClothMenu()
		  elseif data.current.value == 'cywil' then
			--onDuty = false
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				GetPedData()
				--reloadskin()
				 TriggerEvent('esx_tattooshop:refreshTattoos')
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
			menu.close()
			
          else
            PrzebierzSzatnia(akcja)
            menu.close()
          end
      end,
      function(data, menu)
          menu.close()
      end
  )
end

function reloadskin()
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    Wait(5000)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    TriggerEvent('esx_tattooshop:refreshTattoos')
end

function GetPedData()
	return Ped
end

function PrzebierzSzatnia(styl)
  SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2)    -- SZYJA
  SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 2)    -- MASKA
  ClearPedProp(GetPlayerPed(-1), 0)                         -- KAPELUSZ
  ClearPedProp(GetPlayerPed(-1), 6)                         -- ZEGAREK
  ClearPedProp(GetPlayerPed(-1), 7)                         -- OPASKA
  ClearPedProp(GetPlayerPed(-1), 1)                         -- OKULARY
  SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 2)    -- TORBA
  SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2)   -- NASZYWKI
  if styl == 'ubranieK1' then
    SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)   -- PODKOSZULEK
    SetPedComponentVariation(GetPlayerPed(-1), 11, 74, 0, 2)  -- TOP
    SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)   -- RĘCE
    SetPedComponentVariation(GetPlayerPed(-1), 4, 10, 0, 2)   -- SPODNIE
    SetPedComponentVariation(GetPlayerPed(-1), 6, 3, 1, 2)   -- BUTY
  elseif styl == 'ubranieK2' then
    SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)   -- PODKOSZULEK
    SetPedComponentVariation(GetPlayerPed(-1), 11, 74, 1, 2)  -- TOP
    SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)   -- RĘCE
    SetPedComponentVariation(GetPlayerPed(-1), 4, 16, 0, 2)   -- SPODNIE
    SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 1, 2)   -- BUTY
  elseif styl == 'ubranieK3' then
    SetPedComponentVariation(GetPlayerPed(-1), 8, 14, 0, 2)   -- PODKOSZULEK
    SetPedComponentVariation(GetPlayerPed(-1), 11, 5, 1, 2)  -- TOP
    SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)   -- RĘCE
    SetPedComponentVariation(GetPlayerPed(-1), 4, 87, 0, 2)   -- SPODNIE
    SetPedComponentVariation(GetPlayerPed(-1), 6, 60, 10, 2)   -- BUTY
  elseif styl == 'ubranieM1' then
    SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)   -- PODKOSZULEK
    SetPedComponentVariation(GetPlayerPed(-1), 11, 15, 0, 2)  -- TOP
    SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)   -- RĘCE
    SetPedComponentVariation(GetPlayerPed(-1), 4, 14, 1, 2)   -- SPODNIE
    SetPedComponentVariation(GetPlayerPed(-1), 6, 75, 12, 2)   -- BUTY
  elseif styl == 'ubranieM2' then
    SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)   -- PODKOSZULEK
    SetPedComponentVariation(GetPlayerPed(-1), 11, 5, 0, 2)  -- TOP
    SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)   -- RĘCE
    SetPedComponentVariation(GetPlayerPed(-1), 4, 42, 0, 2)   -- SPODNIE
    SetPedComponentVariation(GetPlayerPed(-1), 6, 75, 12, 2)   -- BUTY
  elseif styl == 'ubranieM3' then
    SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)   -- PODKOSZULEK
    SetPedComponentVariation(GetPlayerPed(-1), 11, 271, 1, 2)  -- TOP
    SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)   -- RĘCE
    SetPedComponentVariation(GetPlayerPed(-1), 4, 78, 1, 2)   -- SPODNIE
    SetPedComponentVariation(GetPlayerPed(-1), 6, 22, 7, 2)   -- BUTY
  elseif styl == 'SzpitalM' then
    SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)   -- PODKOSZULEK
    SetPedComponentVariation(GetPlayerPed(-1), 11, 114, 0, 2)  -- TOP
    SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)   -- RĘCE
    SetPedComponentVariation(GetPlayerPed(-1), 4, 56, 0, 2)   -- SPODNIE
    SetPedComponentVariation(GetPlayerPed(-1), 6, 34, 0, 2)   -- BUTY
  elseif styl == 'SzpitalK' then
    SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)   -- PODKOSZULEK
    SetPedComponentVariation(GetPlayerPed(-1), 11, 105, 0, 2)  -- TOP
    SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)   -- RĘCE
    SetPedComponentVariation(GetPlayerPed(-1), 4, 57, 0, 2)   -- SPODNIE
    SetPedComponentVariation(GetPlayerPed(-1), 6, 35, 0, 2)   -- BUTY
  end
end












function OpenGymShopMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
			align    = 'center',
            title    = 'Siłownia - Sklep',
            elements = {
				{label = 'Shake Proteinowy <span style="color: green;">$6<span>', value = 'protein_shake'},
				{label = 'Woda <span style="color: green;">$1<span>', value = 'water'},
				{label = 'Luch Sportowy <span style="color: green;">$2<span>', value = 'sportlunch'},
				{label = 'Powerade <span style="color: green;">$4<span>', value = 'powerade'},
            }
        },
        function(data, menu)
            if data.current.value == 'protein_shake' then
				TriggerServerEvent('esx_gym:buyProteinshake')
            elseif data.current.value == 'water' then
				TriggerServerEvent('esx_gym:buyWater')
            elseif data.current.value == 'sportlunch' then
				TriggerServerEvent('esx_gym:buySportlunch')
            elseif data.current.value == 'powerade' then
				TriggerServerEvent('esx_gym:buyPowerade')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymShipMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_ship_menu',
        {
			align    = 'center',
            title    = 'Siłownia - Członkostwo',
            elements = {
				{label = 'Karnet <span style="color: green;">$1200<span>', value = 'membership'}
				--{lable = 'Karnet Policyjny', value = 'membershippolice'}
            }
        },
        function(data, menu)
            if data.current.value == 'membership' then
				TriggerServerEvent('esx_gym:buyMembership')
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenPoliceMenu()
    ESX.UI.Menu.CloseAll()
	if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice') then
	TriggerEvent('esx:showAdvancedNotification', 'System', cfgme.empty, '~g~Otworzyłeś szafkę policyjną.', cfgme.icon, 7)
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'policemembership',
        {
			align    = 'center',
            title    = 'Siłownia - Opcje Policyjne',
            elements = {
				{label = 'Karnet', value = 'membershippolice'},
				{label = 'Przedmioty', value = 'policeshop'}
            }
        },
        function(data, menu)
			if data.current.value == 'membershippolice' then
				TriggerServerEvent('esx_gym:getpolicemembership')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'policeshop' then
				OpenPoliceShop()
            end
        end,
        function(data, menu)
            menu.close()
        end
	)
end
end


function OpenPoliceShop()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'policeshop',
        {
			align    = 'center',
            title    = 'Siłownia - Sklep',
            elements = {
				{label = 'Wyciągnij Shake Proteinowy', value = 'protein_shake'},
				{label = 'Wyciągnij Wode', value = 'water'},
				{label = 'Wyciągnij Luch Sportowy', value = 'sportlunch'},
				{label = "Wyciągnij Redbul'a", value = 'redbull'},
            }
        },
        function(data, menu)
            if data.current.value == 'protein_shake' then
				TriggerServerEvent('esx_gym:Shakepolice')
            elseif data.current.value == 'water' then
				TriggerServerEvent('esx_gym:Waterpolice')
            elseif data.current.value == 'sportlunch' then
				TriggerServerEvent('esx_gym:Lunchpolice')
            elseif data.current.value == 'redbull' then
				TriggerServerEvent('esx_gym:Redbullpolice')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end
