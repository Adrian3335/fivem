ESX = exports["es_extended"]:getSharedObject()

local CharCount, VehCount, LiczbaMandatowPrzezMiesiac, LiczbaMandatowPrzezTydzien, PhoneNumber, KartotekaSearch, Police, OstatnieMandatySelect, VehiclesByPlate, VehiclesByIdentifier, PropertiesByIdentifier, NotepadSelect, NotepadInsert, NotepadUpdate, OgloszeniaSelect, OgloszeniaInsert, OgloszeniaDelete, RaportySelect, RaportyInsert, RaportDelete, JudgmentsSelect, JudgmentsInsert, JudgmentsDelete, PoszukiwaniaSelect, PoszukiwaniaInsert, PoszukiwaniaDelete, KartotekaNotatkiSelect, KartotekaNotatkiInsert, KartotekaNotatkiDelete = -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1

MySQL.ready(function() -- done
    Properties = {}
    CharCount = MySQL.Sync.store("SELECT COUNT(*) FROM `users`");
    VehCount = MySQL.Sync.store("SELECT COUNT(*) FROM `owned_vehicles`");
    LiczbaMandatowPrzezMiesiac = MySQL.Sync.store("SELECT COUNT(*) FROM `lspdmdt_judgments`WHERE date between date_sub(now(),INTERVAL 1 MONTH) and now();")
    LiczbaMandatowPrzezTydzien = MySQL.Sync.store("SELECT COUNT(*) FROM `lspdmdt_judgments` WHERE date between date_sub(now(),INTERVAL 1 WEEK) and now();")
    PhoneNumber = MySQL.Sync.store("SELECT `phone_number` FROM `users` WHERE `identifier` = ?")
    MySQL.Async.store("SELECT `identifier`, `firstname`, `lastname`, `dateofbirth`, `phone_number` FROM `users` WHERE `firstname` = ? AND `lastname` = ?", function(storeId)
        KartotekaSearch = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_judgments` WHERE date between date_sub(now(),INTERVAL 1 WEEK) and now() ORDER BY id DESC;", function(storeId)
		OstatnieMandatySelect = storeId
	end)
    MySQL.Async.store('SELECT users.firstname, users.lastname, users.phone_number, owned_vehicles.vehicle, owned_vehicles.plate FROM owned_vehicles INNER JOIN users ON owned_vehicles.owner = users.identifier WHERE owned_vehicles.plate LIKE ?;', function(storeId)
		VehiclesByPlate = storeId
	end)
    MySQL.Async.store('SELECT `vehicle`, `plate` FROM `owned_vehicles` WHERE `identifier` = ?', function(storeId)
		VehiclesByIdentifier = storeId
	end)
    MySQL.Async.store('SELECT `name` FROM `owned_properties` WHERE `owner` = ?', function(storeId)
		PropertiesByIdentifier = storeId
	end)
    MySQL.Async.store("SELECT `notatka` FROM `lspdmdt_notatki` WHERE `identifier` = ?", function(storeId)
		NotepadSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_notatki`(`identifier`, `notatka`) VALUES (?,?)', function(storeId)
        NotepadInsert = storeId
    end)
    MySQL.Async.store('UPDATE `lspdmdt_notatki` SET `notatka` = ? WHERE `identifier` = ?', function(storeId)
        NotepadUpdate = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_ogloszenia`", function(storeId)
		OgloszeniaSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_ogloszenia`(`fp`, `ogloszenie`) VALUES (?,?)', function(storeId)
        OgloszeniaInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_ogloszenia` WHERE `fp` = ? AND `ogloszenie` = ?', function(stroeId)
        OgloszeniaDelete = stroeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_raporty`", function(storeId)
		RaportySelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_raporty`(`fp`, `raport`) VALUES (?,?)', function(storeId)
        RaportyInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_raporty` WHERE `fp` = ? AND `raport` = ?', function(stroeId)
        RaportDelete = stroeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_judgments` WHERE `identifier` = ?", function(storeId)
		JudgmentsSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_judgments`(`identifier`, `charname`, `fp`, `reason`, `fee`, `length`) VALUES (?,?,?,?,?,?)', function(storeId)
        JudgmentsInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_judgments` WHERE `id` = ? AND `identifier` = ?', function(storeId)
        JudgmentsDelete = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_poszukiwani` WHERE `identifier` = ?", function(storeId)
		PoszukiwaniaSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_poszukiwani`(`identifier`, `fp`, `reason`) VALUES (?,?,?)', function(storeId)
        PoszukiwaniaInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_poszukiwani` WHERE `identifier` = ? AND `reason` = ?', function(storeId)
        PoszukiwaniaDelete = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_kartoteka_notatki` WHERE `identifier` = ?", function(storeId)
		KartotekaNotatkiSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_kartoteka_notatki`(`identifier`, `notatka`, `fp`) VALUES (?,?,?)', function(storeId)
        KartotekaNotatkiInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_kartoteka_notatki` WHERE `identifier` = ? AND `notatka` = ?', function(storeId)
        KartotekaNotatkiDelete = storeId
    end)

    MySQL.Async.fetchAll('SELECT name, label, entering FROM properties', {}, function(result)		
		if result[1] ~= nil then
			for k,v in ipairs(result) do
				Properties[v.name] = {
					label = v.label,
					coords = v.entering
				}		
			end	
		end
	end)
	
    Polices = MySQL.Sync.fetchAll("SELECT `identifier`, `firstname`, `lastname`, `phone_number` FROM `users` WHERE `job` = ?", {"police"})
    
	for k,v in pairs(Polices) do
        v.duty_status = 1
        v.color = "red"
    end
end) 

AddEventHandler('playerDropped', function(reason) -- done
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then		
        for k,v in pairs(Polices) do
            if xPlayer.identifier == v.identifier then
                v.duty_status = 1
                v.color = "red"
            end
        end
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:GetVehicleByPlate', function(source, cb, plate) -- done
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        MySQL.Async.fetchAll(VehiclesByPlate, {plate..'%'}, function(result)
            local vehdata = {}
            
            for k,v in pairs(result) do
                local vehicle = json.decode(v.vehicle)
                local numer_telefonu = v.phone_number
                if(numer_telefonu == "") then
                    numer_telefonu = "Brak"
                end
				
                local veharray = {
                    ownername = v.firstname.." "..v.lastname,
                    plate = v.plate,
                    model = vehicle.name,
                    phone_number = numer_telefonu
                }
                table.insert(vehdata, veharray)
            end
            cb(vehdata)
        end)
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:SearchNumber', function(source, cb, numer) -- done
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then	
		local numerarray = {
			ownername = 'Brak',
			phone_number = numer
		}
		
		local findNumber = MySQL.Sync.fetchAll('SELECT identifier FROM user_sim WHERE number = @number', {
			['@number']	= numer
		})		
		
		if findNumber[1] ~= nil then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier']	= findNumber[1].identifier
			})		
			
			if xPlayerSQL[1] ~= nil then
				numerarray.ownername = xPlayerSQL[1].firstname..' '..xPlayerSQL[1].lastname
			end
		end
				
		cb(numerarray)	
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:SearchPersonKartoteka', function(source, cb, data) -- done
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        MySQL.Async.fetchAll(KartotekaSearch, {data.firstname, data.lastname}, function(result)
            cb(result)
        end)
        exports['beauty_logs']:SendLog(xPlayer.source, "TABLET POLICYJNY | Szukał osoby: [" ..data.firstname.." " ..data.lastname.." ]", 'fines', '4958705')
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)


RegisterServerEvent('esx_lspdmdt:WystawMandat')
AddEventHandler('esx_lspdmdt:WystawMandat', function(data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(data.id)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
		local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xPlayer.identifier
		})		

		local xTargetSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xTarget.identifier
		})	
		
		if xPlayerSQL[1] ~= nil and xTargetSQL[1] ~= nil then
			local fp = xPlayerSQL[1].firstname.." "..xPlayerSQL[1].lastname
			local name = xTargetSQL[1].firstname..' '..xTargetSQL[1].lastname
			local mandat = tonumber(data.fee)
			MySQL.Async.execute(JudgmentsInsert, {xTarget.identifier, xTargetSQL[1].firstname.." "..xTargetSQL[1].lastname, fp, data.text, mandat, 0})
				
			xTarget.removeAccountMoney('bank', mandat)

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..xPlayer.job.name, function(account)
				if account then
					account.addMoney(mandat * 0.80)
				end
			end)

            xPlayer.addMoney(mandat * 0.20)
			
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message"> <i class="far fa-newspaper" style="color:rgba(0, 153, 204, 1.0)"></i> <span class="chat-text"> &nbsp; {0}: {1} </span> </div>',
				args = {'MANDAT', name..' ^2 dostał mandat o wartosci ^7'..mandat..'$ ^1| ^2Powod: ^7'..data.text..' ^1| ^2Funkcjonariusz: ^7'..fp..'^1'}
			})
            exports['beauty_logs']:SendLog(xPlayer.source, "TABLET POLICYJNY | Wystawił Mandat graczowi: ["..name.. " o wartości " ..mandat.."$ z powodem " ..data.text.." ]", 'fines', '4958705')
		end
    else
        DropPlayer(_source, "BAN")
    end
end)


RegisterNetEvent('esx_lspdmdt:WystawWiezienie')
AddEventHandler('esx_lspdmdt:WystawWiezienie', function(data) -- done
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(data.id)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
		local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xPlayer.identifier
		})		

		local xTargetSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xTarget.identifier
		})	
		
		if xPlayerSQL[1] ~= nil and xTargetSQL[1] ~= nil then
			local fp = xPlayerSQL[1].firstname.." "..xPlayerSQL[1].lastname
			local name = xTargetSQL[1].firstname..' '..xTargetSQL[1].lastname
			local mandat = tonumber(data.fee)

			MySQL.Async.execute(JudgmentsInsert, {xTarget.identifier, xTargetSQL[1].firstname.." "..xTargetSQL[1].lastname, fp, data.text, mandat, data.length})

			xTarget.removeAccountMoney('bank', mandat)

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..xPlayer.job.name, function(account)
				if account then
					account.addMoney(mandat * 0.80)
				end
			end)

            TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message"> <i class="far fa-newspaper" style="color:rgba(0, 153, 204, 1.0)"></i> <span class="chat-text"> &nbsp; {0}: {1} </span> </div>',
				args = {'WIEZIENIE', name..' ^2 został skazany na ^7'..data.length..' miesięcy więziennia ^1| ^2Powod: ^7'..data.text..' ^1| ^2Funkcjonariusz: ^7'..fp..'^1'}
			})
            exports['beauty_logs']:SendLog(xPlayer.source, "TABLET POLICYJNY | Wysłał gracza do więzienia: [" ..name.." został skazany na " ..data.length.." miesięcy więzienia z powodem "..data.text.. " ]", 'fines', '4958705')

			-- TriggerEvent("esx_jtestailer:sendToJailPanelhype", xTarget.source, data.length * 60, data.text) (our trigger)
            -- TriggerEvent('xlem0n_jailer:wpierdolchuja', tonumber(args[1]), tonumber(args[2] * 60))
            TriggerEvent('xlem0n_jailer:wpierdolchuja', xTarget.source, data.length * 60, data.text)
		end
    else
        DropPlayer(_source, "BAN")
    end
end)


RegisterServerEvent("esx_lspdmdt:SendMdtData")
AddEventHandler("esx_lspdmdt:SendMdtData", function() -- done
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
        if xPlayer.job.name == 'police' then	
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier']	= xPlayer.identifier
			})		
		
			if xPlayerSQL[1] ~= nil then
				local MdtData = {
					charCount = MySQL.Sync.fetchScalar(CharCount),
					vehCount = MySQL.Sync.fetchScalar(VehCount),
					mandatyMiesiac = MySQL.Sync.fetchScalar(LiczbaMandatowPrzezMiesiac);
					mandatyTydzien = MySQL.Sync.fetchScalar(LiczbaMandatowPrzezTydzien);
					OstatnieMandaty = MySQL.Sync.fetchAll(OstatnieMandatySelect),
					Player = {
						firstname = xPlayerSQL[1].firstname,
						lastname = xPlayerSQL[1].lastname,
						job = xPlayer.job,
					},
					Police = Polices,
					Notepad = MySQL.Sync.fetchScalar(NotepadSelect, {xPlayer.identifier}),
					Ogloszenia = MySQL.Sync.fetchAll(OgloszeniaSelect),
					Raporty = MySQL.Sync.fetchAll(RaportySelect),
					Taryfikator = Config.Taryfikator
				}	
				TriggerClientEvent("esx_lspdmdt:SendMdtData", _source, MdtData)
			end
        else
            DropPlayer(_source, "BAN") --Trigger do bana
        end
	end
end)

RegisterServerEvent("esx_lspdmdt:UpdatePoliceStatus")
AddEventHandler("esx_lspdmdt:UpdatePoliceStatus", function(type) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
		local jestwtablicy = false
		
		if type == 'insert' then
			for k,v in pairs(Polices) do
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
				})
			
				if xPlayerSQL[1] ~= nil then
					table.insert(Polices, {
						identifier = xPlayer.identifier,
						firstname = xPlayerSQL[1].firstname,
						lastname = xPlayerSQL[1].lastname,
						phone_number = xPlayerSQL[1].phone_number,
						duty_status = 2,
						color = "green"
					})
				end
			end
		elseif type == 'remove' then
			for k,v in pairs(Polices) do
				if xPlayer.identifier == v.identifier then
					if xPlayer.job.name == 'offduty' then
						v.duty_status = 1
						v.color = "red"
						break
					else
						table.remove(Polices, k)
						break
					end
				end
			end
		end
        table.sort(Polices, function(a, b)
            if a ~= nil and b ~= nil and a.duty_status ~= b.duty_status then
                return tonumber(a.duty_status) > tonumber(b.duty_status)
            end
        end)
	end
end)

RegisterServerEvent("esx_lspdmdt:UpdateNotepad")
AddEventHandler("esx_lspdmdt:UpdateNotepad", function(note) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
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


ESX.RegisterServerCallback('esx_lspdmdt:SendAnnounce', function(source, cb, text) -- done
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade_name == 'boss' then
        if(text ~= nil and text ~= "") then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier']	= xPlayer.identifier
			})
			
			if xPlayerSQL[1] ~= nil then
				local announcedata = {
					owner = xPlayerSQL[1].firstname.." "..xPlayerSQL[1].lastname,
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

RegisterServerEvent("esx_lspdmdt:RemoveAnnounce")
AddEventHandler("esx_lspdmdt:RemoveAnnounce", function(data) -- -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade_name == 'boss' then
        if(data.fp ~= nil and data.ogloszenie ~= nil) then
            MySQL.Async.execute(OgloszeniaDelete, {data.fp, data.ogloszenie})
        end
    else
        DropPlayer(_source, "BAN") --Trigger do bana
    end

end)

ESX.RegisterServerCallback('esx_lspdmdt:SendRaport', function(source, cb, text) -- done
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if(text ~= nil and text ~= "") then
			local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier']	= xPlayer.identifier
			})
			
			if xPlayerSQL[1] ~= nil then
				local raportdata = {
					owner = xPlayerSQL[1].firstname.." "..xPlayerSQL[1].lastname,
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

RegisterServerEvent('esx_lspdmdt:RemoveRaport')
AddEventHandler('esx_lspdmdt:RemoveRaport', function(data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade_name == 'boss' then
        if(data.fp ~= nil and data.raport ~= nil) then
            MySQL.Async.execute(RaportDelete, {data.fp, data.raport})
        end

    else 
        DropPlayer(_source, "BAN") -- Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:PersonMoreInfo', function(source, cb, data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
        local vehdata = {}
		local licensesdata = {}
		
        MySQL.Async.fetchAll(VehiclesByIdentifier, {identifier}, function(result)
            for k,v in pairs(result) do
                local vehicle = json.decode(v.vehicle)
                table.insert(vehdata, {
                    model = vehicle.model,
                    plate = v.plate
                })
            end
        end)
		
		local licenses = MySQL.Sync.fetchAll('SELECT * FROM user_licenses WHERE owner = @identifier', {
			['@identifier']	= identifier
		})
		
        local houses = MySQL.Sync.fetchAll(PropertiesByIdentifier, {
            identifier
        })
        
        local temphouse = {}
        
        for k,v in ipairs(houses) do
            local house = Properties[v.name]
            
            if house then
                table.insert(temphouse, {
                    label = house.label,
                    coords = house.coords
                })
            end
        end
        local moreinfodata = {
            mandaty = MySQL.Sync.fetchAll(JudgmentsSelect, {identifier}),
            poszukiwania = MySQL.Sync.fetchAll(PoszukiwaniaSelect, {identifier}),
            pojadzy = vehdata,
            mieszkania = temphouse,
            notatki = MySQL.Sync.fetchAll(KartotekaNotatkiSelect, {identifier}),
            licenses = licenses
        }
        cb(moreinfodata)
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:AddPoszukiwaniaKartoteka', function(source, cb, data) -- done
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
		local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xPlayer.identifier
		})
		
		if xPlayerSQL[1] ~= nil then
			local poszukiwaniadata = {
				reason = data.reasonarea,
				fp = xPlayerSQL[1].firstname.." "..xPlayerSQL[1].lastname,
				date = os.time(os.date("!*t"))
			}
			cb(poszukiwaniadata)
			MySQL.Async.execute(PoszukiwaniaInsert, {identifier, poszukiwaniadata.fp, poszukiwaniadata.reason})
		end
        exports['beauty_logs']:SendLog(xPlayer.source, "TABLET POLICYJNY | Dodał poszukiwanie: ["..xPlayer.identifier.. " z powodem "..reason.." ]", 'fines', '4958705')
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:AddNotatkaKartoteka', function(source, cb, data) -- done
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
		local xPlayerSQL = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier']	= xPlayer.identifier
		})
		
		if xPlayerSQL[1] ~= nil then
			local notedata = {
				notatka = data.note,
				fp = xPlayerSQL[1].firstname.." "..xPlayerSQL[1].lastname,
				date = os.time(os.date("!*t"))
			}
			cb(notedata)
			MySQL.Async.execute(KartotekaNotatkiInsert, {identifier, notedata.notatka, notedata.fp})
            exports['beauty_logs']:SendLog(xPlayer.source, "TABLET POLICYJNY | Dodał notatkę: ["..xPlayer.identifier.. " z powodem "..reason.." ]", 'fines', '4958705')
		end
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end

end)


RegisterServerEvent('esx_lspdmdt:licencjaDodaj')
AddEventHandler('esx_lspdmdt:licencjaDodaj', function(data) -- done
    local _source = source
    local identifier = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
		MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
			['@type']  = data.type,
			['@owner'] = identifier
		})
			
		if xTarget ~= nil then
			xTarget.showNotification('Otrzymałeś licencje: ' .. changekLicenseName(data.type))
		end
        exports['beauty_logs']:SendLog(xPlayer.source, "TABLET POLICYJNY | Dodał licencje: ["..data.identifier.. " "..changekLicenseName(data.type).." ]", 'fines', '4958705')
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lspdmdt:licencjaUsun')
AddEventHandler('esx_lspdmdt:licencjaUsun', function(data) -- done
    local _source = source
    local identifier = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
		MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
			['@type']  = data.type,
			['@owner'] = identifier
		})
	
		if xTarget ~= nil then
			xTarget.showNotification('Straciłeś licencje: ' .. changekLicenseName(data.type))
		end
        exports['beauty_logs']:SendLog(xPlayer.source, "TABLET POLICYJNY | Zabrał licencje: ["..data.identifier.. " "..changekLicenseName(data.type).." ]", 'fines', '4958705')
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lspdmdt:RemoveMandatKartoteka')
AddEventHandler('esx_lspdmdt:RemoveMandatKartoteka', function(data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local id = data.id
        local identifier = data.identifier
        MySQL.Async.execute(JudgmentsDelete, {id, identifier})
        exports['beauty_logs']:SendLog(xPlayer.source, "TABLET POLICYJNY | Usunął mandat z kartoteki: [ ID "..id.. " "..identifier.." ]", 'fines', '4958705')
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lspdmdt:RemovePoszukiwaniaKartoteka')
AddEventHandler('esx_lspdmdt:RemovePoszukiwaniaKartoteka', function(data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
        local reason = data.reason
        MySQL.Async.execute(PoszukiwaniaDelete, {identifier, reason})
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end
end)

RegisterServerEvent('esx_lspdmdt:RemoveNotatkiKartoteka')
AddEventHandler('esx_lspdmdt:RemoveNotatkiKartoteka', function(data) -- done
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
        local note = data.note

        MySQL.Async.execute(KartotekaNotatkiDelete, {identifier, note})
    else
        DropPlayer(source, "BAN") --Trigger do bana
    end

end)

function changekLicenseName(licencja)
	local name = "";
	if(licencja == "drive_bike" ) then
		name = "prawo jazdy kat. A"
		return name
	elseif (licencja == "drive" ) then
		name = "prawo jazdy kat. B"
		return name
	elseif (licencja == "drive_truck" ) then
		name = "prawo jazdy kat. C"
		return name
	elseif (licencja == "weapon" ) then
		name = "licencję na broń krótką"
		return name
	elseif (licencja == 'test_psycho') then
		name = "Test psychologiczny:"
		return name		
	end
end

