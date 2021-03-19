local diceDisplaying = {}
local displayTime = 8000


CreateThread(function()	
	while true do
		Citizen.Wait(1000)
        local res = GetIsWidescreen()
        if not res and not IsWide then
            ESX.TriggerServerCallback('AriviRP:checkBypass', function(bypass)
                if not bypass then
                    startTimer()
                    IsWide = true
                end
            end)
        elseif res and IsWide then
            IsWide = false
        end
	end
end)

Citizen.CreateThread(function()
    local alreadyDead = false

    while true do
        Citizen.Wait(50)
        local playerPed = GetPlayerPed(-1)
        if IsEntityDead(playerPed) and not alreadyDead then
            local playerName = GetPlayerName(PlayerId())
            killer = GetPedKiller(playerPed)
            killername = false

            for id = 0, 64 do
                if killer == GetPlayerPed(id) then
                    killername = GetPlayerName(id)
                end
            end

            local death = GetPedCauseOfDeath(playerPed)

            if checkArray (Melee, death) then
                TriggerServerEvent('playerDied', killername .. " meleed " .. playerName)
            elseif checkArray (Bullet, death) then
                TriggerServerEvent('playerDied', killername .. " shot " .. playerName)
            elseif checkArray (Knife, death) then
                TriggerServerEvent('playerDied', killername .. " stabbed " .. playerName)
            elseif checkArray (Car, death) then
                TriggerServerEvent('playerDied', killername .. " hit " .. playerName)
            elseif checkArray (Animal, death) then
                TriggerServerEvent('playerDied', playerName .. " died by an animal")
            elseif checkArray (FallDamage, death) then
                TriggerServerEvent('playerDied', playerName .. " died of fall damage")
            elseif checkArray (Explosion, death) then
                TriggerServerEvent('playerDied', playerName .. " died of an explosion")
            elseif checkArray (Gas, death) then
                TriggerServerEvent('playerDied', playerName .. " died of gas")
            elseif checkArray (Burn, death) then
                TriggerServerEvent('playerDied', playerName .. " burned to death")
            elseif checkArray (Drown, death) then
                TriggerServerEvent('playerDied', playerName .. " drowned")
            else
                data.victim = source
                TriggerServerEvent('playerDied', playerName .. " Zabity przez: ".. GetPlayerName(data.killerServerId) .. ' from ' .. data.distance .. ' units')
                --print(death)
            end

            alreadyDead = true
        end

        if not IsEntityDead(playerPed) then
            alreadyDead = false
        end
    end
end)



Citizen.CreateThread(function()
    local strin = ""

	while true do
		local currentTime, html = GetGameTimer(), ""
		for k, v in pairs(diceDisplaying) do
            
			local player = GetPlayerFromServerId(k)
			if NetworkIsPlayerActive(player) then
			    local sourcePed, targetPed = GetPlayerPed(player), PlayerPedId()
        	    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
        	    local pedCoords = GetPedBoneCoords(sourcePed, 0x2e28, 0.0, 0.0, 0.0)
    
                if player == source or #(sourceCoords - targetCoords) < 10 then
                    local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(pedCoords.x, pedCoords.y, pedCoords.z + 1.2)
                    if not onScreen then
                        if v.type == "dices" then
                            if #v.num > 1 then
                                if #v.num == 2 then
                                    html = html .. "<span style=\"position: absolute; padding-left: 150px; left: ".. xxx * 72 .."%;top: ".. yyy * 100 .."%;\">"
                                elseif #v.num == 3 then
                                    html = html .. "<span style=\"position: absolute; padding-left: 150px; left: ".. xxx * 66 .."%;top: ".. yyy * 100 .."%;\">"
                                end
                                for a, b in pairs(v.num) do
                                    html = html .. "<img \" width=\"75px\" height=\"75px\" src=\"dice_".. b.dicenum ..".png\">"
                                end
                            else
                                html = html .. "<span style=\"position: absolute; left: ".. xxx * 94 .."%;top: ".. yyy * 100 .."%;\">"
                                html = html .. "<img \" width=\"75px\" height=\"75px\" src=\"dice_".. v.num[1].dicenum ..".png\">"    
                            end
                            html = html .. "</img></span>"
                        elseif v.type == "rps" then
                            html = html .. "<span style=\"position: absolute; left: ".. xxx * 94 .."%;top: ".. yyy * 100 .."%;\">"
                            html = html .. "<img \" width=\"75px\" height=\"75px\" src=\"option_".. v.num ..".png\">"    
                            html = html .. "</img></span>"
                        end
                    end
                end
        	end
        	if v.time <= currentTime then
        		diceDisplaying[k] = nil
        	end
        end

        if strin ~= html then
            SendNUIMessage({
                type = true,
                html = html
            })
            strin = html
        end
        
		Wait(0)
    end
end)

RegisterNetEvent("bb-dices:ToggleDisplay")
AddEventHandler("bb-dices:ToggleDisplay", function(playerId, number, typ)
	diceDisplaying[tonumber(playerId)] = {num = number, time = GetGameTimer() + displayTime, type = typ}
end)

RegisterNetEvent("bb-dices:ToggleDiceAnim")
AddEventHandler("bb-dices:ToggleDiceAnim", function()
    loadAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1500)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'dice', 0.3)
    Citizen.Wait(1500)
    ClearPedTasks(GetPlayerPed(-1))
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end