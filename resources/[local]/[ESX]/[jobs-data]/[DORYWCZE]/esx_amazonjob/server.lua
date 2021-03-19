ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayersPaczki       = {}
local ladujkurwepolicyjnawdupe = {}
local ladujkurwemedycznawdupe = {}
local ladujkurwemechanikawdupe = {}
local ladujkurwekelnerawdupe = {}
local ladujkurwebankierawdupe = {}
local ladujkurwealchemikawdupe = {}
local ladujkurweakwizytorawdupe = {}

local function zbierzpaczkensa(source)
	local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local paczkalimit = xPlayer.getInventoryItem('paczkapolice')
	SetTimeout(5000, function()
		if PlayersPaczki[source] == true then
			if paczkalimit.count >= 20 then
				xPlayer.setInventoryItem('paczkapolice', paczkalimit.limit)
				TriggerClientEvent('amazon:zaduzo', _source)
				TriggerClientEvent('amazon:oddawaniemoczu', _source, false)
			else
				xPlayer.addInventoryItem('paczkapolice', 1)
				zbierzpaczkensa(_source)
			end
		end
	end)
end

RegisterServerEvent('amazon:zbierzpaczki')
AddEventHandler('amazon:zbierzpaczki', function()
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	
	PlayersPaczki[source] = true

	TriggerClientEvent('amazon:oddawaniemoczu', _source, true)

	TriggerClientEvent('esx:showNotification', _source, 'Zbieranie paczek w toku...')

	zbierzpaczkensa(_source)

end)

local function ladujkurwopaczke(source, jebanytyp)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	SetTimeout(5000, function()
		if jebanytyp == "paczkapolice" then
			if ladujkurwepolicyjnawdupe[source] == true then
				local PaczkaPoliceQuantity = xPlayer.getInventoryItem('paczkapolice').count
				if PaczkaPoliceQuantity <= 0 then
					TriggerClientEvent('amazon:zamalo', source)
					TriggerClientEvent('amazon:oddawaniemoczu', _source, false)		
				else   
					xPlayer.removeInventoryItem('paczkapolice', 1)
					local paczkaemslimit = xPlayer.getInventoryItem('paczkaems')
					if(paczkaemslimit.limit < paczkaemslimit.count + 1) then
						xPlayer.setInventoryItem('paczkaems', paczkaemslimit.limit)
						TriggerClientEvent('amazon:zaduzo', source)
						TriggerClientEvent('amazon:oddawaniemoczu', _source, false)
					else
						xPlayer.addInventoryItem('paczkaems', 1)
						ladujkurwopaczke(_source, "paczkapolice")
					end
				end
			end
		elseif jebanytyp == "paczkaems" then
			if ladujkurwemedycznawdupe[source] == true then
				local PaczkaEmsQuantity = xPlayer.getInventoryItem('paczkaems').count
				if PaczkaEmsQuantity <= 0 then
					TriggerClientEvent('amazon:zamalo', source)
					TriggerClientEvent('amazon:oddawaniemoczu', _source, false)	
				else   
					xPlayer.removeInventoryItem('paczkaems', 1)
					local paczkalsclimit = xPlayer.getInventoryItem('paczkalsc')
					if(paczkalsclimit.limit < paczkalsclimit.count + 1) then
						xPlayer.setInventoryItem('paczkalsc', paczkalsclimit.limit)
						TriggerClientEvent('amazon:zaduzo', source)
						TriggerClientEvent('amazon:oddawaniemoczu', _source, false)
					else
						xPlayer.addInventoryItem('paczkalsc', 1)
						ladujkurwopaczke(_source, "paczkaems")
					end
				end
			end
		elseif jebanytyp == "paczkalsc" then
			if ladujkurwemechanikawdupe[source] == true then
				local PaczkaLcsQuantity = xPlayer.getInventoryItem('paczkalsc').count
				if PaczkaLcsQuantity <= 0 then
					TriggerClientEvent('amazon:zamalo', source)
					TriggerClientEvent('amazon:oddawaniemoczu', _source, false)	
				else   
					xPlayer.removeInventoryItem('paczkalsc', 1)
					local paczkacoffeelimit = xPlayer.getInventoryItem('paczkacoffee')
					if(paczkacoffeelimit.limit < paczkacoffeelimit.count + 1) then
						xPlayer.setInventoryItem('paczkacoffee', paczkacoffeelimit.limit)
						TriggerClientEvent('amazon:zaduzo', source)
						TriggerClientEvent('amazon:oddawaniemoczu', _source, false)
					else
						xPlayer.addInventoryItem('paczkacoffee', 1)
						ladujkurwopaczke(_source, "paczkalsc")
					end
				end
			end
		elseif jebanytyp == "paczkacoffee" then
			local PaczkaCoffeeQuantity = xPlayer.getInventoryItem('paczkacoffee').count
			if PaczkaCoffeeQuantity <= 0 then
				TriggerClientEvent('amazon:zamalo', source)
				TriggerClientEvent('amazon:oddawaniemoczu', _source, false)	
			else   
				xPlayer.removeInventoryItem('paczkacoffee', 1)
				local paczkapacificlimit = xPlayer.getInventoryItem('paczkapacific')
				if(paczkapacificlimit.limit < paczkapacificlimit.count + 1) then
					xPlayer.setInventoryItem('paczkapacific', paczkapacificlimit.limit)
					TriggerClientEvent('amazon:zaduzo', source)
					TriggerClientEvent('amazon:oddawaniemoczu', _source, false)
				else
					xPlayer.addInventoryItem('paczkapacific', 1)
					ladujkurwopaczke(_source, "paczkacoffee")
				end
			end
		elseif jebanytyp == "paczkapacific" then	
			local PaczkaPacificQuantity = xPlayer.getInventoryItem('paczkapacific').count
			if PaczkaPacificQuantity <= 0 then
				TriggerClientEvent('amazon:zamalo', source)
				TriggerClientEvent('amazon:oddawaniemoczu', _source, false)	
			else   
				xPlayer.removeInventoryItem('paczkapacific', 1)
				local paczkahumanelimit = xPlayer.getInventoryItem('paczkahumane')
				if(paczkahumanelimit.limit < paczkahumanelimit.count + 1) then
					xPlayer.setInventoryItem('paczkahumane', paczkahumanelimit.limit)
					TriggerClientEvent('amazon:zaduzo', source)
					TriggerClientEvent('amazon:oddawaniemoczu', _source, false)
				else
					xPlayer.addInventoryItem('paczkahumane', 1)
					ladujkurwopaczke(_source, "paczkapacific")
				end
			end
		elseif jebanytyp == "paczkahumane" then	
			local PaczkaHumaneQuantity = xPlayer.getInventoryItem('paczkahumane').count
			if PaczkaHumaneQuantity <= 0 then
				TriggerClientEvent('amazon:zamalo', source)
				TriggerClientEvent('amazon:oddawaniemoczu', _source, false)	
			else   
				xPlayer.removeInventoryItem('paczkahumane', 1)
				local paczkadojlimit = xPlayer.getInventoryItem('paczkadoj')
				if(paczkadojlimit.limit < paczkadojlimit.count + 1) then
					xPlayer.setInventoryItem('paczkadoj', paczkadojlimit.limit)
					TriggerClientEvent('amazon:zaduzo', source)
					TriggerClientEvent('amazon:oddawaniemoczu', _source, false)
				else
					xPlayer.addInventoryItem('paczkadoj', 1)
					ladujkurwopaczke(_source, "paczkahumane")
				end
			end
		elseif jebanytyp == "paczkadoj" then
			local PaczkaDojQuantity = xPlayer.getInventoryItem('paczkadoj').count
			if PaczkaDojQuantity <= 0 then
				TriggerClientEvent('amazon:zamalo', source)
				TriggerClientEvent('amazon:oddawaniemoczu', _source, false)	
			else   
				xPlayer.removeInventoryItem('paczkadoj', 1)
				local kwitlimit = xPlayer.getInventoryItem('kwit')
				if(kwitlimit.limit < kwitlimit.count + 1) then
					xPlayer.setInventoryItem('kwit', kwitlimit.limit)
					TriggerClientEvent('amazon:zaduzo', source)
					TriggerClientEvent('amazon:oddawaniemoczu', _source, false)
				else
					xPlayer.addInventoryItem('kwit', 1)
					ladujkurwopaczke(_source, "paczkadoj")
				end
			end
		end
	end)
