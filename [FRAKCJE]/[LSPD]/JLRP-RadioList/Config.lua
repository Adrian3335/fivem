Config = {}

Config.UseRPName = true 							-- If set to true, it uses either esx-legacy or qb-core built-in function to get players' RP name

Config.LetPlayersChangeVisibilityOfRadioList = true	-- Let players to toggle visibility of the list
Config.RadioListVisibilityCommand = "toggleradio" 	-- Only works if Config.LetPlayersChangeVisibilityOfRadioList is set to true

Config.LetPlayersSetTheirOwnNameInRadio = true		-- Let players to customize how their name is displayed on the list
Config.ResetPlayersCustomizedNameOnExit = true		-- Only works if Config.LetPlayersSetTheirOwnNameInRadio is set to true - Removes customized name players set for themselves on their server exit
Config.RadioListChangeNameCommand = "zmiennazwe" 	-- Only works if Config.LetPlayersSetTheirOwnNameInRadio is set to true

Config.RadioChannelsWithName = {
	["0"] = "Admin",
	["1"] = "LSPD",
	["2"] = "LSPD #1",
	["3"] = "LSPD #2",
	["4"] = "LSPD #3",
	["5"] = "LSPD #4",
	["6"] = "EMS #1",
	["7"] = "LSC #1",
}