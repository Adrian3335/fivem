mhackingCallback = {}
showHelp = false
helpTimer = 0
helpCycle = 4000

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if showHelp then
			if helpTimer > GetGameTimer() then
				showHelpText("Kieruj ~p~W,A,S,D~s~ i potwierdzaj swój wybór ~p~Spacja~s~")
			elseif helpTimer > GetGameTimer()-helpCycle then
				showHelpText("Użyj ~p~Strzałek~s~ i ~p~ENTER~s~ aby zhackować")
			else
				helpTimer = GetGameTimer()+helpCycle
			end
			if IsEntityDead(PlayerPedId()) then
				nuiMsg = {}
				nuiMsg.fail = true
				SendNUIMessage(nuiMsg)
			end
		end
	end
end)

function showHelpText(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end

AddEventHandler('mhacking:show', function()
    nuiMsg = {}
	nuiMsg.show = true
	SendNUIMessage(nuiMsg)
	SetNuiFocus(true, false)
end)

AddEventHandler('mhacking:hide', function()
    nuiMsg = {}
	nuiMsg.show = false
	SendNUIMessage(nuiMsg)
	SetNuiFocus(false, false)
	showHelp = false
end)

AddEventHandler('mhacking:start', function(solutionlength, duration, callback)
    mhackingCallback = callback
	nuiMsg = {}
	nuiMsg.s = solutionlength
	nuiMsg.d = duration
	nuiMsg.start = true
	SendNUIMessage(nuiMsg)
	showHelp = true
end)

AddEventHandler('mhacking:setmessage', function(msg)
    nuiMsg = {}
	nuiMsg.displayMsg = msg
	SendNUIMessage(nuiMsg)
end)

RegisterNUICallback('callback', function(data, cb)
	mhackingCallback(data.success, data.remainingtime)
    cb('ok')
end)