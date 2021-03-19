
ESX = nil
local PlayerData = {}

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

local blip2		= nil
local blip3		= nil
local blip4		= nil
local blip5		= nil
local blip6		= nil
local blip7		= nil
local blip8		= nil
local blip9		= nil

local pracuje = false
local Blipy = {}
local kurwaspierdalaj = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        local player = GetPlayerPed(-1)
        if PlayerData.job ~= nil and PlayerData.job.name == 'deliverer' then
            local coords, sleep = GetEntityCoords(player, true), true
            if GetDistanceBetweenCoords(coords, Config.dostawastart.x, Config.dostawastart.y, Config.dostawastart.z, true) < 10 then
                DrawMarker(1, Config.dostawastart.x, Config.dostawastart.y,Config.dostawastart.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                sleep = false
            end
            if GetDistanceBetweenCoords(coords, Config.dostawastart.x, Config.dostawastart.y, Config.dostawastart.z, true) < 1.5 then
                HelpText("Naciśnij ~INPUT_CONTEXT~, aby otworzyć przebieralnię")
                if IsControlJustReleased(1, 51) then
                    MenuPrzebieralnia()
                end
            end

            if sleep then
                Wait(500)
            end
        else
            Citizen.Wait(2000)
        end
    end
end)

local blips = {
     {title="Amazon", id=363, x = 801.56, y = -2975.12, z = 15.9},
}

CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

