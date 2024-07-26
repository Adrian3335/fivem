ESX = exports["es_extended"]:getSharedObject()

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

MdtOpened = false
local tabletEntity = nil
local tabletModel = "prop_cs_tablet"
local tabletDict = "amb@world_human_seat_wall_tablet@female@base"
local tabletAnim = "base"

function startTabletAnimation()
	Citizen.CreateThread(function()
	  	RequestAnimDict(tabletDict)
		while not HasAnimDictLoaded(tabletDict) do
			Citizen.Wait(0)
		end
		attachObject()
		TaskPlayAnim(PlayerPedId(), tabletDict, tabletAnim, 8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end

function attachObject()
	if tabletEntity == nil then
		Citizen.Wait(380)
		RequestModel(tabletModel)
		while not HasModelLoaded(tabletModel) do
			Citizen.Wait(1)
		end
		tabletEntity = CreateObject(GetHashKey(tabletModel), 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(tabletEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, 0.10, -0.13, 25.0, 170.0, 160.0, true, true, false, true, 1, true)
	end
end

function stopTabletAnimation()
	if tabletEntity ~= nil then
		StopAnimTask(PlayerPedId(), tabletDict, tabletAnim ,8.0, -8.0, -1, 50, 0, false, false, false)
		DeleteEntity(tabletEntity)
		tabletEntity = nil
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	if(ESX.PlayerData.job.name == 'ambulance') then
		TriggerServerEvent('esx_emsmdt:UpdateAmbulanceStatus', 'insert')
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if(ESX.PlayerData.job.name == 'ambulance') then
		TriggerServerEvent('esx_emsmdt:UpdateAmbulanceStatus', 'insert')
	else
		TriggerServerEvent('esx_emsmdt:UpdateAmbulanceStatus', 'remove')
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
			if IsControlJustPressed(0, Keys["DELETE"]) then
				OpenAmbulanceMDT()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('igorowy:emsmdt', function()
	OpenAmbulanceMDT()
end)

function OpenAmbulanceMDT()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
		if(MdtOpened == false) then
			MdtOpened = true
			startTabletAnimation()
			SetCursorLocation(0.5, 0.5)
			SetNuiFocus(true, true)
			SendNUIMessage({action = 'OpenMDT'})
			TriggerServerEvent('esx_emsmdt:SendMdtData')
		end
	else
		Citizen.Wait(500)
	end
end

RegisterNetEvent("esx_emsmdt:SendMdtData")
AddEventHandler("esx_emsmdt:SendMdtData", function(data)
	if data then
		NotepadData = data['Notepad']
		SendNUIMessage({action = 'SendMDTdata', mdtdata = data})
	end
end)

RegisterNUICallback('UpdateNotepad', function(data)
	if data.note ~= NotepadData then
		TriggerServerEvent('esx_emsmdt:UpdateNotepad', data.note)
	end
end)

RegisterNUICallback('SendAnnounce', function(data, cb)
	if(data.text ~= "") then
		ESX.TriggerServerCallback("esx_emsmdt:SendAnnounce", function(announcedata)
			cb(announcedata)
		end, data.text)
	end
end)

RegisterNUICallback('RemoveAnnounce', function(data)
	TriggerServerEvent('esx_emsmdt:RemoveAnnounce', data)
end)

RegisterNUICallback('SendRaport', function(data, cb)
	if(data.text ~= "") then
		ESX.TriggerServerCallback("esx_emsmdt:SendRaport", function(raportdata)
			cb(raportdata)
		end, data.text)
	end
end)

RegisterNUICallback('RemoveRaport', function(data)
	TriggerServerEvent('esx_emsmdt:RemoveRaport', data)
end)

RegisterNUICallback('WystawFakture', function(data)
	TriggerServerEvent('esx_emsmdt:WystawFakture', data)
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

RegisterNUICallback('SearchPersonKartaPacjenta', function(data, cb)
	ESX.TriggerServerCallback("esx_emsmdt:SearchPersonKartaPacjenta", function(persondata)
		cb(persondata)
	end, data)
end)

RegisterNUICallback('PersonMoreInfo', function(data, cb)
	ESX.TriggerServerCallback("esx_emsmdt:PersonMoreInfo", function(moreinfodata)
		cb(moreinfodata)
	end, data)
end)

RegisterNUICallback('AddNotatkaKarta', function(data, cb)
	ESX.TriggerServerCallback('esx_emsmdt:AddNotatkaKarta', function(notedata)
		cb(notedata)
	end, data)
end)

RegisterNUICallback('RemoveFakturaKarta', function(data)
	TriggerServerEvent('esx_emsmdt:RemoveFakturaKarta', data)
end)

RegisterNUICallback('RemoveNotatkiKarta', function(data)
	TriggerServerEvent('esx_emsmdt:RemoveNotatkiKarta', data)
end)


RegisterNUICallback('licencjaDodaj', function(data)
	TriggerServerEvent('esx_emsmdt:licencjaDodaj', data)
end)

RegisterNUICallback('licencjaUsun', function(data)
	TriggerServerEvent('esx_emsmdt:licencjaUsun', data)
end)

RegisterNUICallback('mdtclose', function()
	MdtOpened = false
	SetNuiFocus(false, false)
	stopTabletAnimation()
end)