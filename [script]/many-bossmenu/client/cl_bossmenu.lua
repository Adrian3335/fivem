GetJob = function(job)
    for k,v in pairs(BossMenu.Options) do
        if k == job then 
            if v.job_secondario == true then
                return true
            else
                return false
            end
        end
    end
end

GetBoss = function(job)
    for k,v in pairs(BossMenu.Options) do
        for a,b in pairs(v.gradi) do
            if BossMenu.DoubleJob then
                if ESX.GetPlayerData().job.name == job and ESX.GetPlayerData().job.grade_name == b then
                    return true
                else
                    return false
                end
            else
                if ESX.GetPlayerData().job.name == job and ESX.GetPlayerData().job.grade_name == b then
                    return true
                else
                    return false
                end
            end
        end
    end
end

NXN_BossMenuOpen = function(job)
    local fazione = GetJob(job)
    local boss = GetBoss(job)
    if boss then
        ESX.TriggerServerCallback('nxn_bossmenu:getSocietyAndPlayerInfo',function(tabella, OFF, ON, soldi,soldiS)
            if fazione then
                SendNUIMessage({azione = 'BossMenu', tabella = tabella, on = ON, off = OFF, soldiSoc = tostring(soldi), soldiSpor = tostring(soldiS), jobName = ESX.GetPlayerData().job.label, imm = BossMenu.Background_Image, soldiSporchi = true})
                SetNuiFocus(true,true)
            else
                SendNUIMessage({azione = 'BossMenu', tabella = tabella, on = ON, off = OFF, soldiSoc = tostring(soldi), soldiSpor = tostring(soldiS), jobName = ESX.GetPlayerData().job.label, imm = BossMenu.Background_Image, soldiSporchi = false})
                SetNuiFocus(true,true)
            end
        end,fazione, job)
    end
end

RegisterCommand('policeboss', function()
    NXN_BossMenuOpen('police')
end)

RegisterCommand('TunersBoss', function()
    NXN_BossMenuOpen('tunerszone')
end)

RegisterCommand('CarzoneBoss', function()
    NXN_BossMenuOpen('carzone')
end)

RegisterCommand('EmsBoss', function()
    NXN_BossMenuOpen('ems')
end)

RegisterCommand('CarzoneBoss', function()
    NXN_BossMenuOpen('carzone')
end)

RegisterCommand('SewingBoss', function()
    NXN_BossMenuOpen('sewing')
end)

RegisterCommand('PDMBoss', function()
    NXN_BossMenuOpen('pdm')
end)

RegisterCommand('apri', function()
    NXN_BossMenuOpen(job)
end)

RegisterNetEvent('nxn_bossmenu:update',function(job)
    NXN_BossMenuOpen(job)
end)


RegisterCommand('boss', function(job)
    TriggerEvent("nxn_bossmenu:update", 'cardealer')
end)