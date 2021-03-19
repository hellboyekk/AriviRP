ESX = nil
local PlayersTransforming, PlayersTransforming2, PlayersSelling, PlayersHarvesting = {}, {}, {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'piekarz', Config.MaxInService)
end
TriggerEvent('esx_society:registerSociety', 'piekarz', 'Piekarz', 'society_piekarz', 'society_piekarz', 'society_piekarz', {type = 'private'})


local function Harvest(source)
SetTimeout(Config.Czasmaterial, function()

	if PlayersHarvesting[source] == true then

		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)

		local Quantity = xPlayer.getInventoryItem('zboze').count

		if Quantity >= 20 then
			TriggerClientEvent('esx:showNotification', _source, '~r~Nie możesz więcej unieść')
			PlayersHarvesting[_source] = false
			TriggerClientEvent(FreezeEntityPosition(source, false))
			SetTimeout(5000)
			return
		else
			xPlayer.addInventoryItem('zboze', 1)
			Harvest(_source)
		end

	end
end)
end

RegisterServerEvent('esx_piekarz:startHarvest')
AddEventHandler('esx_piekarz:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent(FreezeEntityPosition(source, false))
		PlayersHarvesting[_source]=false
		SetTimeout(5000)
		return
	else
		PlayersHarvesting[_source]=true
		Harvest(_source,zone)
	end
end)

RegisterServerEvent('esx_piekarz:stopHarvest')
AddEventHandler('esx_piekarz:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
	end
end)

local function Transform(source)--zboze na make

	SetTimeout(Config.Czasszycie, function()

		if PlayersTransforming[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem('zboze').count
			local Quantity2 = xPlayer.getInventoryItem('maka').count

			if Quantity <= 0 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz zboza')
				PlayersTransforming[source] = false
				TriggerClientEvent(FreezeEntityPosition(source, false))
				return
			else
			if Quantity2 >= 20 then
							TriggerClientEvent('esx:showNotification', source, '~r~Nie możesz więcej unieść')
							return
						else
			xPlayer.removeInventoryItem('zboze', 1)
			xPlayer.addInventoryItem('maka', 1)
			Transform(source)	 
				end
			end
		end
	end)
end

RegisterServerEvent('esx_piekarz:startTransform')
AddEventHandler('esx_piekarz:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		PlayersTransforming[_source]=false
		TriggerClientEvent(FreezeEntityPosition(source, false))
		SetTimeout(5000)
	else
		PlayersTransforming[_source]=true
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_piekarz:stopTransform')
AddEventHandler('esx_piekarz:stopTransform', function()
	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false		
	else
	   PlayersTransforming[_source]=true
	end
end)

local function Transform2(source)--maka na chleb

	SetTimeout(Config.Czasszycie, function()

		if PlayersTransforming2[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem('maka').count
			local Quantity2 = xPlayer.getInventoryItem('chleb').count


			if Quantity <= 0 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz maki')
				PlayersTransforming2[source] = false
				TriggerClientEvent(FreezeEntityPosition(source, false))
				return
			else
			if Quantity2 >= 20 then
							TriggerClientEvent('esx:showNotification', source, '~r~Nie możesz więcej unieść')
							return
						else
			xPlayer.removeInventoryItem('maka', 1)
			xPlayer.addInventoryItem('chleb', 1)
			Transform2(source)	 
				end
			end
		end
	end)
end

RegisterServerEvent('esx_piekarz:startTransform2')
AddEventHandler('esx_piekarz:startTransform2', function(zone)
	local _source = source
  	
	if PlayersTransforming2[_source] == false then
		PlayersTransforming2[_source]=false
		TriggerClientEvent(FreezeEntityPosition(source, false))
		SetTimeout(5000)
	else
		PlayersTransforming2[_source]=true
		Transform2(_source,zone)
	end
end)

RegisterServerEvent('esx_piekarz:stopTransform2')
AddEventHandler('esx_piekarz:stopTransform2', function()
	local _source = source
	
	if PlayersTransforming2[_source] == true then
		PlayersTransforming2[_source]=false		
	else
	   PlayersTransforming2[_source]=true
	end
end)

local function Sell(source)--SELL

	SetTimeout(Config.Czasszycie, function()

		if PlayersSelling[source] == true then

			local wyp1 = Config.Wyplata1
			local wyp2 = Config.Wyplata2
			local wypsuma = math.random(wyp1,wyp2)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem('chleb').count


			if Quantity <= 19 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz chleba do sprzedania')
				PlayersSelling[source] = false
				TriggerClientEvent(FreezeEntityPosition(source, false))
				return
			else
			TriggerClientEvent('esx:showNotification', _source, '~r~Sprzedawanie chleba')
			xPlayer.removeInventoryItem('chleb', 20)
			xPlayer.addMoney(wypsuma)
			Sell(source)	 
				end
			end
	end)
end

RegisterServerEvent('esx_piekarz:startSell')
AddEventHandler('esx_piekarz:startSell', function(zone)
	local _source = source

	if PlayersSelling[_source] == false then
		PlayersSelling[_source]=false
		TriggerClientEvent(FreezeEntityPosition(source, false))
	else
		PlayersSelling[_source]=true
		Sell(_source,zone)
	end
end)

RegisterServerEvent('esx_piekarz:stopSell')
AddEventHandler('esx_piekarz:stopSell', function()
	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		
	else
		PlayersSelling[_source]=true
	end
end)

RegisterServerEvent('esx_piekarz:getStockItem')
AddEventHandler('esx_piekarz:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_psm', function(inventory)
		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end

		xPlayer.showNotification('Włożyłeś x' .. count .. ' ' .. item.label)
	end)
end)

ESX.RegisterServerCallback('esx_piekarz:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_psm', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_piekarz:putStockItems')
AddEventHandler('esx_piekarz:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_psm', function(inventory)
		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end

		xPlayer.showNotification('Wyciągłeś x' .. count .. ' ' .. item.label)
	end)
end)

ESX.RegisterServerCallback('esx_piekarz:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})
end)