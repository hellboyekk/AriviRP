ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)



RegisterServerEvent('esx_gym:checkChip')
AddEventHandler('esx_gym:checkChip', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local oneQuantity = xPlayer.getInventoryItem('gym_membership').count
	
	if oneQuantity > 0 then
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	else
		TriggerClientEvent('esx_gym:falseMembership', source) -- false
	end
end)


RegisterServerEvent('esx_gym:buyMembership')
AddEventHandler('esx_gym:buyMembership', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1200) then
		xPlayer.removeMoney(1200)
		
		xPlayer.addInventoryItem('gym_membership', 1)		
		notification("Zakupiłeś/aś ~g~Karnet")
		
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	else
		notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)


RegisterServerEvent('esx_gym:getpolicemembership')
AddEventHandler('esx_gym:getpolicemembership', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('gym_membership', 1)		
		notification("Otrzymałeś/aś ~g~Karnet")
		
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)

RegisterServerEvent('esx_gym:buyProteinshake')
AddEventHandler('esx_gym:buyProteinshake', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 6) then
		xPlayer.removeMoney(6)
		
		xPlayer.addInventoryItem('protein_shake', 1)
		
		notification("Zakupiłeś/aś ~g~Shake Proteionowy")
	else
		notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)


RegisterServerEvent('esx_gym:Shakepolice')
AddEventHandler('esx_gym:Shakepolice', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('protein_shake', 1)
		
		notification("Otrzymałeś/aś ~g~Shake Proteionowy~w~ z zapasów Policyjnych")
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)



RegisterServerEvent('esx_gym:Shakemechanik')
AddEventHandler('esx_gym:Shakemechanik', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('protein_shake', 1)
		
		notification("Otrzymałeś/aś ~g~Shake Proteionowy~w~ z zapasów Mechaników")
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)

ESX.RegisterUsableItem('protein_shake', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('protein_shake', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Wypiłeś/aś ~g~Shake Proteionowy~w~!')

end)

RegisterServerEvent('esx_gym:buyWater')
AddEventHandler('esx_gym:buyWater', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1) then
		xPlayer.removeMoney(1)
		
		xPlayer.addInventoryItem('water', 1)
		
		notification("Zakupiłeś/aś ~g~Wodę")
	else
		notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end		
end)

RegisterServerEvent('esx_gym:Watermechanik')
AddEventHandler('esx_gym:Watermechanik', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('water', 1)
		
		notification("Otrzymałeś/aś ~g~Wodę~w~ z zapasów Mechaników")
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)


RegisterServerEvent('esx_gym:Breadmechanik')
AddEventHandler('esx_gym:Breadmechanik', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('bread', 1)
		
		notification("Otrzymałeś/aś ~g~Chleb~w~ z zapasów Mechaników")
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)

RegisterServerEvent('esx_gym:Waterpolice')
AddEventHandler('esx_gym:Waterpolice', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('water', 1)
		
		notification("Otrzymałeś/aś ~g~Wodę~w~ z zapasów Policyjnych")
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)

RegisterServerEvent('esx_gym:buySportlunch')
AddEventHandler('esx_gym:buySportlunch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 2) then
		xPlayer.removeMoney(2)
		
		xPlayer.addInventoryItem('sportlunch', 1)
		
		notification("Zakupiłeś/aś ~g~Luch Sportowy")
	else
		notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end		
end)

RegisterServerEvent('esx_gym:Lunchpolice')
AddEventHandler('esx_gym:Lunchpolice', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('sportlunch', 1)
		
		notification("Otrzymałeś/aś ~g~Lunch Sportowy~w~ z zapasów Policyjnych")
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)

RegisterServerEvent('esx_gym:Redbullpolice')
AddEventHandler('esx_gym:Redbullpolice', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('redbull', 1)
		
		notification("Otrzymałeś/aś ~g~Redbull'a~w~ z zapasów Policyjnych")
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)

RegisterServerEvent('esx_gym:Redbullmechanik')
AddEventHandler('esx_gym:Redbullmechanik', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('redbull', 1)
		
		notification("Otrzymałeś/aś ~g~Redbull'a~w~ z zapasów Mechaników")
	--else
	--	notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end	
end)


ESX.RegisterUsableItem('sportlunch', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sportlunch', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Zjadłeś/aś ~g~Lunch Sportowy~w~!')

end)

RegisterServerEvent('esx_gym:buyPowerade')
AddEventHandler('esx_gym:buyPowerade', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 4) then
		xPlayer.removeMoney(4)
		
		xPlayer.addInventoryItem('powerade', 1)
		
		notification("Zakupiłeś/aś ~g~Powerade")
	else
		notification("Nie posiadasz wstarczająco ~r~Pieniędzy.")
	end		
end)

ESX.RegisterUsableItem('powerade', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('powerade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 700000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Wypiłeś/aś ~g~Powerade')

end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end