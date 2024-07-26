ESX = exports["es_extended"]:getSharedObject()

local MinigameActive = false
local MinigameFinished = false
local SuccessTrigger = nil
local FailTrigger = nil
local Success = false

function StartNumerki(cb)
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
    
    exports('StartNumerki', StartNumerki)


RegisterCommand('numbergame', function()

        SendNUIMessage({type = 'otworz'})
        SetNuiFocus(true, true)
end)

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