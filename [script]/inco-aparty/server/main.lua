ESX = exports.es_extended:getSharedObject()
RSE = RegisterServerEvent
AEH = AddEventHandler

local szafka = {
    id = 'aparty_szafka',
    label = 'Szafka',
    slots = 50,
    weight = 100000,
    owner = true,
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(szafka.id, szafka.label, szafka.slots, szafka.weight, szafka.owner)
    end
end)

RSE('inco-apartaments:SetBucket')
AEH('inco-apartaments:SetBucket', function(source, id)
    SetPlayerRoutingBucket(source, id)
    --print(id)
end)
