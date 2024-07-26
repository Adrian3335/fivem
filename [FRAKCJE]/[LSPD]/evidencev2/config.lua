Config = {

-- IMPORTANT! To configure report text navigate to /html/script.js and find the text you want to replace

EvidenceReportInformationBullet = "firstname, lastname, job, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationFingerprint = "firstname, lastname, job, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationBlood = "firstname, lastname, job, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)

ShowBloodSplatsOnGround = true, -- Show blood on the ground when player is shot
PlayClipboardAnimation = true, -- Play clipboard animation when reading report

JobRequired = 'police', -- The job needed to use evidence system
JobGradeRequired = 0, -- The MINIMUM job grade required to use evidence system (If you use 0 all job grades can use the system)

CloseReportKey = 'BACKSPACE', -- The key used to close the report
PickupEvidenceKey = 'E', -- The key used to pick up evidence

EvidenceAlanysisLocation = vector3(483.7750, -987.8354, 30.6896), -- The place where the evidence will be analyzed and report generated
TimeToAnalyze = 10000, -- Time in miliseconds to analyze the given evidence
TimeToFindFingerprints = 3000, -- Time in miliseconds to find fingerprints in a car

--UPDATE V2
RainRemovesEvidence = true, -- Removes evidence when it starts raining!
TimeBeforeCrimsCanDestory = 300, -- Seconds before Criminals can destroy evidence (300 is the time when evidence coolsdown and shows up as WARM)
EvidenceStorageLocation = vector3(446.7906, -996.8152, 30.6895), -- The place where all evidence are being archived! You can view old evidence or delete it
--

Text = {

	--UPDATE V2
	['not_in_vehicle'] = 'To use this you need to be in a vehicle!',
	['remove_evidence'] = 'Zniszcz dowody [~r~E~w~]',
	['cooldown_before_pickup'] = 'dowód jest za bardzo świeży by go móc usunąć',
	['evidence_removed'] = 'Dowód zniszczony!',
	['open_evidence_archive'] = '[~o~E~w~] Zobacz Archiwum Dowodów',
	['evidence_archive'] = 'Achiwum dowodowe',
	['view'] = 'Zobacz',
	['delete'] = 'Usuń',
	['report_list'] = 'Raport #',
	['evidence_deleted_from_archive'] = 'Dowód usunięty z archiwum!',
	--

	['evidence_colleted'] = 'Dowód #{number} zebrany!',
	['no_more_space'] = 'Brak miejsca na dowody 3/3',
	['analyze_evidence'] = '[~g~E~w~] Analizuj Dowód',
	['evidence_being_analyzed'] = 'Dowód jest analizowany przez osoby z laboratorium',
	['evidence_being_analyzed_hologram'] = '~r~Dowód~w~ jest analizowany proszę czekać',
	['read_evidence_report'] = '[~o~E~w~] Przeczytaj Raport dowodowy',
	['analyzing_car'] = 'Auto jest analizowane! Poczekaj',
	['pick_up_evidence_text'] = 'Zabezpiecz Dowód [~g~E~w~]',
	['no_fingerprints_found'] = 'Nie znaleziono odcisków palców',
	['no_evidence_to_analyze'] = "Brak dowodów do analizy",
	['shell_hologram'] = 'łuska nabojowa ~b~Broni {guncategory} ~w~',
	['blood_hologram'] = '~r~Plama Krwi',

	['blood_after_0_minutes'] = 'Status: ~r~ŚWIEŻA',
	['blood_after_5_minutes'] = 'Status: ~y~WYSYCHAJĄCA',
	['blood_after_10_minutes'] = 'Status: ~b~USCHNIĘTA',

	['shell_after_0_minutes'] = 'Status: ~r~GORĄCY',
	['shell_after_5_minutes'] = 'Status: ~y~CIEPŁY',
	['shell_after_10_minutes'] = 'Status: ~b~ZIMNY',


	['submachine_category'] = 'Klasy II',
	['pistol_category'] = 'Klasy II',
	['shotgun_category'] = 'Klasy III',
	['assault_category'] = 'Klasy III',
	['lightmachine_category'] = 'Klasy IV',
	['sniper_category'] = 'Klasy IV',
	['heavy_category'] = 'Klasy IV',


}
	

}

-- Only change if you know what are you doing!
function SendTextMessage(msg)

		--SetNotificationTextEntry('STRING')
		--AddTextComponentString(msg)
		--DrawNotification(0,1)
           ESX.ShowNotification(msg)
		--EXAMPLE USED IN VIDEO
		--exports['mythic_notify']:SendAlert('inform', msg)

end