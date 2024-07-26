Config = {}

Config['BettaHeist'] = {
    ['framework'] = {
        name = 'ESX', -- framework ESX czy QB.
        scriptName = 'qb-core', -- tylko dla QB users.
        eventName = 'esx:getSharedObject', -- tylko dla ESX users.
        targetScript = 'qtarget' -- Nazwa skryptu do targeta (qtarget or qb-target)
    },
    ['setjobForPolice'] = 'police', -- Setjob do sprawdzania liczby police i alarmu policyjnego.
    ['requiredPoliceCount'] = 0, -- Wymagana liczba policjantów do rozpoczęcia napadu.
    ['nextRob'] = 1800, -- Sekundy do następnego napadu
    ['startHeist'] ={ -- Współrzędne rozpoczęcia napadu npc
        pos = vector3(-904.06, 148.57, 63.17),
        peds = {
            {pos = vector3(-903.85, 148.57, 63.10), heading = 90.0, ped = 's_m_m_highsec_01'}
        }
    },
    ['requiredItems'] = { -- przedmioty potrzebne do napadu. Dodaj do bazy danych/ox_inventory
        'bag',
        'drill',
        'big_drill',
        'thermite',
        'bolt_cutter'
    },
    ['rewardItems'] = {
        {itemName = 'gold', count = 1, sellPrice = 2500}, -- Skrytka
        {itemName = 'diamond', count = 1, sellPrice = 4500}, -- Skrytka
    },
    ['rewardMoneys'] = {
        ['stacks'] = function()
            return math.random(50000, 100000) -- Kasa.
        end,
    },
    ['rewardLockbox'] = function()
        local random = math.random(#Config['BettaHeist']['rewardItems'])
        local lockboxBag = {
            item = Config['BettaHeist']['rewardItems'][random]['itemName'],
            count = math.random(1, 5), -- liczba przedmiotów nagrody z skrytki
        }
        return lockboxBag
    end,
    ['drillTime'] = 10, --210 Sekundy czasu oczekiwania na duże wiertło do drugich drzwi
    ['moneyItem'] = { -- Jeśli twój serwer ma element pieniężny, możesz go ustawić tutaj.
        status = false,
        itemName = 'cash'
    },
    ['black_money'] = {  -- Jeśli zmiana jest prawdziwa, wszystkie pieniądze zostaną zamienione na czarne. Gracze QBCore mogą zmienić nazwę przedmiotu.
        status = false,
        itemName = 'black_money'
    },
    ['finishHeist'] = { -- Heist finish coords.
        buyerPos = vector3(1104.28, -2287.5, 29.1784)
    },
}

Config['BettaSetup'] = {
    ['main'] = vector3(-1220.7, -341.21, 37.7323),
    ['trollys'] = {
        {coords = vector3(-1221.6, -343.99, 36.7322), heading = 343.0, type = 'diamond'},
        {coords = vector3(-1219.5, -342.73, 36.7322), heading = 118.0, type = 'gold'},
    },
    ['actions'] = {
        ['lockbox_1']      =  {coords  = vector3(-1220.7, -341.21, 37.7323), heading = 27.0, length = 1.8,  width = 0.5, debugPoly = false, minZ = 37.2160, maxZ = 38.960, options = {{type = "client", event = "bettaheist:client:actions", icon = "fa-solid fa-hand", label = "Otwórz", scene = 'lockbox_1',      job = "all", canInteract = function() return not HeistSync['lockbox_1'] end}},     distance = 1.5},
        ['lockbox_2']      =  {coords  = vector3(-1222.3, -341.22, 37.7403), heading = 117.0, length = 1.8, width = 0.5, debugPoly = false, minZ = 37.2160, maxZ = 38.960, options = {{type = "client", event = "bettaheist:client:actions", icon = "fa-solid fa-hand", label = "Otwórz", scene = 'lockbox_2',      job = "all", canInteract = function() return not HeistSync['lockbox_2'] end}},     distance = 1.5},
        ['trolly_1']       =  {coords  = vector3(-1221.6, -343.99, 36.7322), heading = 77.0, length = 1.0,  width = 0.5, debugPoly = false, minZ = 37.2160, maxZ = 38.960, options = {{type = "client", event = "bettaheist:client:actions", icon = "fa-solid fa-hand", label = "Zbierz", scene = 'trolly_1',       job = "all", canInteract = function() return not HeistSync['trolly_1'] end}},      distance = 1.5},
        ['trolly_2']       =  {coords  = vector3(-1219.5, -342.73, 36.7322), heading = 27.0, length = 1.0,  width = 0.5, debugPoly = false, minZ = 37.2160, maxZ = 38.960, options = {{type = "client", event = "bettaheist:client:actions", icon = "fa-solid fa-hand", label = "Zbierz", scene = 'trolly_2',       job = "all", canInteract = function() return not HeistSync['trolly_2'] end}},      distance = 1.5},
        ['stack']          =  {coords  = vector3(-1218.7, -345.93, 37.7322), heading = 27.0, length = 1.0,  width = 1.0, debugPoly = false, minZ = 37.5160, maxZ = 37.960, options = {{type = "client", event = "bettaheist:client:actions", icon = "fa-solid fa-hand", label = "Zbierz", scene = 'stack',          job = "all", canInteract = function() return not HeistSync['stack'] end}},         distance = 1.5},
        ['bolt_cutter']    =  {coords  = vector3(-1220.2, -343.99, 37.7322), heading = 27.0, length = 0.2,  width = 0.2, debugPoly = false, minZ = 37.5160, maxZ = 38.160, options = {{type = "client", event = "bettaheist:client:actions", icon = "fa-solid fa-hand", label = "Otwórz", scene = 'bolt_cutter',    job = "all", canInteract = function() return not HeistSync['bolt_cutter'] end}},   distance = 1.5},
        ['vault_drill']    =  {coords  = vector3(-1223.7, -343.42, 37.7322), heading = 27.0, length = 1.5,  width = 1.0, debugPoly = false, minZ = 36.5160, maxZ = 38.960, options = {{type = "client", event = "bettaheist:client:actions", icon = "fa-solid fa-hand", label = "Otwórz", scene = 'vault_drill',    job = "all", canInteract = function() return not HeistSync['vault_drill'] end}},   distance = 1.5},
        ['enter_thermite'] =  {coords  = vector3(-1230.1, -337.27, 37.6160), heading = 27.0, length = 0.5,  width = 2.0, debugPoly = false, minZ = 36.5160, maxZ = 38.960, options = {{type = "client", event = "bettaheist:client:actions", icon = "fa-solid fa-hand", label = "Otwórz",scene = 'enter_thermite',  job = "all", canInteract = function() return not HeistSync['enter_thermite'] end}},distance = 1.5},
    }
}

Strings = {
    ['betta_blip'] = 'Betta Bank',
    ['heist_info'] = 'Udaj się do miejsca zaznaczonego na GPS.',
    ['drill_bar'] = 'WIERCENIE',
    ['wait_nextrob'] = 'Do nastepnego napadu pozostało',
    ['minute'] = 'minut.',
    ['need_this'] = 'Nie masz potrzebnych przedmiotów!',
    ['need_police'] = 'Za mało policji w mieście.',
    ['police_alert'] = 'Uwaga napad na bank Betta! Sprawdź swój GPS.',
    ['not_cop'] = 'You are not cop!',
    ['buyer_blip'] = 'Buyer',
    ['deliver_to_buyer'] = 'Dostarcz łup. Sprawdź GPS.',

    ['start_heist'] = 'ROZPOCZNIJ NAPAD'
}