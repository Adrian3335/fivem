local CharCount, VehCount, LiczbaFakturPrzezMiesiac, LiczbaFakturPrzezTydzien, OstatnieFakturySelect, NotepadSelect, NotepadInsert, NotepadUpdate, OgloszeniaSelect, OgloszeniaInsert, OgloszeniaDelete, RaportySelect, RaportyInsert, RaportyDelete, HistoriaSelect, HistoriaInsert, HistoriaDelete, KartaSearch, KartaNotatkiInsert, KartaNotatkiDelete, KartaNotatkiSelect, VehiclesByIdentifier = -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1

ESX = exports["es_extended"]:getSharedObject()
		
MySQL.ready(function()

    MySQL.Async.fetchScalar("SELECT COUNT(*) FROM `users`", {}, function(data)
        CharCount = data	
    end)  

	MySQL.Async.fetchScalar("SELECT COUNT(*) FROM `owned_vehicles`", {}, function(data)
        VehCount = data
    end)
	
    LiczbaFakturPrzezMiesiac = MySQL.Sync.store("SELECT COUNT(*) FROM `lscmdt_history` WHERE month(date) = month(NOW() - INTERVAL 1 MONTH);")
    LiczbaFakturPrzezTydzien = MySQL.Sync.store("SELECT COUNT(*) FROM `lscmdt_history` WHERE month(date) = month(NOW() - INTERVAL 1 WEEK);")
    MySQL.Async.store("SELECT * FROM `lscmdt_history` ORDER BY id DESC LIMIT 6", function(storeId)
		OstatnieFakturySelect = storeId
	end)
    MySQL.Async.store("SELECT `notatka` FROM `lscmdt_notatki` WHERE `identifier` = ?", function(storeId)
		NotepadSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lscmdt_notatki`(`identifier`, `notatka`) VALUES (?,?)', function(storeId)
        NotepadInsert = storeId
    end)
    MySQL.Async.store('UPDATE `lscmdt_notatki` SET `notatka` = ? WHERE `identifier` = ?', function(storeId)
        NotepadUpdate = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lscmdt_ogloszenia`", function(storeId)
		OgloszeniaSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lscmdt_ogloszenia`(`mechanic`, `ogloszenie`) VALUES (?,?)', function(storeId)
        OgloszeniaInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lscmdt_ogloszenia` WHERE `mechanic` = ? AND `ogloszenie` = ?', function(stroeId)
        OgloszeniaDelete = stroeId
    end)
    MySQL.Async.store("SELECT * FROM `lscmdt_raporty`", function(storeId)
		RaportySelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lscmdt_raporty`(`mechanic`, `raport`) VALUES (?,?)', function(storeId)
        RaportyInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lscmdt_raporty` WHERE `mechanic` = ? AND `raport` = ?', function(stroeId)
        RaportyDelete = stroeId
    end)
    MySQL.Async.store("SELECT * FROM `lscmdt_history` WHERE `identifier` = ?", function(storeId)
		HistoriaSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lscmdt_history`(`identifier`, `client`, `mechanic`, `reason`, `fee`) VALUES (?,?,?,?,?)', function(storeId)
        HistoriaInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lscmdt_history` WHERE `id` = ? AND `identifier` = ?', function(storeId)
        HistoriaDelete = storeId
    end)
    MySQL.Async.store("SELECT `identifier`, `firstname`, `lastname`, `dateofbirth`, `phone_number` FROM `users` WHERE `firstname` = ? AND `lastname` = ?", function(storeId)
        KartaSearch = storeId
    end)
    MySQL.Async.store('INSERT INTO `lscmdt_karta_notatki` (`identifier`, `notatka`, `mechanic`) VALUES (?,?,?)', function(storeId)
        KartaNotatkiInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lscmdt_karta_notatki` WHERE `identifier` = ? AND `notatka` = ?', function(storeId)
        KartaNotatkiDelete = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lscmdt_karta_notatki` WHERE `identifier` = ?", function(storeId)
		KartaNotatkiSelect = storeId
	end)
    MySQL.Async.store('SELECT `vehicle`, `plate` FROM `owned_vehicles` WHERE `owner` = ?', function(storeId)
		VehiclesByIdentifier = storeId
	end)
    Mechanic = MySQL.Sync.fetchAll("SELECT `identifier`, `firstname`, `lastname`, `phone_number` FROM `users` WHERE `job` = ?", {"mechanic"})
    for k,v in pairs(Mechanic) do
        v.duty_status = 1
        v.color = "red"
    end
end)



