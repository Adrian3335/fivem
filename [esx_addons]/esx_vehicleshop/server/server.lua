--------------------------------------------------------------------
-------------------------Converted by ex#1515-----------------------
--------------------------------------------------------------------

ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('eotix-vehicleshop:requestInfo')
AddEventHandler('eotix-vehicleshop:requestInfo', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local rows    

    TriggerClientEvent('eotix-vehicleshop:receiveInfo', src, xPlayer.getMoney())
    TriggerClientEvent("eotix-vehicleshop:notify", src, 'error', 'Use A and D To Rotate')
end)

ESX.RegisterServerCallback('eotix-vehicleshop:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)




-- Double checking on the money, if you do not have it in the inventory, look at the bank 
RegisterServerEvent('eotix-vehicleshop:CheckMoneyForVeh')
AddEventHandler('eotix-vehicleshop:CheckMoneyForVeh', function(veh, price, name, vehicleProps)
	local _source = source
	local src = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= tonumber(price) then
		xPlayer.removeMoney(tonumber(price))
		if Config.SpawnVehicle then
			stateVehicle = 0
		else
			stateVehicle = 1
		end

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps)
		}, function (rowsChanged)
			
			TriggerClientEvent("eotix-vehicleshop:successfulbuy", _source, name, vehicleProps.plate, price)
			TriggerClientEvent('eotix-vehicleshop:receiveInfo', _source, xPlayer.getMoney())   
			TriggerClientEvent('eotix-vehicleshop:spawnVehicle', _source, veh, vehicleProps.plate)
		end)
	elseif xPlayer.getAccount('bank').money >= tonumber(price) then
		xPlayer.removeAccountMoney('bank',tonumber(price))
		if Config.SpawnVehicle then
			stateVehicle = 0
		else
			stateVehicle = 1
		end

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps)
		}, function (rowsChanged)
			
			TriggerClientEvent("eotix-vehicleshop:successfulbuy", _source, name, vehicleProps.plate, price)
			TriggerClientEvent('eotix-vehicleshop:receiveInfo', _source, xPlayer.getMoney())   
			TriggerClientEvent('eotix-vehicleshop:spawnVehicle', _source, veh, vehicleProps.plate)
		end)
	else
		 TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Not Enough Money'})
	end
end)