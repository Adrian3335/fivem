local ActiveNotify = false

RegisterCommand('notifytest', function()
    exports['FC3.0-Hud']:Notify('Testowe powiadomienie he he he he he he he he he hehe', 5000)
end)

function SendNotify(text, timeout)
    while ActiveNotify do
        Citizen.Wait(500)
    end
    ActiveNotify = true
    SendNUIMessage({
        action = 'SendNotify',
        text = text,
        timeout = timeout
    })
end

exports('Notify', SendNotify)

RegisterNUICallback('EndNotify', function(data, cb)
    ActiveNotify = false
end)