fx_version "bodacious"
games {"gta5"}
lua54 'yes'
server_scripts {
	'server/main.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'config.lua'
}

server_exports {
	"GetPolice"
}
