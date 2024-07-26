--Config
Config = {}
Config.AntiSpamTimer = 5
Config.TimerCheckPlaces = 3
Config.TimerRefreshClient = 3
Config.Wl = false

Config.Points = {}

Config.NoDiscord = "Nie wykryto Discord ID. Wyłącz FiveM oraz podłącz discord'a do konta fivem."
Config.NoIP = "Nie wykryto twojego IP."
Config.WhitelistNotLoaded = "Trwa ładowanie whitelist. Proszę czekać..."
Config.BanlistNotLoaded = "Trwa ładowanie listy banów. Proszę czekać..."
Config.CheckingWhitelist = "Trwa sprawdzanie ważności biletu..."
Config.CheckingBanlist = "Trwa sprawdzanie listy banów..."
Config.NotFoundInWhitelist = "Nie jesteś na whitelist."

Config.VPNFound = "Wykryto VPN. Jeżeli to pomyłka zgłoś się w ticket na discord"

Config.Next = "Jesteś następny w kolejce!"
Config.Waiting = "W kolejce jest "
Config.Waiting2 = " graczy. Poczekaj na swoją kolej.\n"
Config.EmojiMsg = "Jeżeli emotki się zatrzymają, zrestartuj FiveM : "
Config.PleaseWait_1 = "Poczekaj jeszcze "
Config.PleaseWait_2 = " sekund. Weryfikujemy dane Twojego konta..."
Config.Accident = "Wykryto błąd połączenia."
Config.Error = "ERROR : Skontaktuj się z administratorem serwera."


Config.EmojiList = {
	'🐌', 
	'🐍',
	'🐎', 
	'🐑', 
	'🐒',
	'🐘', 
	'🐙', 
	'🐛',
	'🐜',
	'🐝',
	'🐞',
	'🐟',
	'🐠',
	'🐡',
	'🐢',
	'🐤',
	'🐦',
	'🐧',
	'🐩',
	'🐫',
	'🐬',
	'🐲',
	'🐳',
	'🐴',
	'🐅',
	'🐈',
	'🐉',
	'🐋',
	'🐀',
	'🐇',
	'🐏',
	'🐐',
	'🐓',
	'🐕',
	'🐖',
	'🐪',
	'🐆',
	'🐄',
	'🐃',
	'🐂',
	'🐁',
	'🔥'
}

--End config

WhiteList = {}
BackList = {}
players = {}
waiting = {}
connecting = {}
disconnected = {}
allTickets = {}
firstDisconnected = {}
nextPlayer = nil
tick = 1

EmojiList = Config.EmojiList

StopResource('hardcap')

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if GetResourceState('hardcap') == 'stopped' then
			StartResource('hardcap')
		end
	end
end)

AddEventHandler("playerConnecting", function(name, reject, def)
	local source	= source
	local discordId = GetDiscordID(source)
	local playerIP = GetPlayerIP(source)
	
	if not playerIP then
		reject(Config.NoIP)
		CancelEvent()	
		return
	end
	
	-- if #WhiteList == 0 then
		-- reject(Config.WhitelistNotLoaded)
		-- CancelEvent()
		-- return
	-- end

	if not Rocade(playerIP, discordId, def, source) then
		CancelEvent()
	end
	
	if GetPlayerName(source) ~= nil then
		print(('[^2info^7] Connecting Player "%s^7"'):format(GetPlayerName(source)))
	end
end)

Citizen.CreateThread(function()
	local maxServerSlots = GetConvarInt('sv_maxclients', 128)
	
	while true do
		Citizen.Wait(Config.TimerCheckPlaces * 1000)
		CheckConnecting()
		if #waiting > 0 and #connecting + GetNumPlayerIndices() + #disconnected == maxServerSlots and nextPlayer == nil and #firstDisconnected == 0 then
			FindNext()
		end
		if #waiting > 0 and #connecting + GetNumPlayerIndices() + #disconnected < maxServerSlots and #firstDisconnected == 0 then
			ConnectFirst()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if #firstDisconnected > 0 then
			for k,v in pairs(firstDisconnected) do
				local now = os.time()
				if v[2] < now then
					nextPlayer = nil
					table.remove(firstDisconnected, k)
				end
			end
		else
			Citizen.Wait(20000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if #disconnected > 0 then
			for k,v in pairs(disconnected) do
				local now = os.time()
				if v[2] < now then
					table.remove(disconnected, k)
				end
			end
		else
			Citizen.Wait(20000)
		end
	end
end)

RegisterServerEvent("ven_queue:playerKicked")
AddEventHandler("ven_queue:playerKicked", function(src, points)
	local sid = GetDiscordID(src)
	Purge(sid)
end)

RegisterServerEvent("ven_queue:playerConnected")
AddEventHandler("ven_queue:playerConnected", function()
	local sid = GetDiscordID(source)
	Purge(sid)
end)

AddEventHandler("playerDropped", function()
	local sid = GetDiscordID(source)
	table.insert(disconnected, {sid, (os.time() + 75)})
	Purge(sid)
end)

