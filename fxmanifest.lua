fx_version 'bodacious'
game 'gta5'

description 'ESX Job Listing'

version '1.7.5'

lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'@ox_lib/init.lua',
	'locales/*.lua',
	'config.lua'
}

server_script 'server/main.lua'

client_script 'client/main.lua'

dependency 'es_extended'
