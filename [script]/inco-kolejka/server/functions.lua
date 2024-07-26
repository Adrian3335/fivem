local isRestarting = false
local VpnAllow = {
	['273567421351329793'] = true
}

local WLRoles = {
	['1104426281363316790'] = true, --WL-ON
}

function TurnRestart(state)
	isRestarting = state
end

Rocade = function(playerIP, discordId, def, source)
	if isRestarting then
		def.done("Trwa zaćmienie. Poczekaj na bilet")
	end
	def.defer()
	AntiSpam(def)
	Purge(discordId)
	
	if Config.Wl then
		def.update(Config.CheckingWhitelist)
		local ticket = CheckWhitelist(discordId)
		while ticket == nil do
			Citizen.Wait(100)
		end
		
		if ticket == 2 then
			def.presentCard(NoWhitelistAdaptive)
			Citizen.Wait(20000)
			def.done(Config.NotFoundInWhitelist)
			return false
		elseif ticket ~= 1 then
			def.done(ticket)
			return false
		end
	end
	
	-- if not VpnAllow[discordId] then
		-- def.update('Trwa sprawdzanie vpn...')
		-- local vpn = CheckVPN(playerIP)		
		-- if vpn == 2 then
			-- def.presentCard(VPNAdaptive)
			-- Citizen.Wait(20000)
			-- def.done(Config.VPNFound)	
		-- else
			-- def.done()
			-- return false	
		-- end
	-- end
	
	AddPlayer(discordId, source)
	local initialPoints = GetInitialPoints(discordId, source)
	table.insert(waiting, {discordId, initialPoints})
	CheckDisconnected(discordId)
	CheckWasFirst(discordId)
	local stop = false
	repeat
		for i,p in ipairs(connecting) do
			if p == discordId then
				stop = true
				break
			end
		end

		for j,sid in ipairs(waiting) do
			for i,p in ipairs(players) do
				if sid[1] == p[1] and p[1] == discordId and (GetPlayerPing(p[3]) == 0) then
					if nextPlayer == discordId then
						table.insert(firstDisconnected, {discordId, (os.time() + 75)})
					end
					
					Purge(discordId)
					def.done(Config.Accident)

					return false
				end
			end
		end
		
		def.update(GetMessage(discordId))
		tick = tick + 1
		if tick == 4 then tick = 1 end

		Citizen.Wait(Config.TimerRefreshClient * 1000)

	until stop
	
	def.done()
	return true
end

CheckConnecting = function()
	for i,sid in ipairs(connecting) do
		for j,p in ipairs(players) do
			if p[1] == sid and (GetPlayerPing(p[3]) == 500) then
				table.remove(connecting, i)
				break
			end
		end
	end
end

