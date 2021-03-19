ESX                    = nil
local RegisteredStatus = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  	return
	end

	local players = ESX.GetPlayers()

	for _,playerId in ipairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			local data = {}

			if result[1].status then
				data = json.decode(result[1].status)
			end

			xPlayer.set('status', data)
			TriggerClientEvent('esx_status:load', playerId, data)
		end)
	end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local data = {}

		if result[1].status then
			data = json.decode(result[1].status)
		end

		xPlayer.set('status', data)
		TriggerClientEvent('esx_status:load', playerId, data)
	end)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local status = xPlayer.get('status')

	MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
		['@status']     = json.encode(status),
		['@identifier'] = xPlayer.identifier
	})
end)

AddEventHandler('esx_status:getStatus', function(playerId, statusName, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local status  = xPlayer.get('status')

	for i=1, #status, 1 do
		if status[i].name == statusName then
			cb(status[i])
			break
		end
	end

end)

RegisterServerEvent('esx_status:update')
AddEventHandler('esx_status:update', function(status)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.set('status', status)
	end
end)

Citizen.CreateThread(function()
	while(true) do
		Citizen.Wait(10 * 60 * 1000)
		
		SaveData()

	end

end)

function SaveData()
	local xPlayers = ESX.GetPlayers()

	local updateStatement = 'UPDATE users SET status = (case %s end) where identifier in (%s)'
	local whenList = ''
	local whereList = ''
	local firstItem = true
	local playerCount = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		local status  = xPlayer.get('status')

		whenList = whenList .. string.format('when identifier = \'%s\' then \'%s\' ', xPlayer.identifier, json.encode(status))

		if firstItem == false then
			whereList = whereList .. ', '
		end
		whereList = whereList .. string.format('\'%s\'', xPlayer.identifier)

		firstItem = false
		playerCount = playerCount + 1
	end

	if playerCount > 0 then
		local sql = string.format(updateStatement, whenList, whereList)

		MySQL.Async.execute(sql)

	end

end