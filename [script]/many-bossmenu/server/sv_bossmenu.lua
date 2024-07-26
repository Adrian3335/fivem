GetSocietyMoney = function(job)   
    local res = MySQL.Sync.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @nomeAC', {['@nomeAC'] = 'society_'..job})[1]
    return res
end

local JobSecondario = {}

function Notifica(t, msg)
    TriggerClientEvent("nxn_bossmenu:notifiche",t.source, msg)
end

ESX.RegisterServerCallback('nxn_bossmenu:getSocietyAndPlayerInfo',function(source, cb, fazione, job)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Players = {}
    local GiocOn = {}
    local GiocOff = {}
    local id = 0
    local soldiSocieta
    if fazione then
        JobSecondario[source] = true
        MySQL.Async.fetchAll('SELECT * FROM users WHERE job2 = @jobPlayer', {['@jobPlayer'] = job},function(res)
            print(res)
            if res[1] then
                for k,v in pairs(res) do
                    local xBossMenu = ESX.GetPlayerFromIdentifier(v.identifier)
                    if xBossMenu ~= nil then
                        table.insert(GiocOn, v.identifier)
                        table.insert(Players, {
                            nome = v.firstname,
                            cognome = v.lastname,
                            identifier = v.identifier,
                            id = xBossMenu.source,
                            grado = xBossMenu.getJob().grade,
                            colore = 'linear-gradient(137deg, rgba(120,120,120,0.5242471988795518) 0%, rgba(0,0,0,0) 100%)',
                        })
                    else
                        id = id + 1
                        if id == xPlayer.source then
                            id = id + 1
                        end
                        table.insert(GiocOff, v.identifier)
                        table.insert(Players, {
                            nome = v.firstname,
                            cognome = v.lastname,
                            identifier = v.identifier,
                            id = id,
                            grado = v.job2_grade,
                            colore = 'linear-gradient(137deg, rgba(141, 0, 0, 0.322) 0%, rgba(102, 0, 0, 0) 100%)',
                        })
                    end
                end
                soldiSocieta = GetSocietyMoney(job).money
                cb(Players, #GiocOff, #GiocOn, soldiSocieta,GetSocietyMoney(job).soldi_sporchi)
            else
                print('Wystąpił błąd [MANY-BOSSMENU]')
            end
        end)
    else
        JobSecondario[source] = false
        MySQL.Async.fetchAll('SELECT * FROM users WHERE job = @jobPlayer', {['@jobPlayer'] = job},function(res)
            if res[1] then              
                for k,v in pairs(res) do
                    local xBossMenu = ESX.GetPlayerFromIdentifier(v.identifier)
                    print(XBossMenu)
                    if xBossMenu ~= nil then
                        table.insert(GiocOn, v.identifier)
                        table.insert(Players, {
                            nome = v.firstname,
                            cognome = v.lastname,
                            identifier = v.identifier,
                            id = xBossMenu.source,
                            grado = xBossMenu.getJob().grade,
                            colore = 'linear-gradient(137deg, rgba(120,120,120,0.5242471988795518) 0%, rgba(0,0,0,0) 100%)',
                        })
                    else
                        id = id + 1
                        if id == xPlayer.source then
                            id = id + 1
                        end
                        table.insert(GiocOff, v.identifier)
                        table.insert(Players, {
                            nome = v.firstname,
                            cognome = v.lastname,
                            identifier = v.identifier,
                            id = id,
                            grado = v.job_grade,
                            colore = 'linear-gradient(137deg, rgba(141, 0, 0, 0.322) 0%, rgba(102, 0, 0, 0) 100%)',
                        })
                    end
                end
                soldiSocieta = GetSocietyMoney(job).money
                cb(Players, #GiocOff, #GiocOn, soldiSocieta,GetSocietyMoney(job).soldi_sporchi)
            else
                print('Wystąpił błąd [MANY-BOSSMENU]')
            end
        end)
    end
end)

ESX.RegisterServerCallback('nxn_bossmenu:getBlackMoney',function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if JobSecondario[source] then
        cb(GetSocietyMoney(xPlayer.getJob2().name).soldi_sporchi)
    else
        cb(GetSocietyMoney(xPlayer.getJob().name).soldi_sporchi)
    end
end)

RegisterServerEvent('nxn_bossmenu:promuovi',function(ide)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromIdentifier(ide)
    if JobSecondario[source] then
        if xTarget ~= nil then
            if ESX.DoesJobExist(xPlayer.getJob2().name, xTarget.getJob2().grade + 1) then
                xTarget.setJob2(xPlayer.getJob2().name, xTarget.getJob2().grade + 1)
                MySQL.update('UPDATE users SET job2 = @lavoro,job2_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob2().name, ['@grado'] = xTarget.getJob2().grade, ['@ide'] = xTarget.identifier})
                xTarget.showNotification(BossMenu.Lang['sei_stato_uppato']:format(xTarget.getJob2().grade_label, xPlayer.getJob2().label, xPlayer.getName()))
                Notifica(xPlayer, BossMenu.Lang['hai_uppato']:format(xTarget.getName(), xTarget.getJob2().grade_label, xPlayer.getJob2().label))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
            else
                print('[^4MANY-BOSSMENU^0] Błąd, ranga nie istnieje!')
                return
            end
        else
            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = ide},function(res)
                if ESX.DoesJobExist(xPlayer.getJob2().name, res[1].job2_grade + 1) then
                    MySQL.update('UPDATE users SET job2 = @lavoro,job2_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob2().name, ['@grado'] = res[1].job2_grade + 1, ['@ide'] = ide})
                    Wait(300)
                    TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
                    Notifica(xPlayer, BossMenu.Lang['hai_uppato']:format(res[1].firstname.. " ".. res[1].lastname, '', xPlayer.getJob2().label))
                end
            end)
        end
    else
        if xTarget ~= nil then
            if ESX.DoesJobExist(xPlayer.getJob().name, xTarget.getJob().grade + 1) then
                xTarget.setJob(xPlayer.getJob().name, xTarget.getJob().grade + 1)
                MySQL.update('UPDATE users SET job = @lavoro,job_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob().name, ['@grado'] = xTarget.getJob().grade, ['@ide'] = xTarget.identifier})
                xTarget.showNotification(BossMenu.Lang['sei_stato_uppato']:format(xTarget.getJob().grade_label, xPlayer.getJob().label, xPlayer.getName()))
                Notifica(xPlayer, BossMenu.Lang['hai_uppato']:format(xTarget.getName(), xTarget.getJob().grade_label, xPlayer.getJob().label))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
            else
                print('[^4MANY-BOSSMENU^0] Błąd, ranga nie istnieje!')
                return
            end
        else
            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = ide},function(res)
                if ESX.DoesJobExist(xPlayer.getJob().name, res[1].job_grade + 1) then
                    MySQL.update('UPDATE users SET job = @lavoro,job_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob().name, ['@grado'] = res[1].job_grade + 1, ['@ide'] = ide})
                    Wait(300)
                    TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
                    Notifica(xPlayer, BossMenu.Lang['hai_uppato']:format(res[1].firstname.. " ".. res[1].lastname, '', xPlayer.getJob().label))
                end
            end)
        end
    end 
end)

RegisterServerEvent('nxn_bossmenu:degrada',function(ide)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromIdentifier(ide)
    if JobSecondario[source] then
        if xTarget ~= nil then
            if ESX.DoesJobExist(xPlayer.getJob2().name, xTarget.getJob2().grade - 1) then
                xTarget.setJob2(xPlayer.getJob2().name, xTarget.getJob2().grade - 1)
                MySQL.update('UPDATE users SET job2 = @lavoro,job2_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob2().name, ['@grado'] = xTarget.getJob2().grade, ['@ide'] = xTarget.identifier})
                xTarget.showNotification(BossMenu.Lang['sei_stato_degradato']:format(xTarget.getJob2().grade_label, xPlayer.getJob2().label, xPlayer.getName()))
                Notifica(xPlayer, BossMenu.Lang['hai_degradato']:format(xTarget.getName(), xTarget.getJob2().grade_label, xPlayer.getJob2().label))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
            else
                print('[^4MANY-BOSSMENU^0] Błąd, ranga nie istnieje!')
                return
            end
        else
            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = ide},function(res)
                if ESX.DoesJobExist(xPlayer.getJob2().name, res[1].job2_grade - 1) then
                    MySQL.update('UPDATE users SET job2 = @lavoro,job2_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob2().name, ['@grado'] = res[1].job2_grade - 1, ['@ide'] = ide})
                    Wait(300)
                    TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
                    Notifica(xPlayer, BossMenu.Lang['hai_degradato']:format(res[1].firstname.. " ".. res[1].lastname, '', xPlayer.getJob2().label))
                end
            end)
        end
    else
        if xTarget ~= nil then
            if ESX.DoesJobExist(xPlayer.getJob().name, xTarget.getJob().grade - 1) then
                xTarget.setJob(xPlayer.getJob().name, xTarget.getJob().grade - 1)
                MySQL.update('UPDATE users SET job = @lavoro,job_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob().name, ['@grado'] = xTarget.getJob().grade - 1, ['@ide'] = xTarget.identifier})
                xTarget.showNotification(BossMenu.Lang['sei_stato_degradato']:format(xTarget.getJob().grade_label, xPlayer.getJob().label, xPlayer.getName()))
                Notifica(xPlayer, BossMenu.Lang['hai_degradato']:format(xTarget.getName(), xTarget.getJob().grade_label, xPlayer.getJob().label))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
            else
                print('[^4MANY-BOSSMENU^0] Błąd, ranga nie istnieje!')
                return
            end
        else
            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = ide},function(res)
                if ESX.DoesJobExist(xPlayer.getJob().name, res[1].job_grade - 1) then
                    MySQL.update('UPDATE users SET job = @lavoro,job_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob().name, ['@grado'] = res[1].job_grade - 1, ['@ide'] = ide})
                    Wait(300)
                    TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
                    Notifica(xPlayer, BossMenu.Lang['hai_degradato']:format(res[1].firstname.. " ".. res[1].lastname, '', xPlayer.getJob().label))
                end
            end)
        end
    end
end)

RegisterServerEvent('nxn_bossmenu:licenzia',function(ide)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromIdentifier(ide)
    if JobSecondario[source] then
        if xTarget ~= nil then
            if ESX.DoesJobExist(BossMenu.JobDisoccupato, BossMenu.GradoDisoccupato) then
                xTarget.setJob2(BossMenu.JobDisoccupato, BossMenu.GradoDisoccupato)
                MySQL.update('UPDATE users SET job2 = @lavoro,job2_grade = @grado WHERE identifier = @ide', {['@lavoro'] = BossMenu.JobDisoccupato, ['@grado'] = BossMenu.GradoDisoccupato, ['@ide'] = xTarget.identifier})
                xTarget.showNotification(BossMenu.Lang['sei_stato_licenziato']:format(xPlayer.getName(), xPlayer.getJob2().label))
                Notifica(xPlayer,BossMenu.Lang['hai_licenziato']:format(xTarget.getName(), xPlayer.getJob2().label))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
            else
                print('[^4MANY-BOSSMENU^0] Błąd, stopień i bezrobotna praca nie istnieje. Sprawdź Config')
            end
        else
            if ESX.DoesJobExist(BossMenu.JobDisoccupato, BossMenu.GradoDisoccupato) then
                MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = ide},function(res)
                    MySQL.update('UPDATE users SET job2 = @lavoro,job2_grade = @grado WHERE identifier = @ide', {['@lavoro'] = BossMenu.JobDisoccupato, ['@grado'] = BossMenu.GradoDisoccupato, ['@ide'] = ide})
                    Wait(300)
                    TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
                    Notifica(xPlayer, BossMenu.Lang['hai_licenziato']:format(res[1].firstname.. " ".. res[1].lastname, xPlayer.getJob2().label))
                end)
            end
        end
    else
        if xTarget ~= nil then
            if ESX.DoesJobExist(BossMenu.JobDisoccupato, BossMenu.GradoDisoccupato) then
                xTarget.setJob(BossMenu.JobDisoccupato, BossMenu.GradoDisoccupato)
                MySQL.update('UPDATE users SET job = @lavoro,job_grade = @grado WHERE identifier = @ide', {['@lavoro'] = BossMenu.JobDisoccupato, ['@grado'] = BossMenu.GradoDisoccupato, ['@ide'] = xTarget.identifier})
                xTarget.showNotification(BossMenu.Lang['sei_stato_licenziato']:format(xPlayer.getName(), xPlayer.getJob().label))
                Notifica(xPlayer,BossMenu.Lang['hai_licenziato']:format(xTarget.getName(), xPlayer.getJob().label))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
            else
                print('[^4MANY-BOSSMENU^0] Błąd, stopień i bezrobotna praca nie istnieje. Sprawdź Config')
            end
        else
            if ESX.DoesJobExist(BossMenu.JobDisoccupato, BossMenu.GradoDisoccupato) then
                MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = ide},function(res)
                    MySQL.update('UPDATE users SET job = @lavoro,job_grade = @grado WHERE identifier = @ide', {['@lavoro'] = BossMenu.JobDisoccupato, ['@grado'] = BossMenu.GradoDisoccupato, ['@ide'] = ide})
                    Wait(300)
                    TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
                    Notifica(xPlayer, BossMenu.Lang['hai_licenziato']:format(res[1].firstname.. " ".. res[1].lastname, xPlayer.getJob().label))
                end)
            end
        end
    end