FindNext = function()
	if #waiting == 0 then return end
	if nextPlayer ~= nil then return end
	
	local wholeTickets = 0
	for k,v in pairs(waiting) do
		for j=1, v[2], 1 do
			wholeTickets = wholeTickets + 1
			table.insert(allTickets, {number = wholeTickets, discord = v[1]})
		end
	end
	
	local id = 1
	local randUser = math.random(1, #allTickets)
	local selectedUser = allTickets[randUser].discord
	nextPlayer = selectedUser
	allTickets = {}
end

CheckWasFirst = function(discordId)
	for k,v in pairs(firstDisconnected) do
		if v[1] == discordId then
			table.remove(firstDisconnected, k)
			break
		end
	end
end

CheckDisconnected = function(discordId)
	local found = false
	for k,v in pairs(disconnected) do
		if v[1] == discordId then
			found = true
			break
		end
	end
	if found == true then
		ConnectNow(discordId)
	end
end

ConnectNow = function(discordId)
	for k, v in pairs(waiting) do
		if v[1] == discordId then
			table.remove(waiting, k)
			break
		end
	end
	table.insert(connecting, discordId)
	Citizen.Wait(2000)
	for k,v in pairs(disconnected) do
		if discordId == v[1] then
			table.remove(disconnected, k)
			break
		end
	end
end

ConnectFirst = function()
	if #waiting == 0 then return end
	if nextPlayer == nil then
		FindNext()
	end
	while nextPlayer == nil do
		Citizen.Wait(50)
	end
	
	local discordId = nextPlayer
	nextPlayer = nil
	for k,v in pairs(waiting) do
		if discordId == v[1] then
			table.remove(waiting, k)
			break
		end
	end
	table.insert(connecting, discordId)
end

GetPoints = function(discordId)
	for i,p in ipairs(players) do
		if p[1] == discordId then
			return p[2]
		end
	end
end

GetTotalPoints = function()
	local collectedpoints = 0
	for i,p in ipairs(players) do
		collectedpoints = collectedpoints + p[2]
	end
	
	return collectedpoints
end

GetPlayerPriority = function(discordId)
	local found = 1
	
	for i=1, #WhiteList, 1 do
		local whitelist = WhiteList[i]

		if discordId == whitelist.discordId then
			found = whitelist.ticketType
			break
		end
	end

	return found
end

AddPlayer = function(discordId, source)
	for i,p in ipairs(players) do
		if discordId == p[1] then
			players[i] = {p[1], p[2], source}
			return
		end
	end

	local initialPoints = GetInitialPoints(discordId, source)
	table.insert(players, {discordId, initialPoints, source})
end

GetPlayerBackTicket = function(discordId)
	local found = 0
	for i=1, #WhiteList, 1 do
		local whitelist = WhiteList[i]

		if discordId == whitelist.discordId then
			found = whitelist.backTicket
			break
		end
	end

	return found
end

GetInitialPoints = function(discordId, source)
	local points = GetPlayerPriority(discordId)
	
	return points
end

loadWhiteList = function()
	local PreWhiteList = {}

	MySQL.Async.fetchAll('SELECT * FROM whitelist', {}, function (player)
		for i=1, #player, 1 do
			table.insert(PreWhiteList, {
				discordId = tostring(player[i].identifier):lower(),
				ticketType = tonumber(player[i].ticket),
				backTicket = tonumber(player[i].back),
			})
		end

		while (#PreWhiteList ~= #player) do
			Citizen.Wait(10)
		end

		WhiteList = PreWhiteList
	end)
end

function math.percent(percent, maxvalue)	
	
    if tonumber(percent) and tonumber(maxvalue) then
		return (percent / maxvalue) * 100
    end
    return false
end

function GetRocadePlayers()
	return #waiting
end

RegisterCommand('stats-queue', function(source, args, raw)
	local xPlayer = VEN.GetPlayerFromId(source)
	
	if xPlayer.group == 'zarzad' then
		if waiting then
			print(#waiting)
		else
			print('0')
		end
	end
end)

GetMessage = function(discordId)
	local msg = ""

	if GetPoints(discordId) ~= nil then
		
		if nextPlayer ~= nil and nextPlayer == discordId then
			msg = Config.Next .. "\n[ " .. Config.EmojiMsg
		else 
			if #waiting == 0 then
				msg = 'W kolejce jest 1 gracz. Poczekaj na swoją kolej.\n' .. '[Jeżeli emotki się zatrzymają, zrestartuj FiveM :'
			else
				msg = 'W kolejce jest ' .. #waiting .. ' graczy. Poczekaj na swoją kolej.\n' .. '[Jeżeli emotki się zatrzymają, zrestartuj FiveM :'
			end
		end
		local e1 = RandomEmojiList()
		local e2 = RandomEmojiList()
		local e3 = RandomEmojiList()
		local emojis = e1 .. e2 .. e3

		msg = msg .. emojis .. " ]"
	else
		msg = Config.Error
	end

	return msg
end

Purge = function(discordId)
	for n,sid in ipairs(connecting) do
		if sid == discordId then
			table.remove(connecting, n)
		end
	end

	for n,sid in ipairs(waiting) do
		if sid[1] == discordId then
			table.remove(waiting, n)
		end
	end
end

AntiSpam = function(def)
	for i=Config.AntiSpamTimer,0,-1 do
		def.update(Config.PleaseWait_1 .. i .. Config.PleaseWait_2)
		Citizen.Wait(1000)
	end
end

RandomEmojiList = function()
	randomEmoji = EmojiList[math.random(#EmojiList)]
	return randomEmoji
end

GetDiscordID = function(src)	
	
	local sid = false
	
	for k,v in ipairs(GetPlayerIdentifiers(src))do
		if string.sub(v, 1, string.len("discord:")) == "discord:" then
			sid = v
		end
	end	
	
	if sid then
		sid = string.gsub(sid, 'discord:', "")
	end

	return sid
end

GetPlayerIP = function(src)
	local playerIP = GetPlayerEP(src)
	
	if playerIP ~= nil then
		if string.match(playerIP, ":") then
			playerIP = splitString(playerIP, ":")[1]
		end
	end
	
	return playerIP
end

function has_value(table, val)
	if table then
		for index, value in ipairs(table) do
			if value == val then
				return true
			end
		end
	end
	return false
end

CheckWhitelist = function(discordID)
	local found = 2

	local userRoles = GetRoles(discordID)
	
	if userRoles then
		for k,v in pairs(userRoles) do			
			if WLRoles[v] then
				found = 1
				break
			end
		end
	end
	
	return found
end
			
local cacheIP = {}

CheckVPN = function(playerIP)
	local found = nil
	
	local probability = 0
	for i,entry in pairs(cacheIP) do
		if entry.ip == playerIP then
			if entry.cachedOn + (8 * 3600) < os.time() then
				table.remove(cacheIP, i)
			else
				probability = entry.probability
				
				if probability >= 0.99 then
					found = 2
				else 
					found = 1
				end
			end
		end
	end	
	
	PerformHttpRequest('http://check.getipintel.net/check.php?ip=' .. playerIP .. '&contact=Mrmisio345@gmail.com&flags=m', function(statusCode, response, headers)
		if response then
			if tonumber(response) == -5 then
				probability = -5
			elseif tonumber(response) == -6 then
				probability = -6
			elseif tonumber(response) == -4 then
				probability = -4
			else
				table.insert(cacheIP, {ip = playerIP, cachedOn = os.time(), probability = tonumber(response)})
				probability = tonumber(response)
			end
		end
		
		if probability >= 0.99 then
			found = 2
		else 
			found = 1
		end
	end)
	
	while found == nil do
		Citizen.Wait(100)
	end
	
	return found
end

function splitString(inputstr, sep)
	local t= {}; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end