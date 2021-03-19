local connected = false

AddEventHandler("playerSpawned", function()
	if not connected then
		TriggerServerEvent("rocademption:playerConnected")
		connected = true
	end
end)

RegisterNetEvent('jebacpis')
AddEventHandler('jebacpis', function()
	--local me = GetPlayerServerId(i)
	--local target2 =  GetPlayerServerId(closestPlayer)
	print("Clearing Voice Target")
	exports['mumble-voip']:removePlayerFromRadio()
	exports['mumble-voip']:removePlayerFromCall()
	Citizen.Wait(50)
	NetworkClearVoiceChannel()
	MumbleIsConnected()
	NetworkSetTalkerProximity(3.5 + 0.0)
	print("Voice: Loaded")	
end)