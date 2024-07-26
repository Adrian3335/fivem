ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterCommand('goto', {'trialsupport', 'support', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.id then
        local xTarget = ESX.GetPlayerFromId(args.id)
		if xPlayer and xTarget then
			local targetCoords = xTarget.coords
			xPlayer.setCoords(targetCoords)
			-- exports['exile_logs']:SendLog(xPlayer.source, "Użyto komendy /goto do gracza: " .. args.id, "admin_commands2")
        end
    end
end, true, {help = "Teleportuj się do gracza", validate = true, arguments = {
    {name = 'id', help = "ID gracza", type = 'number'},
}})

ESX.RegisterCommand('bring', {'trialsupport', 'support', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.id then
        local xTarget = ESX.GetPlayerFromId(args.id)
        if xPlayer and xTarget then
            local targetCoords = xPlayer.coords
			xTarget.setCoords(targetCoords)
			-- exports['exile_logs']:SendLog(xPlayer.source, "Użyto komendy /bring na graczu: " .. args.id, "admin_commands2")
        end
    end
end, true, {help = "Teleportuj gracza do siebie", validate = true, arguments = {
    {name = 'id', help = "ID gracza", type = 'number'},
}})

ESX.RegisterCommand('slap', {'best'}, function(xPlayer, args, showError)
    if args.id then
        local xTarget = ESX.GetPlayerFromId(args.id)
        if xPlayer and xTarget then
			local xTarget = ESX.GetPlayerFromId(args.id)
			TriggerClientEvent('EasyAdmin:Slap', xTarget.source)
			-- exports['exile_logs']:SendLog(xPlayer.source, "Użyto komendy /slap " .. xTarget.source, "admin_commands")
        end
    end
end, true, {help = "Wyjeb gracza w kosmos", validate = true, arguments = {
    {name = 'id', help = "ID gracza", type = 'number'},
}})

ESX.RegisterCommand('slay', {'best', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.id then
        local xTarget = ESX.GetPlayerFromId(args.id)
        if xPlayer and xTarget then
			local xTarget = ESX.GetPlayerFromId(args.id)
            TriggerClientEvent('EasyAdmin:Slay', xTarget.source)
        end
    end
end, true, {help = "Zabij gracza", validate = true, arguments = {
    {name = 'id', help = "ID gracza", type = 'number'},
}})

ESX.RegisterCommand('tpp', {'support', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.steamid and args.targetid then
        local xPlayer = ESX.GetPlayerFromId(args.steamid)
        local xPlayerTarget = ESX.GetPlayerFromId(args.targetid)
        if xPlayer and xPlayerTarget then
            TriggerClientEvent('EasyAdmin:Teleport', xPlayer.source, xPlayerTarget.source)
			-- exports['exile_logs']:SendLog(xPlayer.source, "Użyto komendy /tpp gracza: " .. args.steamid .. " do gracza: " .. args.targetid, "admin_commands2")
        end
    end
end, true, {help = "Teleportuj gracza do gracza", validate = true, arguments = {
    {name = 'steamid', help = "ID gracza 1", type = 'number'},
    {name = 'targetid', help = "ID gracza 2", type = 'number'}
}})

ESX.RegisterCommand('savecar', {'admin', 'superadmin', 'best'}, function(xPlayer, args, showError)
	if args.targetid ~= nil then
		local tPlayer = ESX.GetPlayerFromId(args.targetid)
		if xPlayer and tPlayer then
			TriggerClientEvent('EasyAdmin:GetCurrentCar', tPlayer.source, 1337)
			-- exports['exile_logs']:SendLog(xPlayer.source, "Użyto komendy /savecar " .. args.targetid, "car")
		end
	end
end, true, {help = "Przypisz auto w którym siedzi gracz do niego", validate = true, arguments = {
    {name = 'targetid', help = "ID gracza", type = 'number'},
}})



ESX.RegisterCommand('givecar', {'admin', 'superadmin', 'best'}, function(xPlayer, args, showError)
    if args.steamid and args.targetid then
		local xPlayer = ESX.GetPlayerFromId(args.steamid)
		if xPlayer then
			TriggerClientEvent('esx:spawnVehicle', args.steamid, args.targetid)
			-- exports['exile_logs']:SendLog(xPlayer.source, "Użyto komendy /givecar o modelu: " .. args.targetid .. " dla gracza o id: " .. args.steamid, "car")
		end
	end
end, true, {help = "Daj auto", validate = true, arguments = {
    {name = 'steamid', help = "SteamID zaczynające się od steam:11", type = 'string'},
    {name = 'targetid', help = "SteamID zaczynające się od steam:11", type = 'string'}
}})

ESX.RegisterCommand('cleareq', {'mod', 'admin', 'superadmin', 'best'}, function(xPlayer, args, showError)
    if args.steamid then
		MySQL.Async.execute("UPDATE users SET inventory = '[]', accounts = JSON_SET(accounts, '$.money', 0) WHERE identifier = @identifier",{
			['@identifier'] = args.steamid
		})
		MySQL.Async.execute("UPDATE users SET accounts = JSON_SET(accounts, '$.black_money', 0) WHERE identifier = @identifier",{
			['@identifier'] = args.steamid
		})
	end
end, true, {help = "Wyczyść ekwipunek", validate = true, arguments = {
    {name = 'steamid', help = "Licencja gracza (działa tylko na aktywną postać!)", type = 'string'},
}})

ESX.RegisterCommand('admins', {'trialsupport', 'support', 'mod', 'admin', 'superadmin', 'best'}, function(xPlayerr, args, showError)
	local xPlayers = ESX.GetPlayers()
	local admins = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.group == "trialsupport" or xPlayer.group == "support" or xPlayer.group == "mod" or xPlayer.group == "admin" or xPlayer.group == "superadmin" or xPlayer.group == "dev" or xPlayer.group == "best" then
			table.insert(admins, {label="["..xPlayer.source.."] "..GetPlayerName(xPlayer.source), value="admin"..i})
		end	
	end
	TriggerClientEvent("EasyAdmin:adminList", xPlayerr.source, admins)
end, true, {help = "Sprawdź listę administracji"})


RegisterServerEvent('EasyAdmin:SaveCar')
AddEventHandler('EasyAdmin:SaveCar', function(vehicleProps, recieved)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if recieved == 1337 then
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, digit) VALUES (@owner, @plate, @vehicle, @digit)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps),
			['@digit'] = xPlayer.getDigit()
		}, function (rowsChanged)
			TriggerClientEvent('esx:showNotification', _source, "~g~Pojazd należy teraz do Ciebie")
		end)
	else
		-- exports['exile_logs']:SendLog(_source, "Próbwa wywołania eventu SaveCar", "anticheat")
	end
end)



