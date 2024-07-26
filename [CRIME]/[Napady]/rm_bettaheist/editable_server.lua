RegisterServerEvent('bettaheist:server:policeAlert')
AddEventHandler('bettaheist:server:policeAlert', function(coords)
    if Config['BettaHeist']['framework']['name'] == 'ESX' then
        local players = ESX.GetPlayers()
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player['job']['name'] == Config['BettaHeist']['setjobForPolice'] then
                TriggerClientEvent('bettaheist:client:policeAlert', players[i], coords)
            end
        end
    elseif Config['BettaHeist']['framework']['name'] == 'QB' then
        local players = QBCore.Functions.GetPlayers()
        for i = 1, #players do
            local player = QBCore.Functions.GetPlayer(players[i])
            if player.PlayerData.job.name == Config['BettaHeist']['setjobForPolice'] then
                TriggerClientEvent('bettaheist:client:policeAlert', players[i], coords)
            end
        end
    end
end)

discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/879717545597337610/fN1sTgBA8FRHu4JdEjZ6wIHdYRkqkOWgbPgw3LmvsMBgt1TZOoxo1ixBeuA0y9YMIqEX',
    ['name'] = 'rm_bettaheist',
    ['image'] = ''
}

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end