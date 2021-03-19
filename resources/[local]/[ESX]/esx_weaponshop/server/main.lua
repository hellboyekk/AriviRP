ESX = nil
local shopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_weaponshop:buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
		cb(false)
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
	end
end)


RegisterServerEvent('weaponshop:buypistol')
AddEventHandler('weaponshop:buypistol', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.Prices[1] then
		xPlayer.removeAccountMoney('money', Config.Prices[1])
		xPlayer.addInventoryItem('pistol', 1)
		xPlayer.showNotification('Zakupiłeś pistolet za:~o~ $'..Config.Prices[1])
	else
		xPlayer.showNotification('Nie posiadasz przy sobie wystarczającej ilości gotówki')
	end
end)
RegisterServerEvent('weaponshop:buypistolmk2')
AddEventHandler('weaponshop:buypistolmk2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.BlackPrices[2] then
		xPlayer.removeAccountMoney('money', Config.BlackPrices[2])
		xPlayer.addInventoryItem('snspistol_mk2', 1)
		xPlayer.showNotification('Zakupiłeś pistolet SNS MK2 za:~o~ $'..Config.BlackPrices[2])
	else
		xPlayer.showNotification('Nie posiadasz przy sobie wystarczającej ilości gotówki')
	end
end)
RegisterServerEvent('weaponshop:buySCYZORYK')
AddEventHandler('weaponshop:buySCYZORYK', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.Prices[3] then
		xPlayer.removeAccountMoney('money', Config.Prices[3])
		xPlayer.addInventoryItem('switchblade', 1)
		xPlayer.showNotification('Zakupiłeś Scyzoryk za:~o~ $'..Config.Prices[3])
	else
		xPlayer.showNotification('Nie posiadasz przy sobie wystarczającej ilości gotówki')
	end
end)
RegisterServerEvent('weaponshop:buynoz')
AddEventHandler('weaponshop:buynoz', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.Prices[4] then
		xPlayer.removeAccountMoney('money', Config.Prices[4])
		xPlayer.addInventoryItem('knife', 1)
		xPlayer.showNotification('Zakupiłeś Nóż za:~o~ $'..Config.Prices[4])
	else
		xPlayer.showNotification('Nie posiadasz przy sobie wystarczającej ilości gotówki')
	end
end)
RegisterServerEvent('weaponshop:buymagazynek')
AddEventHandler('weaponshop:buymagazynek', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.Prices[5] then
		xPlayer.removeAccountMoney('money', Config.Prices[5])
		xPlayer.addInventoryItem('pistol_ammo', 1)
		xPlayer.showNotification('Zakupiłeś Magazynek za:~o~ $'..Config.Prices[5])
	else
		xPlayer.showNotification('Nie posiadasz przy sobie wystarczającej ilości gotówki')
	end
end)
RegisterServerEvent('weaponshop:buylornetka')
AddEventHandler('weaponshop:buylornetka', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.Prices[6] then
		xPlayer.removeAccountMoney('money', Config.Prices[6])
		xPlayer.addInventoryItem('binoculars', 1)
		xPlayer.showNotification('Zakupiłeś Lornetkę za:~o~ $'..Config.Prices[6])
	else
		xPlayer.showNotification('Nie posiadasz przy sobie wystarczającej ilości gotówki')
	end
end)
RegisterServerEvent('weaponshop:buylatarka')
AddEventHandler('weaponshop:buylatarka', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.Prices[7] then
		xPlayer.removeAccountMoney('money', Config.Prices[7])
		xPlayer.addInventoryItem('flashlight', 1)
		xPlayer.showNotification('Zakupiłeś Latarkę za:~o~ $'..Config.Prices[7])
	else
		xPlayer.showNotification('Nie posiadasz przy sobie wystarczającej ilości gotówki')
	end
end)
RegisterServerEvent('weaponshop:buybutelka')
AddEventHandler('weaponshop:buybutelka', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= Config.BlackPrices[7] then
		xPlayer.removeAccountMoney('money', Config.BlackPrices[7])
		xPlayer.addInventoryItem('bottle', 1)
		xPlayer.showNotification('Zakupiłeś Butelkę za:~o~ $'..Config.BlackPrices[7])
	else
		xPlayer.showNotification('Nie posiadasz przy sobie wystarczającej ilości gotówki')
	end
end)

RegisterServerEvent('esx_weashop:buyItem')
AddEventHandler('esx_weashop:buyItem', function(itemName, price, zone)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local account = xPlayer.getAccount('black_money')
	
	if zone=="BlackWeashop" then
		if account.money >= price then
			xPlayer.removeAccountMoney('black_money', price)
			xPlayer.addInventoryItem(ItemName, 32)
			TriggerClientEvent('esx:showNotification', _source, _U('buy') .. ESX.GetItemLabel(itemName))
			local steamid21 = xPlayer.identifier
			local name33 = GetPlayerName(source)
			wiadomosc = name33.." | Sklepy \n[ ZAKUPIONY PRZDMIOT: "..itemName.." | KOSZT: "..price.." ] \n[ID: "..source.." | Nazwa: "..name33.." | SteamID: "..steamid21.." ]" 
			DiscordHook3('AriviRP.pl', wiadomosc, 11750815)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_black'))
		end
	else
		if xPlayer.get('money') >= price then
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(ItemName, 32)
			TriggerClientEvent('esx:showNotification', _source, _U('buy') .. ESX.GetItemLabel(itemName))
			local steamid21 = xPlayer.identifier
			local name33 = GetPlayerName(source)
			wiadomosc = name33.." | Sklepy \n[ ZAKUPIONY PRZDMIOT: "..itemName.." | KOSZT: "..price.." ] \n[ID: "..source.." | Nazwa: "..name33.." | SteamID: "..steamid21.." ]" 
			DiscordHook3('AriviRP.pl', wiadomosc, 11750815)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
		end
	end
end)

function DiscordHook3(hook,message,color)
    local msg222 = 'https://discord.com/api/webhooks/802961779486883870/bLhK-ZlbTQX1_vQuAvFf9_MKWldwUFJ0ld7mYEMDweYql-rFZoC-yTi7G6qxFwExZfj_'
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
    PerformHttpRequest(msg222, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


