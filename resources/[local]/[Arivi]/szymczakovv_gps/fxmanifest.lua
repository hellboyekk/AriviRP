fx_version 'adamant'
games { 'gta5' }

client_script 'config.lua'
client_script 'client.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua'
}