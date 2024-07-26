ESX = exports["es_extended"]:getSharedObject()

local CharCount, VehCount, LiczbaFakturPrzezMiesiac, LiczbaFakturPrzezTydzien, OstatnieFakturySelect, NotepadInsert, NotepadSelect, NotepadUpdate, OgloszeniaSelect, OgloszeniaInsert, OgloszeniaDelete, RaportySelect, RaportyInsert, RaportyDelete, HistoriaSelect, HistoriaInsert, HistoriaDelete, KartaSearch, KartaNotatkiSelect, KartaNotatkiInsert, KartaNotatkiDelete = -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1

MySQL.ready(function()
    MySQL.Async.fetchScalar("SELECT COUNT(*) FROM `users`", {}, function(data)
        CharCount = data	
    end)  

	MySQL.Async.fetchScalar("SELECT COUNT(*) FROM `owned_vehicles`", {}, function(data)
        VehCount = data
    end)	
	
    LiczbaFakturPrzezMiesiac = MySQL.Sync.store("SELECT COUNT(*) FROM `emsmdt_history` WHERE month(date) = month(NOW() - INTERVAL 1 MONTH);")
	
    LiczbaFakturPrzezTydzien = MySQL.Sync.store("SELECT COUNT(*) FROM `emsmdt_history` WHERE month(date) = month(NOW() - INTERVAL 1 WEEK);")

    MySQL.Async.store("SELECT * FROM `emsmdt_history` ORDER BY id DESC LIMIT 6", function(storeId)
		OstatnieFakturySelect = storeId
	end)
	
    MySQL.Async.store("SELECT `notatka` FROM `emsmdt_notatki` WHERE `identifier` = ?", function(storeId)
		NotepadSelect = storeId
	end)
	
    MySQL.Async.store('INSERT INTO `emsmdt_notatki`(`identifier`, `notatka`) VALUES (?,?)', function(storeId)
        NotepadInsert = storeId
    end)
	
    MySQL.Async.store('UPDATE `emsmdt_notatki` SET `notatka` = ? WHERE `identifier` = ?', function(storeId)
        NotepadUpdate = storeId
    end)
	
    MySQL.Async.store("SELECT * FROM `emsmdt_ogloszenia`", function(storeId)
		OgloszeniaSelect = storeId
	end)
	
    MySQL.Async.store('INSERT INTO `emsmdt_ogloszenia`(`fp`, `ogloszenie`) VALUES (?,?)', function(storeId)
        OgloszeniaInsert = storeId
    end)
	
    MySQL.Async.store('DELETE FROM `emsmdt_ogloszenia` WHERE `fp` = ? AND `ogloszenie` = ?', function(stroeId)
        OgloszeniaDelete = stroeId
    end)
	
    MySQL.Async.store("SELECT * FROM `emsmdt_raporty`", function(storeId)
		RaportySelect = storeId
	end)
	
    MySQL.Async.store('INSERT INTO `emsmdt_raporty`(`fp`, `raport`) VALUES (?,?)', function(storeId)
        RaportyInsert = storeId
    end)
	
    MySQL.Async.store('DELETE FROM `emsmdt_raporty` WHERE `fp` = ? AND `raport` = ?', function(storeId)
        RaportyDelete = storeId
    end)
	
    MySQL.Async.store("SELECT * FROM `emsmdt_history` WHERE `identifier` = ?", function(storeId)
		HistoriaSelect = storeId
	end)
	
    MySQL.Async.store('INSERT INTO `emsmdt_history`(`identifier`, `patient`, `doctor`, `reason`, `fee`) VALUES (?,?,?,?,?)', function(storeId)
        HistoriaInsert = storeId
    end)
	
    MySQL.Async.store('DELETE FROM `emsmdt_history` WHERE `id` = ? AND `identifier` = ?', function(storeId)
        HistoriaDelete = storeId
    end)
	
    MySQL.Async.store("SELECT `identifier`, `firstname`, `lastname`, `dateofbirth`, `phone_number` FROM `users` WHERE `firstname` = ? AND `lastname` = ?", function(storeId)
        KartaSearch = storeId
    end)
	
    MySQL.Async.store("SELECT * FROM `emsmdt_karta_notatki` WHERE `identifier` = ?", function(storeId)
		KartaNotatkiSelect = storeId
	end)
	
    MySQL.Async.store('INSERT INTO `emsmdt_karta_notatki`(`identifier`, `notatka`, `doctor`) VALUES (?,?,?)', function(storeId)
        KartaNotatkiInsert = storeId
    end)
	
    MySQL.Async.store('DELETE FROM `emsmdt_karta_notatki` WHERE `identifier` = ? AND `notatka` = ?', function(storeId)
        KartaNotatkiDelete = storeId
    end)
	
    Ambulances = MySQL.Sync.fetchAll("SELECT `identifier`, `firstname`, `lastname`, `phone_number` FROM `users` WHERE `job` = ?", {"ambulance"})
	
    for k,v in pairs(Ambulances) do
        v.duty_status = 1
        v.color = "red"
    end
end)

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
        for k,v in pairs(Ambulances) do
            if xPlayer.identifier == v.identifier then
                v.duty_status = 1
                v.color = "red"
            end
        end
    end
