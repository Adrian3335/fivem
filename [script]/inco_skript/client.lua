ESX = exports["es_extended"]:getSharedObject()
local PlayerData                = {}

-- removeradiostation

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
            if IsPedInAnyVehicle(PlayerPedId()) then
                SetUserRadioControlEnabled(false)
                if GetPlayerRadioStationName() ~= nil then
                SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId()),"OFF")
                end
        end
    end
end)

-- offdropWeapon

function RemoveWeaponDrops()
	RemoveAllPickupsOfType(14)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)      
        RemoveWeaponDrops();
    end
end)

-- mniej npc

DensityMultiplier = 0.15
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
	end
end)

-- offdefaultpoliceambulanceitp

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end
end)

SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))

SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))

-- afkcamoff

Citizen.CreateThread(function()
    while true do
        InvalidateIdleCam()
        InvalidateVehicleIdleCam()
        Wait(1000)
    end
end) 

-- engine

lib.onCache('ped', function(value)
    SetPedConfigFlag(value, 241, true) -- PED_FLAG_DISABLE_STOPPING_VEHICLE_ENGINE
    SetPedConfigFlag(value, 429, true) -- PED_FLAG_DISABLE_STARTING_VEHICLE_ENGINE
end)
  
lib.addKeybind({
    name = 'engine',
    description = 'Engine',
    defaultKey = 'Y',
    onPressed = function(self)
    if not cache.vehicle then
        return
    end
  
    if not cache.seat then
        return
    end
  
    if GetVehicleClass(cache.vehicle) == 13 then
        return
    end
  
    SetVehicleEngineOn(cache.vehicle, not GetIsVehicleEngineRunning(cache.vehicle), false, true)
    end
})

-- driveby

Citizen.CreateThread(function()
    local kmh = 50
    local playerId = PlayerId()
    while true do
        local wt = 200
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 then
            wt = 50
            if GetEntitySpeed(veh)*3.6 < kmh then
                SetPlayerCanDoDriveBy(playerId, true)
            else
                SetPlayerCanDoDriveBy(playerId, false)
            end
        end
        Citizen.Wait(wt)
    end
end)

-- cayo perico

local islandVec = vector3(4840.571, -5174.425, 2.0)
Citizen.CreateThread(function()
while true do
local pCoords = GetEntityCoords(GetPlayerPed(-1))
local distance1 = #(pCoords - islandVec)
if distance1 < 2000.0 then
Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", true) -- load the map and removes the city
Citizen.InvokeNative("0x5E1460624D194A38", true) -- load the minimap/pause map and removes the city minimap/pause map
else
Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", false)
Citizen.InvokeNative("0x5E1460624D194A38", false)
end
Citizen.Wait(5000)
end
end)