ESX = exports["es_extended"]:getSharedObject()

local MinigameActive = false
local MinigameFinished = false
local SuccessTrigger = nil
local FailTrigger = nil
local Success = false

function StartMazeBank2(cb)
        if MinigameActive then return end
    
            SetNuiFocus(true, true)
            SendNUIMessage({type = 'otworz'})
            MinigameActive = true
            MinigameFinished = false
    
            while MinigameActive do
                Citizen.Wait(500)
            end
    
            if cb then
                cb(Success)
            end
    
            return Success
        end
    
exports('StartMazeBank2', StartMazeBank2)


RegisterNUICallback('udane', function(data, cb)
    SetNuiFocus(false, false)
    Success = true
    MinigameFinished = false
    MinigameActive = false
    cb('ok')
end)

RegisterNUICallback('nieudane', function(data, cb)
    SetNuiFocus(false, false)
    MinigameActive = false
    Success = false
    cb('ok')
end)

RegisterCommand('startmaze2', function()
local success = exports['mazebank_door']:StartMazeBank2()
if success then
    ESX.ShowNotification('Udane')
elseif not success then
ESX.ShowNotification('Nie Udane')
end
end)

