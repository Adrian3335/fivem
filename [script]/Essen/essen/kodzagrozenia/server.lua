s1 = "https://cdn.discordapp.com/attachments/998079426266939475/1043530151805333594/Bez_sadasdasdasdasdasdasdasdasdasddasdasdasdasdasdasdasdasdsadasds.png"
    webhook = ""
    
    RegisterServerEvent('dyrkiel_log')
    AddEventHandler('dyrkiel_log', function(message, color)
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "EssenPack", embeds = {{["color"] = color,["title"] = "Status Zagrożenia",["description"] = "".. message .."",["footer"] = {["text"] = "EssenPack",["icon_url"] = s1,},}}, avatar_url = s1}), { ['Content-Type'] = 'application/json' })
    end)