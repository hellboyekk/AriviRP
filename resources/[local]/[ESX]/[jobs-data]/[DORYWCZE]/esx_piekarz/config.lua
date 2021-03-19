Config                            = {}
--Widoczno�� marker�w (wszystikch)
Config.DrawDistance               = 20.0
--Zb�dne 
Config.EnablePlayerManagement     = false
Config.EnableSocietyOwnedVehicles = false
Config.MaxInService               = -1
Config.Locale                     = 'en'
--Markery Firmowe (szatnia,bossmenu)
Config.MarkerType                 = 1 --Rodzaj markeru firmowego
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 } --Wielko�� markeru firmowego
Config.MarkerColor                = { r = 102, g = 0, b = 102 } --Kolor markeru firmowego 

--Blipy
Config.Blipikon                   = 478  --Tutaj ustawiamy ikonke blip�w
Config.Blipwielkosc               = 1.0  --Tutaj ustawiamy wielko�� blip�w
Config.Blipkolor                  = 4 --Tutaj ustawiamy kolor blip�w

---Zarobki
Config.Wyplata1                   = 29000 --Tutaj ustawiamy minimaln� wyp�ate dla pracownika
Config.Wyplata2                   = 34000 --Tutaj ustawiamy maksymaln� wyp�at� dla pracownika
--Config.WypFirma1                  = 3999 --Tutaj ustawiamy minimanln� wyp�ate dla firmy
--Config.WypFirma2                  = 5000 --Tutaj ustawiamy maksymaln� wyp�ate dla firmy 

--Czasy Czynno�ci
Config.Czasprzebierania           = 2 --Tutaj ustawiamy czas animacji przebierania
Config.Czasmaterial               = 6000 --Tutaj ustawiamy czas zbierania materia�u
Config.Czasszycie                 = 6000 --Tutaj ustawiamy czas szycia 
Config.Czaspako                   = 6000 --Tutaj ustawiamy czas pakowania
Config.Czasoddam                  = 6000 --Tutaj ustawiamy czas sprzeda�y

Config.Baza = {

	Cloakrooms = {
		Pos   = {x = 1709.85, y = 4728.26, z = 42.15}, 
        Size  = {x = 5.0, y = 5.0, z = 1.0}, 
        Color = {r = 204, g = 204, b = 0}, 
        Name  = "#1 Baza firmy", 
        Type  = 1
	},
}

Config.Zones = {


    Material = {
        Pos   = {x = 1914.14, y = 4766.99, z = 41.95}, --Kordy zbierania materia�u -981.64 -2744.88 20.21 
        Size  = {x = 3.0, y = 3.0, z = 1.0}, --Wielko�� markeru zbierania materia�u 
        Color = {r = 204, g = 204, b = 0}, --Kolor markeru zbierania materia�u
        Name  = "#2 Zbior zboza", --Nazwa blipa
        Type  = 1
    },


    Szycie = {
        Pos   = {x = 1902.83, y = 4921.83, z = 47.78}, --Kordy szycia
                Size  = {x = 6.0, y = 6.0, z = 1.0}, --Wielko�� markeru szycia
                Color = {r = 204, g = 204, b = 0}, --Kolor markeru szycia
        Name  = "#3 Przerobka zboza na make", --Nazwa blipa
        Type  = 1
    },

    Pakowanie = {
        Pos   = {x =  2242.55, y = 5153.12, z = 56.32}, --Kordy pakowania
        Size  = {x = 6.0, y = 6.0, z = 1.0}, --Wielko�c markeru pakowania
        Color = {r = 204, g = 204, b = 0}, -- Kolor markeru pakowania
        Name  = "#4 Przerobka maki na chleb", --Nazwa blipa
        Type  = 1
    },

    SellFarm = {
        Pos   = {x = 548.1, y = 2668.87, z = 42.16}, --Kordy oddawania
        Size  = {x = 5.0, y = 5.0, z = 1.0}, --Wielko�� markeru oddawania
        Color = {r = 204, g = 204, b = 0}, --Kolor markeru oddawania
        Name  = "#5 Sprzedaz chleba", --Nazwa Blipa
        Type  = 1
    },

}
Config.PSM = {
    PSM = {
        Vehicles = {
            {
                Spawner    = { x = 1718.93, y = 4711.06, z = 41.25 },
                SpawnPoint = { x = 1721.88, y = 4701.91, z = 42.59 }, --1721.88 4701.91 42.59 271.2
                Heading    = 271.2
            }
        },

        PsmActions = {
            {x = 000.64, y = 000.88, z = 000.21},
         },

        Cloakrooms = {
            {x = 1709.85, y = 4728.26, z = 41.25},
        },

        VehicleDeleters = {
            {x = 1726.15, y = 4711.15, z = 41.25},
        },
    }
}
Config.AuthorizedVehicles = {
	{
		grade = 0,
		model = 'burrito3',     
		label = 'Pojazd sluzbowy' ,
	},
}