ESX.RegisterCommand('revivedist', {'trialsupport', 'support', 'mod', 'admin', 'superadmin', 'best'}, function(xPlayer, args, showError)
    if args.dist then
		if args.dist <= 500 then
			local admincoords = GetEntityCoords(GetPlayerPed(xPlayer.source))
			-- exports['exile_logs']:SendLog(xPlayer.source, "Użyto komendy /revivedist " .. tonumber(args.dist), "revive")
			for k, v in pairs(GetPlayers()) do
				local playercoords = GetEntityCoords(GetPlayerPed(v))
				local distance = #(admincoords - playercoords)
				if distance < args.dist then
					TriggerClientEvent('hypex_ambulancejob:hypexreviveblack', v)
				end
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Za duży dystans :v (>500)")
		end
    end
end, true, {help = "Ożywia graczy w danym dystansie", validate = true, arguments = {
    {name = 'dist', help = "Odległość do reva", type = 'number'},
}})

ESX.RegisterCommand('spawn', {'trialsupport', 'support', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.targetid then
        local xPlayerTarget = ESX.GetPlayerFromId(args.targetid)
        if xPlayerTarget then
			xPlayerTarget.setCoords({x=-538.02, y=-217.01, z=36.69})
        end
    end
end, true, {help = "Teleportuj gracza na urząd", validate = true, arguments = {
    {name = 'targetid', help = "ID gracza", type = 'number'}
}})