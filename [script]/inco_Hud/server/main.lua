ESX = exports['es_extended']:getSharedObject()

if Config.OldESX then
    function GetRPName(player)
        local xPlayer = ESX.GetPlayerFromId(player)
        local name = MySQL.query.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {xPlayer.identifier})[1]
        local fname = name.firstname
        local sname = name.lastname
        local fullname = string.upper(string.sub(fname, 1, 1))..'. '..string.upper(string.sub(sname, 1, 1))..''..string.sub(sname, 2)
        return fullname
    end
else
    function GetRPName(player)
        local xPlayer = ESX.GetPlayerFromId(player)
        local fname = xPlayer.get('firstName')
        local sname = xPlayer.get('lastName')
        local fullname = string.upper(string.sub(fname, 1, 1))..'. '..string.upper(string.sub(sname, 1, 1))..''..string.sub(sname, 2)
        return fullname
    end
end

function GetPlayerBadge(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    local badge = MySQL.query.await('SELECT badge FROM users WHERE identifier = ?', {xPlayer.identifier})[1].badge
    return badge
end