--[[
ESX.StartPayCheck = function()
	function payCheck()
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local praca   = xPlayer.job.label
			local stopien = xPlayer.job.grade_label
			local salary  = xPlayer.job.grade_salary
			if salary > 0 then
				if job == 'unemployed' then
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenie z zasilku:~g~ '..salary..'$', 'CHAR_BANK_FLEECA', 9)
				else
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenie z pracy~y~ '..praca..' - '..stopien..':~g~ '..salary..'$', 'CHAR_BANK_FLEECA', 9)	
				end
			end
		end
		SetTimeout(Config.PaycheckInterval, payCheck)
	end
	SetTimeout(Config.PaycheckInterval, payCheck)
end
]]

RegisterServerEvent('xd')
AddEventHandler('xd', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local job     = xPlayer.job.name
	local praca   = xPlayer.job.label
	local stopien = xPlayer.job.grade_label
	local salary  = xPlayer.job.grade_salary
	local hiddenjob = xPlayer.hiddenjob.name
	local hiddenpraca = xPlayer.hiddenjob.label
	local hiddensalary = xPlayer.hiddenjob.grade_salary
	if salary > 0 then
		if job == 'unemployed' then
			xPlayer.addAccountMoney('bank', salary)
			if hiddenjob ~= 'unemployed' and hiddenjob ~= job then
				xPlayer.addAccountMoney('bank', hiddensalary)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenia:\n~y~Zasiłek: ~g~'..salary..'$\n~y~' .. hiddenpraca .. ':~g~ ' .. hiddensalary .. '$')
			else
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenia:\n~y~Zasiłek: ~g~'..salary..'$')
			end
		else
			xPlayer.addAccountMoney('bank', salary)
			if hiddenjob ~= 'unemployed' and hiddenjob ~= job then
				xPlayer.addAccountMoney('bank', hiddensalary)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenia:\n~y~'..praca..' - '..stopien..':~g~ '..salary..'$\n~y~' .. hiddenpraca .. ':~g~ ' .. hiddensalary .. '$')
			else
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenia:\n~y~'..praca..' - '..stopien..':~g~ '..salary..'$')	
			end
		end
	end
end)