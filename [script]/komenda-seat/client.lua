ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('seat', function(src, args, raw)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if IsPedInAnyVehicle(ped) and IsVehicleSeatFree(vehicle, args[1]) then
        SetPedIntoVehicle(ped, vehicle, args[1])
        ESX.ShowNotification('~g~Zmieniono siedzenie')
    else
        ESX.ShowNotification('~r~Nie jesteś w pojeździe lub miejsce jest zajęte')
    end
end)
