--[[
  _____ _____  ______     _  _______ ______ _____    ______     __  _   _   _   ______ _______   _____  _____  ______ _____   _____
 / ____|  __ \|  ____|   / \|__   __|  ____|  __ \  |  _ \ \   / / | \ | | | | |  ____|__   __| / ___ \|  __ \|  ____|  __ \ |__   |
| |    | |__) | |__     / _ \  | |  | |__  | |  | | | |_)|\ \_/ /  |  \| | | | | |__     | |   | /   \ | |__) | |__  | |__) |   / /
| |    |  _  /|  __|   / /_\ \ | |  |  __| | |  | | |  _ < \   /   | . ` | | | |  __|    | |   | |   | |  ___/|  __| |  _  /   / /
| |____| | \ \| |____ / _____ \| |  | |____| |__| | | |_) | | |    | |\  | | | | |____   | |   | \___/ | |    | |____| | \ \  / /__
 \_____|_|  \_\______/_/     \_\_|  |______|_____/  |____/  |_|    |_| \_| |_| |______|  |_|    \_____/|_|    |______|_|  \_\|_____|
Nietoperz#9211
]]

fx_version 'cerulean'
game 'gta5'

files {
    'data/**/*.meta'
}
 
data_file 'WEAPONCOMPONENTSINFO_FILE' 'data/**/weaponcomponents*.meta'
data_file 'WEAPON_METADATA_FILE'  'data/**/weaponarchetypes*.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/**/weaponanimations*.meta'
data_file 'WEAPONINFO_FILE' 'data/**/weaponaddons*.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/**/weapons*.meta'

client_script 'client.lua'