RegisterServerEvent("esx_lscmmdt:SendMdtData")
AddEventHandler("esx_lscmmdt:SendMdtData", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
        if(xPlayer.job.name == 'mechanic') then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier']	= xPlayer.identifier
			})[1]
			
			if xPlayerSQL ~= nil then
				local MdtData = {
					charCount = CharCount,
					vehCount = VehCount,
					Player = {
						firstname = xPlayerSQL.firstname,
						lastname = xPlayerSQL.lastname,
						job = xPlayer.job,
					},
					fakturyMiesiac = MySQL.Sync.fetchScalar(LiczbaFakturPrzezMiesiac),
					fakturyTydzien = MySQL.Sync.fetchScalar(LiczbaFakturPrzezTydzien),
					OstatnieFaktury = MySQL.Sync.fetchAll(OstatnieFakturySelect),
					Notepad = MySQL.Sync.fetchScalar(NotepadSelect, {xPlayer.identifier}),
					Ogloszenia = MySQL.Sync.fetchAll(OgloszeniaSelect),
					Raporty = MySQL.Sync.fetchAll(RaportySelect),
					Mechanic = Mechanic,   
				}	
				TriggerClientEvent("esx_lscmmdt:SendMdtData", _source, MdtData)
			end
        else
            --DropPlayer(_source, "BAN") --Trigger do bana
        end
	end
end)

RegisterServerEvent("esx_lscmmdt:UpdateMechanicStatus")
AddEventHandler("esx_lscmmdt:UpdateMechanicStatus", function(type)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
		local jestwtablicy = false
		if type == 'insert' then
			for k,v in pairs(Mechanic) do
				if xPlayer.identifier == v.identifier then
					v.duty_status = 2
					v.color = "green"
					jestwtablicy = true
					break
				end
			end
			if jestwtablicy == false then
				local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname, phone_number FROM users WHERE identifier = @identifier', {
					['@identifier']	= xPlayer.identifier
				})[1]
				
				if xPlayerSQL ~= nil then
					table.insert(Mechanic, {
						identifier = xPlayer.identifier,
						firstname = xPlayerSQL.firstname,
						lastname = xPlayerSQL.lastname,
						phone_number = xPlayerSQL.phone_number,
						duty_status = 2,
						color = "green"
					})
				end
			end
		elseif type == 'remove' then
			for k,v in pairs(Mechanic) do
				if xPlayer.identifier == v.identifier then
					if xPlayer.job.name == 'offduty' then
						v.duty_status = 1
						v.color = "red"
						break
					else
						table.remove(Mechanic, k)
						break
					end
				end
			end
		end
		table.sort(Mechanic, function (a, b) 
			if(a ~= nil and b ~= nil) then
				return a.duty_status > b.duty_status 
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_lscmdt:SendAnnounce', function(source, cb, text)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' and xPlayer.job.grade_name == 'boss' then
        if(text ~= nil and text ~= "") then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier']	= xPlayer.identifier
			})[1]
			
			if xPlayerSQL ~= nil then
				local announcedata = {
					owner = xPlayerSQL.firstname.." "..xPlayerSQL.lastname,
					text = text,
					date = os.time(os.date("!*t"))
				}
				MySQL.Async.execute(OgloszeniaInsert, {announcedata.owner, announcedata.text})
				cb(announcedata)
			end
        end
    else
        --DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent("esx_lscmdt:RemoveAnnounce")
AddEventHandler("esx_lscmdt:RemoveAnnounce", function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' and xPlayer.job.grade_name == 'boss' then
        if(data.fp ~= nil and data.ogloszenie ~= nil) then
            MySQL.Async.execute(OgloszeniaDelete, {data.fp, data.ogloszenie})
        end
    else
        --DropPlayer(_source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_lscmdt:SendRaport', function(source, cb, text)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
        if(text ~= nil and text ~= "") then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier']	= xPlayer.identifier
			})[1]
			
			if xPlayerSQL ~= nil then
				local raportdata = {
					owner = xPlayerSQL.firstname.." "..xPlayerSQL.lastname,
					text = text,
					date = os.time(os.date("!*t"))
				}
				MySQL.Async.execute(RaportyInsert, {raportdata.owner, raportdata.text})
				cb(raportdata)
			end
        end
    else
        --DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lscmdt:RemoveRaport')
AddEventHandler('esx_lscmdt:RemoveRaport', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' and xPlayer.job.grade_name == 'boss' then
        if(data.fp ~= nil and data.raport ~= nil) then
            MySQL.Async.execute(RaportyDelete, {data.fp, data.raport})
        end

    else 
        --DropPlayer(_source, "BAN") -- Trigger do bana
    end
end)

