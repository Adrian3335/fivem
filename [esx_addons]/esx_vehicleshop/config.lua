Config = {}

Config.PlateLetters  = 4 -- Litery na tablicy rejestracyjnej
Config.PlateNumbers  = 4 -- Numery na tablicy rejestracyjnej
Config.PlateUseSpace = false -- TRUE jeśli chcesz spacje na tablicy
Config.EnablePed = true -- Włącz/Wyłącz Peda
Config.SpawnVehicle = true  -- TRUE jeśli chcesz aby furka spawnowała się po zakupie

Config.TestDrive = true     -- TRUE jeśli chcesz testową jazdę
Config.TestDriveTime = 30   -- Czas w sekundach testowej jazdy
Config.Target = 'qtarget' -- Zmień na target który używa //AddCircleZone\\  Polecam bt-target/qtarget : https://github.com/overextended/qtarget
Config.Ped = {
	{ x = -42.74109,   y = -1091.816, z = 25.422344, heading = 173.79647 } -- KORDY GDZIE MA STAĆ PED
}

Config.Blip = {
    vector3(-42.74109, -1091.816, 26.422344) -- Blip Głównego Car Dealera
}

Config.Shops = {
    [1] = {
        category = 'pdm', 
        coords = vector3(-42.74109, -1091.816, 26.422344) -- KORDY VEHICLE SHOPA
    }
    
}