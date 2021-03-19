ESX = nil
local PlayersTransforming, PlayersTransforming2, PlayersSelling, PlayersHarvesting = {}, {}, {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'psm', Config.MaxInService)
end
TriggerEvent('esx_society:registerSociety', 'psm', '4PSM', 'society_psm', 'society_psm', 'society_psm', {type = 'private'})


local function Harvest(source)
SetTimeout(Config.Czasmaterial, function()

	if PlayersHarvesting[source] == true then

		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)

		local Quantity = xPlayer.getInventoryItem('4psm_material').count

		if Quantity >= 20 then
			TriggerClientEvent('esx:showNotification', _source, '~r~Nie możesz więcej unieść')
			PlayersHarvesting[_source] = false
			TriggerClientEvent(FreezeEntityPosition(source, false))
			SetTimeout(5000)
			return
		else
			xPlayer.addInventoryItem('4psm_material', 1)
			Harvest(_source)
		end

	end
end)
end

RegisterServerEvent('esx_psm:startHarvest')
AddEventHandler('esx_psm:startHarvest', function(zone)
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

RegisterServerEvent('esx_psm:stopHarvest')
AddEventHandler('esx_psm:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
	end
end)

local function Transform(source)--Szycie ubran | materialy > ubrania

	SetTimeout(Config.Czasszycie, function()

		if PlayersTransforming[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem('4psm_material').count
			local Quantity2 = xPlayer.getInventoryItem('4psm_ubrania').count


			if Quantity <= 0 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz materiałów')
				PlayersTransforming[source] = false
				TriggerClientEvent(FreezeEntityPosition(source, false))
				return
			else
			if Quantity2 >= 20 then
							TriggerClientEvent('esx:showNotification', source, '~r~Nie możesz więcej unieść')
							return
						else
			xPlayer.removeInventoryItem('4psm_material', 1)
			xPlayer.addInventoryItem('4psm_ubrania', 1)
			Transform(source)	 
				end
			end
		end
	end)
end

RegisterServerEvent('esx_psm:startTransform')
AddEventHandler('esx_psm:startTransform', function(zone)
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

RegisterServerEvent('esx_psm:stopTransform')
AddEventHandler('esx_psm:stopTransform', function()
	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false		
	else
	   PlayersTransforming[_source]=true
	end
end)

local function Transform2(source)--Pakowanie | ubrania > paczki

	SetTimeout(Config.Czasszycie, function()

		if PlayersTransforming2[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem('4psm_ubrania').count
			local Quantity2 = xPlayer.getInventoryItem('4psm_paczkaubran').count


			if Quantity <= 0 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz ubran')
				PlayersTransforming2[source] = false
				TriggerClientEvent(FreezeEntityPosition(source, false))
				return
			else
			if Quantity2 >= 20 then
							TriggerClientEvent('esx:showNotification', source, '~r~Nie możesz więcej unieść')
							return
						else
			xPlayer.removeInventoryItem('4psm_ubrania', 1)
			xPlayer.addInventoryItem('4psm_paczkaubran', 1)
			Transform2(source)	 
				end
			end
		end
	end)
end

RegisterServerEvent('esx_psm:startTransform2')
AddEventHandler('esx_psm:startTransform2', function(zone)
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

RegisterServerEvent('esx_psm:stopTransform2')
AddEventHandler('esx_psm:stopTransform2', function()
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

			local Quantity = xPlayer.getInventoryItem('4psm_paczkaubran').count


			if Quantity <= 19 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz paczek do sprzedania')
				PlayersSelling[source] = false
				TriggerClientEvent(FreezeEntityPosition(source, false))
				return
			else
			TriggerClientEvent('esx:showNotification', _source, '~r~Sprzedawanie paczek')
			xPlayer.removeInventoryItem('4psm_paczkaubran', 20)
			xPlayer.addMoney(wypsuma)
			Sell(source)	 
				end
			end
	end)
end

RegisterServerEvent('esx_psm:startSell')
AddEventHandler('esx_psm:startSell', function(zone)
	local _source = source

	if PlayersSelling[_source] == false then
		PlayersSelling[_source]=false
		TriggerClientEvent(FreezeEntityPosition(source, false))
	else
		PlayersSelling[_source]=true
		Sell(_source,zone)
	end
end)

RegisterServerEvent('esx_psm:stopSell')
AddEventHandler('esx_psm:stopSell', function()
	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		
	else
		PlayersSelling[_source]=true
	end
end)

RegisterServerEvent('esx_psm:getStockItem')
AddEventHandler('esx_psm:getStockItem', function(itemName, count)
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

ESX.RegisterServerCallback('esx_psm:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_psm', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_psm:putStockItems')
AddEventHandler('esx_psm:putStockItems', function(itemName, count)
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

ESX.RegisterServerCallback('esx_psm:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})
end)