end)

RegisterServerEvent("esx_emsmdt:SendMdtData")
AddEventHandler("esx_emsmdt:SendMdtData", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
        if(xPlayer.job.name == 'ambulance') then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier']	= xPlayer.identifier
			})[1]	
		
			if xPlayerSQL ~= nil then
				local MdtData = {
					charCount = CharCount,
					vehCount = VehCount,
					fakturyMiesiac = MySQL.Sync.fetchScalar(LiczbaFakturPrzezMiesiac),
					fakturyTydzien = MySQL.Sync.fetchScalar(LiczbaFakturPrzezTydzien),
					OstatnieFaktury = MySQL.Sync.fetchAll(OstatnieFakturySelect),
					Ambulance = Ambulances,
					Notepad = MySQL.Sync.fetchScalar(NotepadSelect, {xPlayer.identifier}),
					Player = {
						firstname = xPlayerSQL.firstname,
						lastname = xPlayerSQL.lastname,
						job = xPlayer.job,
					},
					Ogloszenia = MySQL.Sync.fetchAll(OgloszeniaSelect),
					Raporty = MySQL.Sync.fetchAll(RaportySelect),
					Taryfikator = Config.Taryfikator
				}	
				TriggerClientEvent("esx_emsmdt:SendMdtData", _source, MdtData)
			end
        else
            DropPlayer(_source, "BAN") --Trigger do bana
        end
	end
end)


