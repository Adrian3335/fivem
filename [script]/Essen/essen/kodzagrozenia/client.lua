ESX = exports["es_extended"]:getSharedObject()
  local PlayerData = {}
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
  end)
  
  RegisterCommand('ustawkod', function()
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade >= 13 then
        MenuKod()
    end
  end)
  
  Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade >= 13 then
            local player = GetPlayerPed(-1)
            if GetDistanceBetweenCoords(GetEntityCoords(player, true), 454.72, -982.3, 30.69-0.90, true) < 10 then
                DrawMarker(25, 454.72, -982.3, 30.69-0.90, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 255, 212, 0, 0, 0, 2, 0, 0, 0, 0)
              if GetDistanceBetweenCoords(GetEntityCoords(player, true), 454.72, -982.3, 30.69, true) < 1.5 then
                ESX.ShowHelpNotification("Naciśnij ~y~[E], ~w~aby zarządzać statusem zagrożenia.")
                   if IsControlJustReleased(1, 51) then -- klawisz to E jakby co
                      MenuKod()
                end
            end
        end
      end
  end
  end)
  
  function dyrkiel_pomoc(mesydz)
    SetTextComponentFormat("STRING")
    AddTextComponentString(mesydz)
    DisplayHelpTextFromStringLabel(0, 0, 0, -1)
  end
  
  function MenuKod()
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'kodzagrozenia',
      {
        title    = 'Poziom Zagrożenia',
        align    = 'right',
        elements = {
          {label = 'Kod Zielony 🟢', value = '0'},
          {label = 'Kod Pomarańczowy 🟠', value = '1'},
          {label = 'Kod Czerwony 🔴', value = '2'},
          {label = 'Kod Czarny ⚫', value = '3'}
        }
      },
      function(data, menu)
        local ped = PlayerPedId()
        if data.current.value == '0' then
          TriggerServerEvent('esx_scoreboard:Show', "Aktualny poziom zagrożenia 🟢.", "1821722")
          ExecuteCommand("sast Na Miasto Został Wprowadzony Kod 🟢!")
        end
        if data.current.value == '1' then
          TriggerServerEvent('esx_scoreboard:Show', "Aktualny poziom zagrożenia 🟠.", "15105570")
          ExecuteCommand("sast Na Miasto Został Wprowadzony Kod 🟠!")
        end
        if data.current.value == '2' then
          TriggerServerEvent('esx_scoreboard:Show', "Aktualny poziom zagrożenia 🔴.", "15158332")
          ExecuteCommand("sast Na Miasto Został Wprowadzony Kod 🔴!") 
        end
        if data.current.value == '3' then
          TriggerServerEvent('esx_scoreboard:Show', "Aktualny poziom zagrożenia ⚫.", "1")
          ExecuteCommand("sast Na Miasto Został Wprowadzony Kod ⚫!")
        end
        menu.close()
      end,
      function(data, menu)
        menu.close()
      end
    )
  end