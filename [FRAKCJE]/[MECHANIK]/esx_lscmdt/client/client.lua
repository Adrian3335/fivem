local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = exports["es_extended"]:getSharedObject()


MdtOpened = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	if(ESX.PlayerData.job.name == 'mechanic') then
		TriggerServerEvent('esx_lscmmdt:UpdateMechanicStatus', 'insert')
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if(ESX.PlayerData.job.name == 'mechanic') then
		TriggerServerEvent('esx_lscmmdt:UpdateMechanicStatus', 'insert')
	else
		TriggerServerEvent('esx_lscmmdt:UpdateMechanicStatus', 'remove')
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('knut:lscmdt', function()
	OpenPoliceMDT()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mechanic' then
			if IsControlJustPressed(0, Keys["DELETE"]) then
				OpenPoliceMDT()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function OpenPoliceMDT()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mechanic' then
		if(MdtOpened == false) then
			MdtOpened = true
			SetCursorLocation(0.5, 0.5)
			SetNuiFocus(true, true)
			SendNUIMessage({action = 'OpenMDT'})
			TriggerServerEvent('esx_lscmmdt:SendMdtData')
		end
	else
		Citizen.Wait(500)
	end
end

RegisterNetEvent("esx_lscmmdt:SendMdtData")
AddEventHandler("esx_lscmmdt:SendMdtData", function(data)
	if data then
		NotepadData = data['Notepad']
		SendNUIMessage({action = 'SendMDTdata', mdtdata = data})
	end
end)

RegisterNUICallback('UpdateNotepad', function(data)
	if data.note ~= NotepadData then
		TriggerServerEvent('esx_lscmdt:UpdateNotepad', data.note)
	end
end)

RegisterNUICallback('SendAnnounce', function(data, cb)
	if(data.text ~= "") then
		ESX.TriggerServerCallback("esx_lscmdt:SendAnnounce", function(announcedata)
			cb(announcedata)
		end, data.text)
	end
end)

RegisterNUICallback('RemoveAnnounce', function(data)
	TriggerServerEvent('esx_lscmdt:RemoveAnnounce', data)
end)

RegisterNUICallback('SendRaport', function(data, cb)
	if(data.text ~= "") then
		ESX.TriggerServerCallback("esx_lscmdt:SendRaport", function(raportdata)
			cb(raportdata)
		end, data.text)
	end
end)

RegisterNUICallback('RemoveRaport', function(data)
	TriggerServerEvent('esx_lscmdt:RemoveRaport', data)
end)

RegisterNUICallback('WystawFakture', function(data)
	TriggerServerEvent('esx_lscmdt:WystawFakture', data)
end)

RegisterNUICallback('NearbyPlayers', function(data, cb)
	local coords = GetEntityCoords(PlayerPedId(), true)
	local players = {}
	for _, player in ipairs(ESX.Game.GetPlayers(true)) do
		local target = GetPlayerPed(player)
		if #(GetEntityCoords(target, true) - coords) <= 10 then
			local pid = GetPlayerServerId(player)
			if pid then
				table.insert(players, {
					type = 'players',
					name = pid
				})
			end
		end
	end
	cb(players)
end)

RegisterNUICallback('SearchPersonKartaPojazdu', function(data, cb)
	ESX.TriggerServerCallback("esx_lscmdt:SearchPersonKartaPojazdu", function(persondata)
		cb(persondata)
	end, data)
end)

RegisterNUICallback('AddNotatkaKartaPojazdu', function(data, cb)
	ESX.TriggerServerCallback('esx_lscmdt:AddNotatkaKartaPojazdu', function(notedata)
		cb(notedata)
	end, data)
end)

RegisterNUICallback('RemoveNotatkiKartaPojazdu', function(data)
	TriggerServerEvent('esx_lscmdt:RemoveNotatkaKartaPojazdu', data)
end)

RegisterNUICallback('RemoveFakturaKarta', function(data)
	TriggerServerEvent('esx_lscmdt:RemoveFakturaKarta', data)
end)

RegisterNUICallback('PersonMoreInfo', function(data, cb)
	ESX.TriggerServerCallback("esx_lscmdt:PersonMoreInfo", function(moreinfodata)
		cb(moreinfodata)
	end, data)
end)

RegisterNUICallback('licencjaDodaj', function(data)
	TriggerServerEvent('esx_lscmdt:licencjaDodaj', data)
end)

RegisterNUICallback('licencjaUsun', function(data)
	TriggerServerEvent('esx_lscmdt:licencjaUsun', data)
end)


RegisterNUICallback('mdtclose', function()
	MdtOpened = false
	SetNuiFocus(false, false)
end)