RegisterServerEvent("esx_emsmdt:UpdateAmbulanceStatus")
AddEventHandler("esx_emsmdt:UpdateAmbulanceStatus", function(type) -- to do
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
		local jestwtablicy = false
		if type == 'insert' then
			for k,v in pairs(Ambulances) do
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
					table.insert(Ambulances, {
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
			for k,v in pairs(Ambulances) do
				if xPlayer.identifier == v.identifier then
					if xPlayer.job.name == 'offduty' then
						v.duty_status = 1
						v.color = "red"
						break
					else
						table.remove(Ambulances, k)
						break
					end
				end
			end
		end
		table.sort(Ambulances, function (a, b) 
			if(a ~= nil and b ~= nil) then
				return a.duty_status> b.duty_status 
			end
		end)
	end
end)


RegisterServerEvent("esx_emsmdt:UpdateNotepad")
AddEventHandler("esx_emsmdt:UpdateNotepad", function(note) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
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
        DropPlayer(_source, "BAN") --Trigger do bana
    end
end)


ESX.RegisterServerCallback('esx_emsmdt:SendAnnounce', function(source, cb, text) -- to do
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' and xPlayer.job.grade_name == 'boss' then
        if(text ~= nil and text ~= "") then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname, phone_number FROM users WHERE identifier = @identifier', {
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
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent("esx_emsmdt:RemoveAnnounce")
AddEventHandler("esx_emsmdt:RemoveAnnounce", function(data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' and xPlayer.job.grade_name == 'boss' then
        if(data.fp ~= nil and data.ogloszenie ~= nil) then
            MySQL.Async.execute(OgloszeniaDelete, {data.fp, data.ogloszenie})
        end
    else
        DropPlayer(_source, "BAN") --Trigger do bana
    end
end)


ESX.RegisterServerCallback('esx_emsmdt:SendRaport', function(source, cb, text) -- to do
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
        if(text ~= nil and text ~= "") then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname, phone_number FROM users WHERE identifier = @identifier', {
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
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_emsmdt:RemoveRaport')
AddEventHandler('esx_emsmdt:RemoveRaport', function(data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' and xPlayer.job.grade_name == 'boss' then
        if(data.fp ~= nil and data.raport ~= nil) then
            MySQL.Async.execute(RaportyDelete, {data.fp, data.raport})
        end

    else 
        DropPlayer(_source, "BAN") -- Trigger do bana
    end
end)

RegisterServerEvent('esx_emsmdt:WystawFakture')
AddEventHandler('esx_emsmdt:WystawFakture', function(data) -- to do
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(data.id)
    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
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

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
				if account then
					account.addMoney(faktura * 0.80)
				end
			end)

            xPlayer.addMoney(faktura * 0.20)

			xPlayer.showNotification('Wystawiono fakturę dla ['..xTarget.source..'] o wartości: ~g~'..faktura..' ~s~$')
			xTarget.showNotification('Otrzymano fakturę od ['..xPlayer.source..'] o wartości: ~g~'..faktura..' ~s~$')
		end
    else
        DropPlayer(_source, "BAN")
    end
end)

ESX.RegisterServerCallback('esx_emsmdt:SearchPersonKartaPacjenta', function(source, cb, data) -- done
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
        MySQL.Async.fetchAll(KartaSearch, {data.firstname, data.lastname}, function(result)
            cb(result)
        end)
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_emsmdt:PersonMoreInfo', function(source, cb, data) -- to do
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
        local identifier = data.identifier
		
		local licenses = MySQL.Sync.fetchAll('SELECT * FROM user_licenses WHERE owner = @identifier', {
			['@identifier']	= identifier
		})
		
        local moreinfodata = {
            faktury = MySQL.Sync.fetchAll(HistoriaSelect, {identifier}),
            notatki = MySQL.Sync.fetchAll(KartaNotatkiSelect, {identifier}),
            licenses = licenses
        }
        cb(moreinfodata)
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_emsmdt:AddNotatkaKarta', function(source, cb, data) -- to do
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
        local identifier = data.identifier
		
		local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xPlayer.identifier
		})[1]	
		
		if xPlayerSQL ~= nil then
			local notedata = {
				notatka = data.note,
				doctor = xPlayerSQL.firstname.." "..xPlayerSQL.lastname,
				date = os.time(os.date("!*t"))
			}
			cb(notedata)
			MySQL.Async.execute(KartaNotatkiInsert, {identifier, notedata.notatka, notedata.doctor})
		end
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end

end)

RegisterServerEvent('esx_emsmdt:RemoveFakturaKarta')
AddEventHandler('esx_emsmdt:RemoveFakturaKarta', function(data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
        local id = data.id
        local identifier = data.identifier
        MySQL.Async.execute(HistoriaDelete, {id, identifier})
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_emsmdt:RemoveNotatkiKarta')
AddEventHandler('esx_emsmdt:RemoveNotatkiKarta', function(data) --done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
        local identifier = data.identifier
        local note = data.note

        MySQL.Async.execute(KartaNotatkiDelete, {identifier, note})
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_emsmdt:licencjaDodaj')
AddEventHandler('esx_emsmdt:licencjaDodaj', function(data) -- to do
    local _source = source
    local identifier = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
		MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
			['@type']  = data.type,
			['@owner'] = identifier
		})
			
		if xTarget ~= nil then
			xTarget.showNotification('Otrzymałeś licencje: ' .. changekLicenseName(data.type))
		end
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_emsmdt:licencjaUsun')
AddEventHandler('esx_emsmdt:licencjaUsun', function(data) -- to do
    local _source = source
    local identifier = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer ~= nil and xPlayer.job.name == 'ambulance' then
		MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
			['@type']  = data.type,
			['@owner'] = identifier
		})
	
		if xTarget ~= nil then
			xTarget.showNotification('Straciłeś licencje: ' .. changekLicenseName(data.type))
		end
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)


function changekLicenseName(licencja)
	local name = "";
	if(licencja == "nw" ) then
		name = "Ubezpieczenie NW"
		return name
	elseif (licencja == "ambulance_firstaid" ) then
		name = "Kurs 1 pomocy"
		return name
	elseif (licencja == 'test_psycho') then
		name = "Test psychologiczny"
		return name	
    elseif (licencja == "weapon" ) then
		name = "licencję na broń krótką"
		return name	
	end
end