function StworzBlipa()

	if PlayerData.job ~= nil and PlayerData.job.name == "deliverer" and pracuje then

        blip2 = AddBlipForCoord(Config.zbieraniepaczek4.x, Config.zbieraniepaczek4.y, Config.zbieraniepaczek4.z)
        SetBlipSprite(blip2, 477)
        SetBlipColour(blip2, 61)
        SetBlipAsShortRange(blip2, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Zbieranie paczek")
        EndTextCommandSetBlipName(blip2)	
        
    blip3 = AddBlipForCoord(Config.garazwyciagnij.x, Config.garazwyciagnij.y, Config.garazwyciagnij.z)
        SetBlipSprite(blip3, 85)
        SetBlipColour(blip3, 26)
        SetBlipAsShortRange(blip3, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Wyciągniecie pojazdu")
        EndTextCommandSetBlipName(blip3)	
     blip3 = AddBlipForCoord(Config.podajkwit.x, Config.podajkwit.y, Config.podajkwit.z)
        SetBlipSprite(blip3, 85)
        SetBlipColour(blip3, 26)
        SetBlipAsShortRange(blip3, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Oddaj kwit z pracy")
        EndTextCommandSetBlipName(blip3)		
    else
        

        if blip2 ~= nil then
            RemoveBlip(blip2)
            blip2 = nil
        end

        if blip3 ~= nil then
            RemoveBlip(blip3)
            blip3 = nil
        end

        if blip3 ~= nil then
            RemoveBlip(blip3)
            blip3 = nil
        end
    end
end

Citizen.CreateThread(function()
    while true do
  Wait(1)
  local coords  = GetEntityCoords(PlayerPedId())
		if PlayerData.job ~= nil and PlayerData.job.name == 'deliverer'  then
			if (GetDistanceBetweenCoords(coords, 827.94, -2954.21, 5.9, true) < 5) then
			DrawMarker(1, 827.94, -2954.21, 5.9-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
				if(GetDistanceBetweenCoords(coords, 827.94, -2954.21, 5.9, true) < 1.5) then
					if IsControlJustReleased(0, Keys['E']) then
						if pracuje == true then
							if IsPedInAnyVehicle(PlayerPedId(),  false) then
								local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
								local hash      = GetEntityModel(vehicle)
								if DoesEntityExist(vehicle) then
									if hash == GetHashKey('amazon1') then
										ESX.ShowNotification('Oddano auta do garażu')
										DeleteVehicle(vehicle)
										kurwaspierdalaj = true
									else
										ESX.ShowNotification('Zły pojazd!')
									end	
								end
							else
								local veh = "amazon1"
								local x,y,z = GetEntityCoords(PlayerPedId())
								vehiclehash = GetHashKey(veh)
								RequestModel(vehiclehash)
								local spawned = CreateVehicle(vehiclehash, 827.94, -2954.21, 5.9, 183.71, 1, 0)
								SetPedIntoVehicle(PlayerPedId(), spawned, -1)
								local liczba = math.random(1000,9999)
								SetVehicleNumberPlateText(spawned,'POP'.. liczba)
								ESX.ShowNotification('Pobrano auto z garażu')
							end
						else
							ESX.ShowNotification('Musisz się przebrać!')
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function() 

    while true do
        Citizen.Wait(5)

        local ped = PlayerPedId()
        local koordy = GetEntityCoords(ped)
		local vehped = GetVehiclePedIsIn(ped, false)

        if pracuje then 

            if PlayerData.job ~= nil and PlayerData.job.name == 'deliverer' and not IsEntityDead( ped ) then
                if GetDistanceBetweenCoords(koordy, Config.zbieraniepaczek4.x, Config.zbieraniepaczek4.y, Config.zbieraniepaczek4.z, true ) < 50 then
                    DrawMarker(1, Config.zbieraniepaczek4.x, Config.zbieraniepaczek4.y,Config.zbieraniepaczek4.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(koordy, Config.zbieraniepaczek4.x, Config.zbieraniepaczek4.y, Config.zbieraniepaczek4.z, true ) < 1.5 then
                        HelpText("Naciśnij ~INPUT_CONTEXT~ aby zbierac paczki.")
                            if IsControlJustReleased(1, 51) then
								if IsPedInAnyVehicle(ped, true) then
									HelpText("Nie mozesz zbierac paczek z samochodu")
								else
									Citizen.Wait(100)
                                    TriggerServerEvent("amazon:zbierzpaczki")
                                    blokada = true
                                    blokada_przycisk()
                                    Citizen.Wait(100000)
                                    blokada = false
									
									Blipy['cel'] = AddBlipForCoord(Config.dostawapaczek1.x, Config.dostawapaczek1.y, Config.dostawapaczek1.z)
									SetBlipRoute(Blipy['cel'], true)
									BeginTextCommandSetBlipName("STRING")
									AddTextComponentString('Odbiorca Paczki')
									EndTextCommandSetBlipName(Blipy['cel'])
								end
							end
                    end
                end
            end
        end
    end
end)

local zbieraluj = false

RegisterNetEvent('amazon:oddawaniemoczu')
AddEventHandler('amazon:oddawaniemoczu', function(takczychujwie)
    local ped = PlayerPedId()
    if takczychujwie == false then
        zbieraluj = false
        FreezeEntityPosition(ped, false)
    elseif takczychujwie == true then
        zbieraluj = true
        FreezeEntityPosition(ped, true)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local koordy = GetEntityCoords(ped)
        Citizen.Wait(5)
        if pracuje and zbieraluj == false then
            if PlayerData.job ~= nil and PlayerData.job.name == 'deliverer' and not IsEntityDead( ped ) then
                if GetDistanceBetweenCoords(koordy, Config.dostawapaczek1.x, Config.dostawapaczek1.y, Config.dostawapaczek1.z, true ) < 50 then
                    DrawMarker(1, Config.dostawapaczek1.x, Config.dostawapaczek1.y,Config.dostawapaczek1.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(koordy, Config.dostawapaczek1.x, Config.dostawapaczek1.y, Config.dostawapaczek1.z, true ) < 1.5 then
                        if IsControlJustPressed(0, Keys['E']) then
                            if not IsPedInAnyVehicle(ped, false) then
                                Citizen.Wait(100)
                                TriggerServerEvent('amazon:dostarczpaczki', "paczkapolice")   
                                RemoveBlip(Blipy['cel'])          
                                blokada = true
                                blokada_przycisk()
                                Citizen.Wait(15000) 
                                blokada = false         
                                Blipy['cel'] = AddBlipForCoord(Config.dostawapaczek2.x, Config.dostawapaczek2.y, Config.dostawapaczek2.z)
                                SetBlipRoute(Blipy['cel'], true)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString('Odbiorca Paczki')
                                EndTextCommandSetBlipName(Blipy['cel'])
                            end
                        end
                    end
                elseif GetDistanceBetweenCoords(koordy, Config.dostawapaczek2.x, Config.dostawapaczek2.y, Config.dostawapaczek2.z, true) < 50 then
                    DrawMarker(1, Config.dostawapaczek2.x, Config.dostawapaczek2.y,Config.dostawapaczek2.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(koordy, Config.dostawapaczek2.x, Config.dostawapaczek2.y, Config.dostawapaczek2.z, true) < 1.5 then
                        if IsControlJustPressed(0, Keys['E']) then
                            if not IsPedInAnyVehicle(ped, false) then
                                Citizen.Wait(100)
                                TriggerServerEvent('amazon:dostarczpaczki', "paczkaems")                 
                                RemoveBlip(Blipy['cel'])                                              
                                blokada = true
                                blokada_przycisk()
                                Citizen.Wait(15000)
                                blokada = false                                               
                                Blipy['cel'] = AddBlipForCoord(Config.dostawapaczek3.x, Config.dostawapaczek3.y, Config.dostawapaczek3.z)
                                SetBlipRoute(Blipy['cel'], true)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString('Odbiorca Paczki')
                                EndTextCommandSetBlipName(Blipy['cel'])
                            end
                        end
                    end
                elseif GetDistanceBetweenCoords(koordy, Config.dostawapaczek3.x, Config.dostawapaczek3.y, Config.dostawapaczek3.z, true) < 50 then
                    DrawMarker(1, Config.dostawapaczek3.x, Config.dostawapaczek3.y,Config.dostawapaczek3.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(koordy, Config.dostawapaczek3.x, Config.dostawapaczek3.y, Config.dostawapaczek3.z, true) < 1.5 then
                        if IsControlJustPressed(0, Keys['E']) then
                            if not IsPedInAnyVehicle(ped, false) then
                                Citizen.Wait(100)
                                TriggerServerEvent('amazon:dostarczpaczki', "paczkalsc")               
                                RemoveBlip(Blipy['cel'])         
                                blokada = true
                                blokada_przycisk()
                                Citizen.Wait(15000)
                                blokada = false           
                                Blipy['cel'] = AddBlipForCoord(Config.dostawapaczek4.x, Config.dostawapaczek4.y, Config.dostawapaczek4.z)
                                SetBlipRoute(Blipy['cel'], true)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString('Odbiorca Paczki')
                                EndTextCommandSetBlipName(Blipy['cel'])
                            end
                        end
                    end
                elseif GetDistanceBetweenCoords(koordy, Config.dostawapaczek4.x, Config.dostawapaczek4.y, Config.dostawapaczek4.z, true) < 50 then
                    DrawMarker(1, Config.dostawapaczek4.x, Config.dostawapaczek4.y,Config.dostawapaczek4.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(koordy, Config.dostawapaczek4.x, Config.dostawapaczek4.y, Config.dostawapaczek4.z, true) < 1.5 then
                            if IsControlJustPressed(0, Keys['E']) then
                                if not IsPedInAnyVehicle(ped, false) then
                                    Citizen.Wait(100)
                                    TriggerServerEvent('amazon:dostarczpaczki', "paczkacoffee")                                               
                                    RemoveBlip(Blipy['cel'])                                                
                                    blokada = true
                                    blokada_przycisk()
                                    Citizen.Wait(15000)
                                    blokada = false                                               
                                    Blipy['cel'] = AddBlipForCoord(Config.dostawapaczek5.x, Config.dostawapaczek5.y, Config.dostawapaczek5.z)
                                    SetBlipRoute(Blipy['cel'], true)
                                    BeginTextCommandSetBlipName("STRING")
                                    AddTextComponentString('Odbiorca Paczki')
                                    EndTextCommandSetBlipName(Blipy['cel'])
                                end
                            end
                        end
                elseif GetDistanceBetweenCoords(koordy, Config.dostawapaczek5.x, Config.dostawapaczek5.y, Config.dostawapaczek5.z, true) < 50 then
                    DrawMarker(1, Config.dostawapaczek5.x, Config.dostawapaczek5.y,Config.dostawapaczek5.z-0.75, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(koordy, Config.dostawapaczek5.x, Config.dostawapaczek5.y, Config.dostawapaczek5.z, true) < 1.5 then
                            if IsControlJustPressed(0, Keys['E']) then
                                if not IsPedInAnyVehicle(ped, false) then
                                    Citizen.Wait(100)
                                    TriggerServerEvent('amazon:dostarczpaczki', "paczkapacific")                                             
                                    RemoveBlip(Blipy['cel'])                                                
                                    blokada = true
                                    blokada_przycisk()
                                    Citizen.Wait(15000)
                                    blokada = false
                                    Blipy['cel'] = AddBlipForCoord(Config.dostawapaczek6.x, Config.dostawapaczek6.y, Config.dostawapaczek6.z)
                                    SetBlipRoute(Blipy['cel'], true)
                                    BeginTextCommandSetBlipName("STRING")
                                    AddTextComponentString('Odbiorca Paczki')
                                    EndTextCommandSetBlipName(Blipy['cel'])
                                end
                            end
                        end
                elseif GetDistanceBetweenCoords(koordy, Config.dostawapaczek6.x, Config.dostawapaczek6.y, Config.dostawapaczek6.z, true) < 50 then
                    DrawMarker(1, Config.dostawapaczek6.x, Config.dostawapaczek6.y,Config.dostawapaczek6.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(koordy, Config.dostawapaczek6.x, Config.dostawapaczek6.y, Config.dostawapaczek6.z, true) < 1.5 then
                            if IsControlJustPressed(0, Keys['E']) then
                                if not IsPedInAnyVehicle(ped, false) then
                                    Citizen.Wait(100)
                                    TriggerServerEvent('amazon:dostarczpaczki', "paczkahumane")                                                
                                    RemoveBlip(Blipy['cel'])                                               
                                    blokada = true
                                    blokada_przycisk()
                                    Citizen.Wait(15000)
                                    blokada = false
                                    Blipy['cel'] = AddBlipForCoord(Config.dostawapaczek7.x, Config.dostawapaczek7.y, Config.dostawapaczek7.z)
                                    SetBlipRoute(Blipy['cel'], true)
                                    BeginTextCommandSetBlipName("STRING")
                                    AddTextComponentString('Odbiorca Paczki')
                                    EndTextCommandSetBlipName(Blipy['cel'])
                                end
                            end
                        end
                elseif GetDistanceBetweenCoords(koordy, Config.dostawapaczek7.x, Config.dostawapaczek7.y, Config.dostawapaczek7.z, true) < 50 then
                    DrawMarker(1, Config.dostawapaczek7.x, Config.dostawapaczek7.y,Config.dostawapaczek7.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(koordy, Config.dostawapaczek7.x, Config.dostawapaczek7.y, Config.dostawapaczek7.z, true) < 1.5 then
                            if IsControlJustPressed(0, Keys['E']) then
                                if not IsPedInAnyVehicle(ped, false) then
                                    Citizen.Wait(100)
                                    TriggerServerEvent('amazon:dostarczpaczki', "paczkadoj")                                                
                                    RemoveBlip(Blipy['cel'])                                               
                                    blokada = true
                                    blokada_przycisk()
                                    Citizen.Wait(15000)
                                    blokada = false                                            
                                    Blipy['cel'] = AddBlipForCoord(Config.podajkwit.x, Config.podajkwit.y, Config.podajkwit.z)
                                    SetBlipRoute(Blipy['cel'], true)
                                    BeginTextCommandSetBlipName("STRING")
                                    AddTextComponentString('Odbiorca Paczki')
                                    EndTextCommandSetBlipName(Blipy['cel'])
                                end
                            end
                        end
                    end
                end
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local koordy = GetEntityCoords(ped, true)

    if kurwaspierdalaj then
        if PlayerData.job ~= nil and PlayerData.job.name == 'deliverer' and not IsEntityDead(ped) then
            if GetDistanceBetweenCoords(koordy, Config.podajkwit.x, Config.podajkwit.y, Config.podajkwit.z, true) < 10 and pracuje == true then
                DrawMarker(1, Config.podajkwit.x, Config.podajkwit.y,Config.podajkwit.z-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 216, 12, 239, 155, 0, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(koordy, Config.podajkwit.x, Config.podajkwit.y, Config.podajkwit.z, true) < 1.5 then
                    HelpText("Naciśnij ~INPUT_CONTEXT~, aby podac kwit szefowi")
                    if IsControlJustReleased(1, 51) then					
						RemoveBlip(Blipy['cel'])					
                        Citizen.Wait(200)
                        TriggerServerEvent('amazon:nosiemanko')
                        blokada = true
                        blokada_przycisk()
                        Citizen.Wait(5000)
                        blokada = false		
                        kurwaspierdalaj = false
                    end
                end
            end
        else
            Citizen.Wait(500)
        end
    end

   end

end)
RegisterNetEvent('amazon:paykurier')
AddEventHandler('amazon:paykurier', function(kurwalevel)
    TriggerServerEvent('amazon:podajkwit', kurwalevel)
end)

RegisterNetEvent('amazon:dostarczanie')
AddEventHandler('amazon:dostarczanie', function()
    Dostarczanie()
end)

RegisterNetEvent('amazon:zaduzo')
AddEventHandler('amazon:zaduzo', function()
    HelpText("Posiadasz maksymalną ilosc paczek")
end)

RegisterNetEvent('amazon:zamalo')
AddEventHandler('amazon:zamalo', function()
    HelpText("Nie masz wystarczajaco paczek")
    
end)

RegisterNetEvent('amazon:niemakwitu')
AddEventHandler('amazon:niemakwitu', function()
    HelpText("Nie masz kwitu")
end)

function Dostarczanie() 
    local ped = PlayerPedId()

    Citizen.CreateThread(function()
        RequestAnimDict("amb@prop_human_bum_bin@idle_a")
        Citizen.Wait(100)
        TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 40, 0, 0, 0, 0)
        Citizen.Wait(7000)
        TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 40, 0, 0, 0, 0)
    end)
end

function HelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

function blokada_przycisk()
	Citizen.CreateThread(function()
		while blokada do
			Citizen.Wait(1)
			DisableControlAction(0, 73, true) 				-- x
			DisableControlAction(0, 105, true) 				-- x
			DisableControlAction(0, 120, true) 				-- x
			DisableControlAction(0, 154, true) 				-- x
			DisableControlAction(0, 186, true) 				-- x
            DisableControlAction(0, 252, true) 				-- x
            DisableControlAction(0, 323, true) 				-- x
            DisableControlAction(0, 337, true) 				-- x
            DisableControlAction(0, 354, true) 				-- x
            DisableControlAction(0, 357, true) 				-- x
            DisableControlAction(0, 20, true) 				-- z
            DisableControlAction(0, 48, true) 				-- z
            DisableControlAction(0, 32, true) 				-- w
            DisableControlAction(0, 33, true) 				-- s
            DisableControlAction(0, 34, true) 				-- a
            DisableControlAction(0, 35, true) 				-- d
		end
	end)
end

local Clothes = {
    Male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 242,   ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 78,   ['pants_2'] = 2,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,      ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['bproof_1'] = 0,     ['bproof_2'] = 0,
        ['mask_1'] = 0,      ['mask_2'] = 0,
        ['ears_1'] = 5,     ['ears_2'] = 5,
        ['bags_1'] = 0,     ['bags_2'] = 0
    },
    Female = {
        ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
        ['torso_1'] = 249,   ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 14,
        ['pants_1'] = 80,   ['pants_2'] = 2,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = 0,  ['helmet_2'] = 0,
        ['mask_1'] = 0,      ['mask_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 11,     ['ears_2'] = 0
    }
}

function MenuPrzebieralnia()
    ESX.UI.Menu.CloseAll()
 
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'cloakroom',
      {
        title    = 'Szatnia kuriera',
        align    = 'center',
        elements = {
          {label = 'Rozpocznij prace', value = 'job_wear'},
          {label = 'Zakoncz prace', value = 'citizen_wear'}
        }
      },
      function(data, menu)
        local ped = PlayerPedId()
        if data.current.value == 'citizen_wear' then 
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                    GetPedData()
                    reloadskin()
                    TriggerEvent('esx_tattooshop:refreshTattoos')
              end)
            RequestAnimDict("move_m@_idles@shake_off")
            Citizen.Wait(100)
            TaskPlayAnim((ped), 'move_m@_idles@shake_off', 'shakeoff_1', 8.0, 8.0, -1, 40, 0, 0, 0, 0)
              blokada = true
              blokada_przycisk()
              Wait(3000)
              ClearPedTasks(GetPlayerPed(-1))
              blokada = false
          pracuje = false
          StworzBlipa()
 
          ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
              TriggerEvent('skinchanger:loadSkin', skin)
          end)
        end
        if data.current.value == 'job_wear' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, Clothes.Male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, Clothes.Female)
                end
            end)
              RequestAnimDict("move_m@_idles@shake_off")
              Citizen.Wait(100)
              TaskPlayAnim((ped), 'move_m@_idles@shake_off', 'shakeoff_1', 8.0, 8.0, -1, 40, 0, 0, 0, 0)
              blokada = true
              blokada_przycisk()
              Wait(3000)
              ClearPedTasks(GetPlayerPed(-1))
              blokada = false
          pracuje = true
          StworzBlipa()
        end
        menu.close()
      end,
      function(data, menu)
        menu.close()
      end
    )
end


function reloadskin()
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    TriggerEvent('esx_tattooshop:refreshTattoos')
end

function GetPedData()
	return Ped
end