end

RegisterServerEvent('amazon:dostarczpaczki')
AddEventHandler('amazon:dostarczpaczki', function(item)
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('amazon:oddawaniemoczu', _source, true)
	TriggerClientEvent('esx:showNotification', _source, 'Oddawanie paczek w toku...')
	if item == "paczkapolice" then
		ladujkurwepolicyjnawdupe[source] = true
		ladujkurwopaczke(_source, "paczkapolice")
	elseif item == "paczkaems" then
		ladujkurwemedycznawdupe[source] = true
		ladujkurwopaczke(_source, "paczkaems")		
	elseif item == "paczkalsc" then
		ladujkurwemechanikawdupe[source] = true
		ladujkurwopaczke(_source, "paczkalsc")
	elseif item == "paczkacoffee" then
		ladujkurwekelnerawdupe[source] = true
		ladujkurwopaczke(_source, "paczkacoffee")	
	elseif item == "paczkapacific" then
		ladujkurwebankierawdupe[source] = true
		ladujkurwopaczke(_source, "paczkapacific")		
	elseif item == "paczkahumane" then
		ladujkurwealchemikawdupe[source] = true
		ladujkurwopaczke(_source, "paczkahumane")	
	elseif item == "paczkadoj" then
		ladujkurweakwizytorawdupe[source] = true
		ladujkurwopaczke(_source, "paczkadoj")
	end
end)

RegisterNetEvent('amazon:nosiemanko')
AddEventHandler('amazon:nosiemanko', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local count = 20
	local money = 30000
	local myitemsniggerze = xPlayer.getInventoryItem('kwit').count
	if xPlayer.job.name == 'deliverer' and myitemsniggerze == 20 then
		xPlayer.removeInventoryItem('kwit', count)
		xPlayer.showNotification('Otrzymano wypłatę: ~o~$'..money)
		xPlayer.addMoney(money)
	else
		xPlayer.showNotification('Nie posiadasz przy sobie paczek')
	end
end)
