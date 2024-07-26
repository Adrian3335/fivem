fx_version 'cerulean'
game 'gta5'

description '5City Vehicle Shop'
author 'edited by many#3330'
version '6.9'

server_scripts {
	'@mysql-async/lib/MySQL.lua',			
	'config.lua',
	'eotix.lua',
	'server/server.lua',
}

client_scripts {		
	'config.lua',
	'eotix.lua',
	'client/utils.lua',
	'client/client.lua'
}

files {
    'html/index.html',
	'html/carousel.css',	
    'html/carousel.js',
	'html/design.css',
	'html/script.js',		
	'html/pickr.es5.min.js',	
	'html/picker.js',	
	'html/jquery-ui.js',
	'html/jqueri-ui.css',
	'html/nano.min.css',	
    'html/images/*.png',
    'html/fonts/*.ttf',
    'imgs/*.png',
	'imgs/brands/*.png',	
}

ui_page 'html/index.html'

dependencies {
	'es_extended'
}

export 'GeneratePlate'server_scripts { '@mysql-async/lib/MySQL.lua' }