RegisterServerEvent("esx_lscmdt:UpdateNotepad")
AddEventHandler("esx_lscmdt:UpdateNotepad", function(note)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
        if note ~= nil then        
            MySQL.Async.fetchAll(NotepadSelect, {
                xPlayer.identifier,
            }, function(notepad)
                if notepad[1] then
                    MySQL.Async.execute(NotepadUpdate, {note, xPlayer.identifier})
                else
                    MySQL.Async.execute(NotepadInsert, {xPlayer.identifier, note})
                end		
            end)
        end
    else
        --DropPlayer(_source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lscmdt:WystawFakture')
AddEventHandler('esx_lscmdt:WystawFakture', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(data.id)
    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
		local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xPlayer.identifier
		})[1]	

		local xTargetSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xTarget.identifier
		})[1]
		
		if xPlayerSQL ~= nil and xTargetSQL ~= nil then
			local doctor = xPlayerSQL.firstname.." "..xPlayerSQL.lastname
			local name = xTargetSQL.firstname..' '..xTargetSQL.lastname
			local faktura = tonumber(data.fee)
			MySQL.Async.execute(HistoriaInsert, {xTarget.identifier, xTargetSQL.firstname.." "..xTargetSQL.lastname, doctor, data.text, faktura})
				
			xTarget.removeAccountMoney('bank', faktura)

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
				if account then
					account.addMoney(faktura * 0.80)
				end
			end)

            xPlayer.addMoney(faktura * 0.20)

			xPlayer.showNotification('Wystawiono fakturę dla ['..xTarget.source..'] o wartości: ~g~'..faktura..' ~s~$')
			xTarget.showNotification('Otrzymano fakturę od ['..xPlayer.source..'] o wartości: ~g~'..faktura..' ~s~$')
		end
    else
        --DropPlayer(_source, "BAN")
    end
end)

ESX.RegisterServerCallback('esx_lscmdt:SearchPersonKartaPojazdu', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
        MySQL.Async.fetchAll(KartaSearch, {data.firstname, data.lastname}, function(result)
            cb(result)
        end)
    else
        --DropPlayer(source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_lscmdt:AddNotatkaKartaPojazdu', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
        local identifier = data.identifier
		local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xPlayer.identifier
		})	
		
		if xPlayerSQL ~= nil then
			local notedata = {
				notatka = data.note,
				mechanic = xPlayerSQL.firstname.." "..xPlayerSQL.lastname,
				date = os.time(os.date("!*t"))
			}
			cb(notedata)
			MySQL.Async.execute(KartaNotatkiInsert, {identifier, notedata.notatka, notedata.mechanic})
		end
    else
       -- DropPlayer(source, "BAN") --Trigger do bana
    end

end)

RegisterServerEvent('esx_lscmdt:RemoveNotatkaKartaPojazdu')
AddEventHandler('esx_lscmdt:RemoveNotatkaKartaPojazdu', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
        local identifier = data.identifier
        local note = data.note

        MySQL.Async.execute(KartaNotatkiDelete, {identifier, note})
    else
        --DropPlayer(source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_lscmdt:PersonMoreInfo', function(source, cb, data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
        local identifier = data.identifier      
        MySQL.Async.fetchAll(VehiclesByIdentifier, {identifier}, function(result)
            local vehdata = {}
            for k,v in pairs(result) do
                local vehicle = json.decode(v.vehicle)
                table.insert(vehdata, {
                    model = vehicle.name,
                    plate = v.plate
                })
            end
			
			local licenses = MySQL.Sync.fetchAll('SELECT * FROM user_licenses WHERE owner = @identifier', {
				['@identifier']	= identifier
			})
			
            local moreinfodata = {
                faktury = MySQL.Sync.fetchAll(HistoriaSelect, {identifier}),
                notatki = MySQL.Sync.fetchAll(KartaNotatkiSelect, {identifier}),
                pojadzy = vehdata,
                licenses = licenses
            }
            cb(moreinfodata)
        end)
    else
        --DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lscmdt:RemoveFakturaKarta')
AddEventHandler('esx_lscmdt:RemoveFakturaKarta', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
        local id = data.id
        local identifier = data.identifier
        MySQL.Async.execute(HistoriaDelete, {id, identifier})
    else
        --DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lscmdt:licencjaDodaj')
AddEventHandler('esx_lscmdt:licencjaDodaj', function(data)
    local _source = source
    local identifier = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
		MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
			['@type']  = data.type,
			['@owner'] = identifier
		})
			
		if xTarget ~= nil then
			xTarget.showNotification('Otrzymałeś licencje: ' .. changekLicenseName(data.type))
		end
    else
       -- DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lscmdt:licencjaUsun')
AddEventHandler('esx_lscmdt:licencjaUsun', function(data)
    local _source = source
    local identifier = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer ~= nil and xPlayer.job.name == 'mechanic' then
		MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
			['@type']  = data.type,
			['@owner'] = identifier
		})
	
		if xTarget ~= nil then
			xTarget.showNotification('Straciłeś licencje: ' .. changekLicenseName(data.type))
		end
    else
        --DropPlayer(source, "BAN") --Trigger do bana
    end
end)

function changekLicenseName(licencja)
	local name = "";
	if(licencja == "oc" ) then
		name = "Ubezpieczenie OC"
		return name
	end
end