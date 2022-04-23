fx_version 'bodacious'
game 'gta5'

description 'LP Job Listing'

version '0.0.1'

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

dependency {
	'es_extended',
	'ox_lib'
}
