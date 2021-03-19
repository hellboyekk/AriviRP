ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GenerateAccountNumber()
    local running = true
    local account = nil
    while running do
        local rand = '' .. math.random(11111,99999)
        local count = MySQL.Sync.fetchScalar("SELECT COUNT(account_number) FROM users WHERE account_number = @account_number", { ['@account_number'] = rand })
		if count < 1 then
			account = rand
			running = false
        end
    end
    return account
end

AddEventHandler('esx:playerLoaded',function(playerId, xPlayer)
	local _source = playerId
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT account_number FROM users WHERE identifier = @identifier',
	{
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].account_number == nil or result[1].account_number == '0' then
			local accountNumber = GenerateAccountNumber()
			MySQL.Async.execute('UPDATE users SET account_number = @account_number WHERE identifier = @identifier',
			{
				['@identifier'] = xPlayer.identifier,
				['@account_number'] = accountNumber
			})
		end
	end)
end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('bank:result', _source, "error", "Brak środków.")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('bank:result', _source, "success", "Wpłacono.")
		local xPlayer = ESX.GetPlayerFromId(source)
		local steamid = xPlayer.identifier
		local name = GetPlayerName(source)
		wiadomosc = name.." | Bankomat \n[WPŁATA: $"..amount.."] \n[ID: "..source.." | Nazwa: "..name.." | SteamID: "..steamid.." ]" 
		DiscordHookdeposit('AriviRP.pl', wiadomosc, 11750815)
	end
end)

-- funkcja;
function DiscordHookdeposit(hook,message,color)
    local deposit2 = 'https://discord.com/api/webhooks/802731556774608916/Y8clLxwIGXXmIltKA3-M4zU76dvztwEjhcaVqC9sYuHDWuZKD1XqhPpH6pQRYw8SsM-r'
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
    PerformHttpRequest(deposit2, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('bank:result', _source, "error", "Brak środków.")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('bank:result', _source, "success", "Wypłacono.")
		local xPlayer = ESX.GetPlayerFromId(source)
		local steamid = xPlayer.identifier
		local name = GetPlayerName(source)
		wiadomosc = name.." | Bankomat \n[WYPŁATA: $"..amount.."] \n[ID: "..source.." | Nazwa: "..name.." | SteamID: "..steamid.." ]" 
		DiscordHookwithdraw('AriviRP.pl', wiadomosc, 11750815)
	end
end)

-- funkcja;
function DiscordHookwithdraw(hook,message,color)
    local withdraw2 = 'https://discord.com/api/webhooks/802732083230670898/c3-Ciir09lXKN10nUng-9WXTeN7wn4G8oRuk4HnBd1LelnUjYjCpO4zTi0qqNUhchuqI'
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
    PerformHttpRequest(withdraw2, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
end)

-- funkcja;
function DiscordHooktransfer(hook,message,color)
    local transfer2 = 'https://discord.com/api/webhooks/802732525101121547/nd4tDIt4Q5_1u3euSPh3HPdFICsZIBEjpsyTnYBBtA3iR59oWOYaMSs0WXh2Wl7hdaU9'
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
    PerformHttpRequest(transfer2, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local identifier = xPlayer.identifier
    local steamhex = GetPlayerIdentifier(_source)
	local balance = 0
	local found = false
	MySQL.Async.fetchAll('SELECT * FROM users WHERE account_number = @account_number',
	{ 
		['@account_number'] = to
	},
	function (result)
		if result[1] ~= nil then
			local targetbankaccount = result[1].account_number
			local targetbabkbalance = json.decode(result[1].accounts)
			local targetidentifier = result[1].identifier
			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',
			{ 
				['@identifier'] = identifier
			}, function (result2)
				if result2[1] ~= nil then
					local sourcebankaccount = result2[1].account_number
					if targetbankaccount == sourcebankaccount then
						TriggerClientEvent('bank:result', _source, "error", "Przelew nieudany.")
						TriggerClientEvent('esx:showNotification', _source, "~r~Przelew nieudany.")
					else
						balance = xPlayer.getAccount('bank').money
						if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
							TriggerClientEvent('bank:result', _source, "error", "Przelew nieudany.")
							TriggerClientEvent('esx:showNotification', _source, "~r~Przelew nieudany.")
						else
							local newtargetbabkbalance = targetbabkbalance.bank + amountt
							xPlayer.removeAccountMoney('bank', tonumber(amountt))
							for i=1, #xPlayers, 1 do
								local xPlayerx = ESX.GetPlayerFromId(xPlayers[i])
								if xPlayerx.identifier == targetidentifier then
									xPlayerx.addAccountMoney('bank', tonumber(amountt))
									found = true
									TriggerClientEvent('esx:showNotification', xPlayers[i], "~g~Otrzymales przelew!\nZ numeru konta: ~y~"..sourcebankaccount)
									ESX.SavePlayers()
									local steamid = xPlayer.identifier
									local zsteamid = xPlayerx.identifier
									local zPlayer = ESX.GetPlayerFromId(to)
									local zPlayer1 = '?'
									local name = GetPlayerName(_source)
									wiadomosc = name.." | Bankomat \n[PRZELEW: $"..amountt.."] \n[ ID: ".._source.." | Nazwa: "..name.." | Licencja: "..steamid.." ]\n[ PRZELAŁ PIENIĄDZE DO ID: "..xPlayers[i].." Licencja: "..zsteamid.." ]" 
									DiscordHooktransfer('AriviRP.pl', wiadomosc, 11750815)
								end
							end
							if not found then
								MySQL.Async.execute('UPDATE users SET accounts = JSON_SET(accounts, "$.bank", @newBank) WHERE account_number = @account_number',
									{
										['@account_number'] = targetbankaccount,
										['@newBank'] = newtargetbabkbalance
									}
								)
								local steamid = xPlayer.identifier
								local name = GetPlayerName(_source)
								wiadomosc = name.." | Bankomat \n[PRZELEW: $"..amountt.."] \n[ ID: "..source.." | Nazwa: "..name.." | Licencja: "..steamid.." ]\n[ PRZELAŁ PIENIĄDZE DO ID: "..xPlayers[i].." Licencja: "..zsteamid.." ]" 
								DiscordHooktransfer('AriviRP.pl', wiadomosc, 11750815)
							end
							TriggerClientEvent('bank:result', _source, "success", "Pieniadze zostaly przelane na inne konto.")
							TriggerClientEvent('esx:showNotification', _source, "~g~Pieniadze zostaly przelane na inne konto.")
						end
					end
				else
					TriggerClientEvent('bank:result', _source, "error", "Przelew nieudany.")
					TriggerClientEvent('esx:showNotification', _source, "~r~Przelew nieudany.")
				end
			end)
		else
			TriggerClientEvent('bank:result', _source, "error", "Przelew nieudany.")
			TriggerClientEvent('esx:showNotification', _source, "~r~Przelew nieudany.")
		end
	end)
end)





