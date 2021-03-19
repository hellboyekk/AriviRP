Config                            = {}
Config.Locale                     = 'en'

Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = false
Config.EnableBlips = true


Config.PriceTriBike = 89
Config.PriceScorcher = 99
Config.PriceCruiser = 129
Config.PriceBmx = 109


Config.TypeMarker = 1
Config.MarkerScale = { x = 2.000, y = 2.000, z = 1.000}
Config.MarkerColor                = { r = 0, g = 130, b = 204 }
	
Config.MarkerZones = { 

    {x = -139.06, y = 6276.72, z = 30.37},--Paleto
    {x = 1854.84, y = 2624.25, z = 44.67},--Więzienie
    {x = 244.94, y = -561.19, z = 42.27},--SzpitalLS
    {x = -275.91, y = -1018.69, z = 29.37},--LS
    {x = -1223.77, y = -1495.48, z = 3.35},--Plaża
    {x = -1285.58, y = 294.69, z = 63.86},
    {x = -1046.41, y = -2725.95, z = 19.17}, -- resp
}

local cfg = {

title = "Wypożyczalnia Rowerów"

}

Config.BlipZones = { 

   {title= cfg.title, colour=84, id=226, x = -139.06, y = 6276.72, z = 30.43},
   {title= cfg.title, colour=84, id=226, x = 1854.84, y = 2624.25, z = 43.67},
   {title= cfg.title, colour=84, id=226, x = 244.94, y = -561.19, z = 42.27},
   {title= cfg.title, colour=84, id=226, x = -275.91, y = -1018.69, z = 29.37},
   {title= cfg.title, colour=84, id=226, x = -1223.77, y = -1495.48, z = 3.35},
   {title= cfg.title, colour=84, id=226, x = -1285.58, y = 294.69, z = 63.86},
   {title= cfg.title, colour=84, id=226, x = -1046.41, y = -2725.95, z = 19.17},
}