end)

RegisterServerEvent('nxn_bossmenu:preleva',function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if JobSecondario[source] then
        if data.tipo == 'Puliti' then
            if GetSocietyMoney(xPlayer.getJob2().name).money - data.importo >= 0 then
                MySQL.update('UPDATE addon_account_data SET money = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob2().name).money - data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob2().name})
                xPlayer.addMoney(data.importo)
                Notifica(xPlayer, BossMenu.Lang['hai_prelevato']:format(data.importo, ''))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
            end
        else
            if GetSocietyMoney(xPlayer.getJob2().name).soldi_sporchi - data.importo >= 0 then
                MySQL.update('UPDATE addon_account_data SET soldi_sporchi = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob2().name).soldi_sporchi - data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob2().name})
                xPlayer.addAccountMoney('black_money', data.importo)
                Notifica(xPlayer,BossMenu.Lang['hai_prelevato']:format(data.importo, 'Sporchi'))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
            end
        end
    else
        if data.tipo == 'Puliti' then
            if GetSocietyMoney(xPlayer.getJob().name).money - data.importo >= 0 then
                MySQL.update('UPDATE addon_account_data SET money = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob().name).money - data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob().name})
                xPlayer.addMoney(data.importo)
                Notifica(xPlayer, BossMenu.Lang['hai_prelevato']:format(data.importo, ''))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
            end
        else
            if GetSocietyMoney(xPlayer.getJob().name).soldi_sporchi - data.importo >= 0 then
                MySQL.update('UPDATE addon_account_data SET soldi_sporchi = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob().name).soldi_sporchi - data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob().name})
                xPlayer.addAccountMoney('black_money', data.importo)
                Notifica(xPlayer,BossMenu.Lang['hai_prelevato']:format(data.importo, 'Sporchi'))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
            end
        end
    end
end)

RegisterServerEvent('nxn_bossmenu:deposita',function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if JobSecondario[source] then
        if data.tipo == 'Puliti' then
            if xPlayer.getAccount('money').money >= data.importo then
                MySQL.update('UPDATE addon_account_data SET money = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob2().name).money + data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob2().name})
                xPlayer.removeAccountMoney('bank', data.importo)
                Notifica(xPlayer, BossMenu.Lang['hai_depositato']:format(data.importo, ''))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
            elseif xPlayer.getAccount('money').money >= data.importo then
                MySQL.update('UPDATE addon_account_data SET money = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob2().name).money + data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob2().name})
                xPlayer.removeMoney(data.importo)
                Notifica(xPlayer, BossMenu.Lang['hai_depositato']:format(data.importo, ''))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
            else
                xPlayer.showNotification('Non hai abbastanza soldi per depositare', 'error')
                print('Nie masz wystarczająco dużo pieniędzy, aby dokonać wpłaty')
            end
        else
            if xPlayer.getAccount('black_money').money >= data.importo then
                MySQL.update('UPDATE addon_account_data SET soldi_sporchi = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob2().name).soldi_sporchi + data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob2().name})
                xPlayer.removeAccountMoney('black_money', data.importo)
                Notifica(xPlayer, BossMenu.Lang['hai_depositato']:format(data.importo, 'Sporchi'))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob2().name)
            else
                print('Nie masz wystarczająco dużo pieniędzy, aby dokonać wpłaty')
            end
        end
    else
        if data.tipo == 'Puliti' then
            if xPlayer.getAccount('bank').money >= data.importo then
                MySQL.update('UPDATE addon_account_data SET money = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob().name).money + data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob().name})
                xPlayer.removeAccountMoney('bank', data.importo, 'Wpłata na konto firmowe')
                Notifica(xPlayer, BossMenu.Lang['hai_depositato']:format(data.importo, ''))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
            elseif xPlayer.getAccount('money').money >= data.importo then
                MySQL.update('UPDATE addon_account_data SET money = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob().name).money + data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob().name})
                xPlayer.removeMoney(data.importo)
                Notifica(xPlayer, BossMenu.Lang['hai_depositato']:format(data.importo, ''))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src ,xPlayer.getJob().name)
            else
                print('Nie masz wystarczająco dużo pieniędzy, aby dokonać wpłaty')
            end
        else
            if xPlayer.getAccount('black_money').money >= data.importo then
                MySQL.update('UPDATE addon_account_data SET soldi_sporchi = @soldiP WHERE account_name = @lavoro', {['@soldiP'] = GetSocietyMoney(xPlayer.getJob().name).soldi_sporchi + data.importo, ['@lavoro'] = 'society_'..xPlayer.getJob().name})
                xPlayer.removeAccountMoney('black_money', data.importo)
                Notifica(xPlayer, BossMenu.Lang['hai_depositato']:format(data.importo, 'Sporchi'))
                Wait(300)
                TriggerClientEvent("nxn_bossmenu:update", src, xPlayer.getJob().name)
            else
                print('Nie masz wystarczająco dużo pieniędzy, aby dokonać wpłaty')
            end
        end
    end
end)

RegisterServerEvent('nxn_bossmenu:assumi',function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromId(id)
    if JobSecondario[source] then
        if ESX.DoesJobExist(xPlayer.getJob2().name, 0) then
            xTarget.setJob2(xPlayer.getJob2().name, 0)
            MySQL.update('UPDATE users SET job2 = @lavoro,job_grade2 = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob2().name, ['@grado'] = 0, ['@ide'] = xTarget.identifier})
            Notifica(xPlayer, BossMenu.Lang['hai_assunto']:format(xTarget.getName()))
            xTarget.showNotification(BossMenu.Lang['sei_stato_assunto']:format(xPlayer.getName()))
        else
            print('[^4MANY-BOSSMENU^0] Minimalny stopień '..xPlayer.getJob().name.. " musi wynosić 0!")
            return
        end
    else
        if ESX.DoesJobExist(xPlayer.getJob().name, 0) then
            xTarget.setJob(xPlayer.getJob().name, 0)
            MySQL.update('UPDATE users SET job = @lavoro,job_grade = @grado WHERE identifier = @ide', {['@lavoro'] = xPlayer.getJob().name, ['@grado'] = 0, ['@ide'] = xTarget.identifier})
            Notifica(xPlayer, BossMenu.Lang['hai_assunto']:format(xTarget.getName()))
            xTarget.showNotification(BossMenu.Lang['sei_stato_assunto']:format(xPlayer.getName()))
        else
            print('[^4MANY-BOSSMENU^0] Minimalny stopień '..xPlayer.getJob().name.. " musi wynosić 0!")
            return
        end
    end
end)