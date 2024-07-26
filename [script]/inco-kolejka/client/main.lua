local connected = false

AddEventHandler("playerSpawned", function()
	if not connected then
		TriggerServerEvent("ven_queue:playerConnected")
		connected = true
	end
end)