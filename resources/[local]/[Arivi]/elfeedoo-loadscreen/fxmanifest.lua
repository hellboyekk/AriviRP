 -- MANIFEST
 resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

 -- GAME
 fx_version "bodacious"
 games {"gta5"}

 -- INFO
 author "elfeedoo"
 description "Loadscreen with PEPOZAUR"
 version "2.1.1"

 loadscreen_manual_shutdown "yes"

 -- FILES
 files {
    "index.html",
 -- CSS
    "css/index.css", 
    "css/colors.css", 
    "css/icomoon.css", 
 -- FONTS
    "fonts/gravity.otf", 
    "fonts/icomoon.ttf", 
    "fonts/nfs.ttf", 
 -- IMG
    "img/needed.png", 
    "img/logo.png", 
    "img/logo-ready.png", 
    "img/1px-res.png", 
    "img/bg1.jpg", 
    "img/bg2.jpg", 
    "img/bg3.jpg", 
    "img/EH.jpg",
 -- JS
    "js/synn.js",
    "js/config.js",
    "js/logger.js",
    "js/progressbar-handler.js",
    "js/progressbar-main.js",
    "js/progressbar-renderer.js",
    "js/music-handler.js",
    "js/music-controls.js",
    "js/background-handler.js",
    "js/index.js",
 }

 -- UI
 loadscreen {
    "index.html"
 }