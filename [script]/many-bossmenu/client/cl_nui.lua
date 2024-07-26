RegisterNUICallback('chiudi',function()
    SendNUIMessage({azione = 'BossMenuChiudi'})
    SetNuiFocus(false,false)
end)

-- NUI

RegisterNUICallback("promuovi",function(data, cb)
    if data.identifier ~= ESX.GetPlayerData().identifier then
        TriggerServerEvent("nxn_bossmenu:promuovi", data.identifier)
    else
        ESX.ShowNotification("Nie możesz tego zrobić na sobie!")
    end
end)

RegisterNUICallback("degrada",function(data, cb)
    if data.identifier ~= ESX.GetPlayerData().identifier then
        TriggerServerEvent("nxn_bossmenu:degrada", data.identifier)
    else
        ESX.ShowNotification("Nie możesz tego zrobić na sobie!")
    end
end)

RegisterNUICallback("licenzia",function(data, cb)
    if data.identifier ~= ESX.GetPlayerData().identifier then
        TriggerServerEvent("nxn_bossmenu:licenzia", data.identifier)
    else
        ESX.ShowNotification("Nie możesz tego zrobić na sobie!")
    end
end)

RegisterNUICallback("getSoldiSporchi",function(data,cb)
    ESX.TriggerServerCallback('nxn_bossmenu:getBlackMoney',function(soldiSp)
        cb({soldi = tostring(soldiSp)})
    end)
end)

RegisterNUICallback("preleva",function(data,cb)
    if tonumber(data.importo) then
        if data.tipo == 'Puliti' then
            TriggerServerEvent("nxn_bossmenu:preleva", {tipo = data.tipo, importo = data.importo})
        else
            TriggerServerEvent("nxn_bossmenu:preleva", {tipo = 'Negro', importo = data.importo})
        end
    end
end)

RegisterNUICallback("deposita",function(data,cb)
    if tonumber(data.importo) then
        if data.tipo == 'Puliti' then
            TriggerServerEvent("nxn_bossmenu:deposita", {tipo = data.tipo, importo = data.importo})
        else
            TriggerServerEvent("nxn_bossmenu:deposita", {tipo = 'Negro', importo = data.importo})
        end
    end
end)

RegisterNUICallback("assumiVicino",function()
    local p, pdist = ESX.Game.GetClosestPlayer()
    if p ~= -1 and pdist <= 3.0 then
        TriggerServerEvent("nxn_bossmenu:assumi", GetPlayerServerId(p))
    else
        SendNUIMessage({azione = 'Notifica', msg = BossMenu.Lang['no_player_vicini']})
    end
end)

RegisterNetEvent('nxn_bossmenu:notifiche',function(msg)
    SendNUIMessage({azione = 'Notifica', msg = msg})
end)