ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	if ESX.PlayerData and ESX.PlayerData.inventory then
		Citizen.CreateThread(function()
			Citizen.Wait(100)
			ESX.PlayerData = ESX.GetPlayerData()

			local found = false
			for i = 1, #ESX.PlayerData.inventory, 1 do
				if ESX.PlayerData.inventory[i].name == item.name then
					ESX.PlayerData.inventory[i] = item
					found = true
					break
				end
			end

			if not found then
				ESX.TriggerServerCallback('esx:isValidItem', function(status)
					if status then
						table.insert(ESX.PlayerData.inventory, item)
					end
				end, item.name)
			end
		end)
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	if ESX.PlayerData and ESX.PlayerData.inventory then
		Citizen.CreateThread(function()
			Citizen.Wait(100)
			ESX.PlayerData = ESX.GetPlayerData()

			local found = false
			for i = 1, #ESX.PlayerData.inventory, 1 do
				if ESX.PlayerData.inventory[i].name == item.name then
					ESX.PlayerData.inventory[i] = item
					found = true
					break
				end
			end

			if not found then
				ESX.TriggerServerCallback('esx:isValidItem', function(status)
					if status then
						table.insert(ESX.PlayerData.inventory, item)
					end
				end, item.name)
			end
		end)
	end
end)

local Status = {}
local loaded = false
local isPaused = false

local display = true
local displayRadio = false
local displayGPS = false

local radio = {
	status = nil,
	channel = nil,
	mode = 0
}

function GetStatusData()
	local statuses = {}
	for _, status in ipairs(Status) do
		table.insert(statuses, {
			name	= status.name,
			val		= status.val,
			percent	= (status.val / Config.StatusMax) * 100
		})
	end

	return statuses
end

RegisterNetEvent('esx_status:load')
AddEventHandler('esx_status:load', function(statuses)
	for _, status in ipairs(Status) do
		for _, _status in ipairs(statuses) do
			if status.name == _status.name then
				status.set(_status.val)
			end
		end
	end

	loaded = true
end)

RegisterNetEvent('esx_status:set')
AddEventHandler('esx_status:set', function(name, val)
	for _, status in ipairs(Status) do
		if status.name == name then
			status.set(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData())
end)

RegisterNetEvent('esx_status:add')
AddEventHandler('esx_status:add', function(name, val)
	for _, status in ipairs(Status) do
		if status.name == name then
			status.add(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData())
end)

RegisterNetEvent('esx_status:remove')
AddEventHandler('esx_status:remove', function(name, val)
	for _, status in ipairs(Status) do
		if status.name == name then
			status.remove(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData())
end)

RegisterNetEvent('esx_status:updateColor')
AddEventHandler('esx_status:updateColor', function(name, color)
	for _, status in ipairs(Status) do
		if status.name == name then
			status.updateColor(color)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData())
end)

AddEventHandler('esx_status:registerStatus', function(name, default, color, visible, tickCallback)
	local s = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, s)
end)

AddEventHandler('esx_status:getStatus', function(name, cb)
	for _, status in ipairs(Status) do
		if status.name == name then
			cb(status)
			return
		end
	end
end)

AddEventHandler('esx_status:setDisplay', function(val)
	display = tonumber(val) ~= 0
end)

function drwRct(x, y, width, height, r, g, b, a)
	DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end

function drwTxt(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

Citizen.CreateThread(function()
	TriggerEvent('esx_status:loaded')

    RequestStreamedTextureDict('mpleaderboard')
    while not HasStreamedTextureDictLoaded('mpleaderboard') do
        Citizen.Wait(0)
    end

	local updateTimer, tickTimer
	while true do
		Citizen.Wait(0)
		if IsPauseMenuActive() then
			if not isPaused then
				isPaused = true
				TriggerEvent('esx_status:setDisplay', 0.0)
			end
		elseif isPaused then
			isPaused = false
			TriggerEvent('esx_status:setDisplay', 0.5)
		end

		if display then
			local baseX = 0.015
			drwRct(0.015, 0.985, 0.0698, 0.0125, 0, 0, 0, 120)

			local statuses = {}
			for _, status in ipairs(Status) do
				if status.visible or status.val > 0 then
					table.insert(statuses, {
						color	= status.color,
						percent	= (status.val / Config.StatusMax)
					})
				end
			end

			local count = #statuses
			for i, status in ipairs(statuses) do
				local offset = 0.0015
				if i == count then
					offset = 0.0
				end

				local width = 0.0698 / count - offset
				drwRct(baseX, 0.985, (width * status.percent), 0.01, status.color[1], status.color[2], status.color[3], 60)
				baseX = baseX + width + offset
			end

			local screenX = 0.975
			if displayGPS then
				DrawSprite('mpleaderboard', 'leaderboard_globe_icon', screenX, 0.98, 0.015, 0.0275, 0.0, 0, 255, 0, 255)
				screenX = screenX - 0.015
			end

			if displayRadio then
				DrawSprite('mpleaderboard', 'leaderboard_audio_2', screenX, 0.98, 0.015, 0.0275, 0.0, 0, 255, 0, 255)
				if radio.status ~= nil then
					local t, c = "", {255, 255, 255}
					if not radio.status then
						t = "/radio"
						c = {255, 0, 0}
					elseif radio.channel then
						t = radio.channel
						if radio.cid < 12 then
							drwTxt(1.45, 1.467, 1.0, 1.0, 0.2, (radio.mode == 0 and "T" or (radio.mode == 3 and "S" or "C")), 255, 0, 0, 255)
						end
					else
						t = "Disabled"
						c = {252, 252, 0}
					end

					drwTxt(1.418, 1.465, 1.0, 1.0, 0.25, t, c[1], c[2], c[3], 255)
				end
			end
		end

		if loaded then
			local timer = GetGameTimer()
			if not tickTimer or tickTimer < timer then
				for _, status in ipairs(Status) do
					status.onTick()
				end

				tickTimer = timer + Config.TickTime
			end

			if not updateTimer or updateTimer < timer then
				TriggerServerEvent('esx_status:update', GetStatusData())
				updateTimer = timer + Config.UpdateInterval
			end
		end
	end
end)
