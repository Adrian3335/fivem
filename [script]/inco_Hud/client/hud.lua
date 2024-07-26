ESX = exports['es_extended']:getSharedObject()
local directions = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"}
local inVeh = false
local CinemaMode = false
local UiHidden = false
local ActiveProgress = false
local show = true
local speedMultipler = 3.6
local speedUnit = "KMH"

if Config.SpeedUnit == "MPH" then
    speedMultipler = 2.236936
    speedUnit = "MPH"
elseif Config.SpeedUnit == "KMH" then
    speedMultipler = 3.6
    speedUnit = "KMH"
else
    speedMultipler = 2.236936
    speedUnit = "MPH"
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    SendNUIMessage({action = 'ShowHud'})
    Wait(100)
    SetRadarBigmapEnabled(Config.BigMinimapBug, false)
    Wait(100)
    SetRadarBigmapEnabled(false, false)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterCommand('hud', function()
    local IsPolice = false
    if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'offpolice' then
        IsPolice = true
    end
    SendNUIMessage({action = 'OpenEditHud', ispolice = IsPolice})
    SetNuiFocus(true, true)
end)

RegisterNUICallback('CloseEditHud', function(data, cb)
    SetNuiFocus(false, false)
end)

lib.onCache('vehicle', function(value)
    if value then
        inVeh = true
        StartLoop()
    else
        inVeh = false
        SendNUIMessage({action = 'HideCarHud'})
    end
end)

function StartLoop()
    Citizen.CreateThread(function()
        while inVeh do
            local Coords = GetEntityCoords(PlayerPedId())
            local PedCar = GetVehiclePedIsUsing(PlayerPedId(), false)
            local Speed = math.floor(GetEntitySpeed(PedCar) * 2.236936)
            local Street = GetStreetNameAtCoord(Coords.x, Coords.y, Coords.z)
            local Fuel = GetVehicleFuelLevel(PedCar)
            local heading = 360.0 - ((GetGameplayCamRot(0).z + 360.0) % 360.0)
            SendNUIMessage({
                action = 'UpdateCarHud',
                speed = Speed,
                street = GetStreetNameFromHashKey(Street),
                direction = Direction(heading),
                fuel = Fuel,
            })
            Citizen.Wait(500)
        end
    end)
end

function Direction(heading)
    return directions[(math.floor((heading / 45) + 0.5) % 8) + 1];
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(400)
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)
        local state = NetworkIsPlayerTalking(PlayerId())
        SendNUIMessage({
            action = 'UpdateHud',
            hunger = hunger,
            water = thirst,
            health = GetEntityHealth(PlayerPedId()) - 100,
            armor = GetPedArmour(PlayerPedId()),
            microphone = LocalPlayer.state.proximity.mode,
            state = state
        })
    end
end)

Citizen.CreateThread(function()
    RequestStreamedTextureDict("squaremap", false)
    while not HasStreamedTextureDictLoaded("squaremap") do
        Wait(100)
    end

    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")

    SetMinimapClipType(0)
    SetMinimapComponentPosition("minimap", "L", "B", 0.0215, -0.03, 0.163, 0.225)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.095, 0.25, 0.193, 0.264)
    SetMinimapComponentPosition("minimap_blur", "L", "B", 0.0111, 0.020, 0.248, 0.317)

    SetBlipAlpha(GetNorthRadarBlip(), 0.0)
    SetBlipScale(GetMainPlayerBlipId(), 0.7)

    local minimap = RequestScaleformMovie("minimap")

    SetRadarBigmapEnabled(false, false)
    Citizen.Wait(100)
    SetRadarBigmapEnabled(false, false)

    Citizen.Wait(1000)
end)

RegisterNUICallback('CinemaModeOn', function(data, cb)
    CinemaMode = true
    Radar(2)
end)

RegisterNUICallback('CinemaModeOff', function(data, cb)
    CinemaMode = false
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        Radar(1)
    else
        Radar(2)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300)
        local inVeh = IsPedInAnyVehicle(PlayerPedId(), false)
        local inMenu = IsPauseMenuActive()
        if inMenu and not UiHidden and not inVeh then

            UiHidden = true
            SendNUIMessage({action = 'ToggleHud', value = 'off', incar = false})
            
        elseif not inMenu and UiHidden and not inVeh then

            SendNUIMessage({action = 'ToggleHud', value = 'on', incar = false})
            UiHidden = false

        elseif inMenu and not UiHidden and inVeh then

            SendNUIMessage({action = 'ToggleHud', value = 'off', incar = true})
            UiHidden = true

        elseif not inMenu and UiHidden and inVeh then

            SendNUIMessage({action = 'ToggleHud', value = 'on', incar = true})
            UiHidden = false

        end
    end
end)

CreateThread(function()
	while true do
        local sleep = Config.TickOutsideVehicle
        if IsPauseMenuActive() then
            SendNUIMessage({
                process = 'hide';
            })
		elseif IsPedInAnyVehicle(PlayerPedId()) and show then
            sleep = Config.TickInVehicle
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            local speed = (GetEntitySpeed(veh)*speedMultipler) -- mph - *2.236936, kmh - *3.6
            local rpm = GetVehicleCurrentRpm(veh)
            local rpmPercent = rpm * 100
            local fuel = GetVehicleFuelLevel(veh)

            local coords = GetEntityCoords(veh)
            local var = GetStreetNameAtCoord(coords.x, coords.y, coords.y)
            local street = GetStreetNameFromHashKey(var)
        
            local heading = directions[math.floor((GetEntityHeading(PlayerPedId()) + 22.5) / 45.0)]

            SendNUIMessage({
                process = 'show',
                unit = speedUnit,
                speedLevel = speed,
                rpmLevel = rpmPercent,
                fuel = fuel,
                streetName = street,
                heading = heading
            })
            DisplayRadar(true)
        else
            DisplayRadar(false)
            SendNUIMessage({
                process = 'hide';
            })
        end
        Wait(sleep)
	end
end)

RegisterNUICallback("getPlayerId", function(data, cb)
    cb(GetPlayerServerId(PlayerId()))
end)