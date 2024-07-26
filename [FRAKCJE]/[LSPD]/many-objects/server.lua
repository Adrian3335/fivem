AddEventHandler('chatMessage', function(source, n, msg)
	local msg = string.lower(msg)
	local identifier = GetPlayerIdentifiers(source)[1]
	
	if msg == '/cone' then
		CancelEvent()
		
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			TriggerClientEvent('murtaza:cone', source)
		end
		
	elseif msg == '/sbarrier' then
	
		CancelEvent()
		
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			TriggerClientEvent('murtaza:sbarrier', source)
		end
		
	elseif msg == '/barrier' then
	
		CancelEvent()
		
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			TriggerClientEvent('murtaza:barrier', source)
		end
		
	end
end)