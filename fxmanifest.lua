fx_version 'cerulean'
game 'gta5'
author 'Author Name'
description 'Description'
version '1.0.0'

client_scripts {
    'client/client.lua',
};

server_scripts {
    'server/server.lua',
};

shared_scripts {
    'shared/config.lua',
};

--Setup nui
ui_page 'FrontEnd/index.html'

files {
    'FrontEnd/index.html',
    'FrontEnd/*.js',
    'FrontEnd/*.css',
    'FrontEnd/uikit/*.css',
    'FrontEnd/uikit/*.js',
    'FrontEnd/resources/*.*',
}