ESX = exports.es_extended:getSharedObject()
RNE = RegisterNetEvent
AEH = AddEventHandler
TSE = TriggerServerEvent

RNE('inco-apartaments:EnterHouse')
AEH('inco-apartaments:EnterHouse', function()
    local ped = PlayerPedId()
    TSE('inco-apartaments:SetBucket', source, tonumber(GetPlayerServerId(PlayerId())))
    ESX.Game.Teleport(ped, {x = -786.9563, y = 315.6229, z =  187.9136, heading = 100.0}, function()
		Citizen.CreateThread(function()
			SetEntityVisible(ped, false)
			while true do
				Citizen.Wait(0)
		
				SetEntityLocallyVisible(ped)
			end
		end)
	end)
end)

RNE('inco-apartaments:ExitHouse')
AEH('inco-apartaments:ExitHouse', function()
    local ped = PlayerPedId()
    TSE('inco-apartaments:SetBucket', source, 0)
    ESX.Game.Teleport(ped, {x = -270.6097, y = -957.7933, z = 31.2251, heading = 293.3646}, function()
		Citizen.CreateThread(function()
			SetEntityVisible(ped, true)
			while true do
				Citizen.Wait(0)
		
				SetEntityLocallyVisible(ped)
			end
		end)
	end)
end)

exports['qtarget']:AddBoxZone("EnterAparty", vector3(-272.21, -958.46, 31.23), 2.0, 2.5, {
	name="EnterAparty",
	heading=25,
	debugPoly=false,
	minZ=31.03,
	maxZ=31.93,
	}, {
		options = {
			{
				event = "inco-apartaments:EnterHouse",
				icon = "fas fa-door-open",
				label = "Wejdź do mieszkania",
			},
		},
		distance = 3.5
})

exports['qtarget']:AddBoxZone("ExitAparty", vector3(-787.71, 315.74, 187.91), 2, 2, {
	name="ExitAparty",
	heading=11.0,
	minZ=-101.56,
	maxZ=-100.26,
	}, {
		options = {
			{
				event = "inco-apartaments:ExitHouse",
				icon = "fas fa-sign-in-alt",
				label = "Wyjdz z mieszkania",
			},
		},
		distance = 3.5
})

exports['qtarget']:AddBoxZone("ApartySzafka", vector3(-795.66, 328.93, 190.72), 1.4, 0.5, {
	name="ApartySzafka",
	heading=92,
	--debugPoly=false,
	minZ=-99.81,
	maxZ=-98.51,
	}, {
		options = {
			{
				action = function()
                    exports.ox_inventory:openInventory('stash', 'aparty_szafka')
                end,
				icon = "fas fa-box",
				label = "Otwórz Szafke",
			},
            {
				event = 'fivem-appearance:browseOutfits',
				icon = "fas fa-tshirt",
				label = "Zapisane Stroje",
			},
            {
				event = 'fivem-appearance:saveOutfit',
				icon = "fas fa-tshirt",
				label = "Zapisz Strój",
			},
            {
				event = 'fivem-appearance:deleteOutfitMenu',
				icon = "fas fa-tshirt",
				label = "Usuń Strój",
			},
		},
		distance = 2.0
})