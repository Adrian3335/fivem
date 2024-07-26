local FormattedToken = "OTYwMTU5NDYyOTM1NjI1NzQ4.GdCRO6.PjF4RRFeO9dN9na5DAu1ooriOGd-X_0OkdRQtY"

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function GetRoles(discordId)
	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format('discord id', discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			return roles
		end
	end
end