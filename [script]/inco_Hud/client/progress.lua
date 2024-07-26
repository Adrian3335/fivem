local Complete = false

Citizen.CreateThread(function()
    while true do
        sleep = 1000
        if ActiveProgress then
            sleep = 10
            if IsControlJustPressed(0, 73) then
                ActiveProgress = false
                Complete = false
                SendNUIMessage({action = 'CancelProgress'})
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNUICallback('ProgBarComplete', function(data, cb)
    if ActiveProgress then
        Complete = true
        Wait(100)
        ActiveProgress = false
    end
end)

function CreateProgressBar(time, label)
    if ActiveProgress then return end

    SendNUIMessage({
        action = 'CreateProgress', 
        time = time, 
        label = label
    })

    ActiveProgress = true

    while ActiveProgress do
        Citizen.Wait(500)
    end

    return Complete
end

exports('Progress', CreateProgressBar)

RegisterCommand('progbartest', function()
    local progbar = exports['FC3.0-Hud']:Progress(5000, 'Szukanie...')
    if progbar then
        print('Udane')
    else
        print('Nieudane')
    end
end)