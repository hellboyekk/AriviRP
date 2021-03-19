Config              = {}
Config.JailBlip     = {x = 1854.00, y = 2622.00, z = 45.00}
Config.JailLocation = {x = 1657.73, y = 2538.08, z = 45.5649}
Config.Locale = 'en'
Config.Marker = true
Config.Notify = false
Config.Usuntimeessen = math.random(1,4)
-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 146, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 0,   ['pants_1']  = 3,
			['pants_2']  = 7,   ['shoes_1']  = 12,
			['shoes_2']  = 12,  ['chain_1']  = 50,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 3,   ['tshirt_2'] = 0,
			['torso_1']  = 38,  ['torso_2']  = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 2,   ['pants_1']  = 3,
			['pants_2']  = 15,  ['shoes_1']  = 66,
			['shoes_2']  = 5,   ['chain_1']  = 0,
			['chain_2']  = 2
		}
	}
}

Config.JailPositions = {
	["Cell"] = { ["x"] = 1799.8345947266, ["y"] = 2489.1350097656, ["z"] = -119.02998352051, ["h"] = 179.03021240234 }
}

Config.Cutscene = {
	["PhotoPosition"] = { ["x"] = 402.91567993164, ["y"] = -996.75970458984, ["z"] = -99.000259399414, ["h"] = 186.22499084473 },

	["CameraPos"] = { ["x"] = 402.88830566406, ["y"] = -1003.8851318359, ["z"] = -97.419647216797, ["rotationX"] = -15.433070763946, ["rotationY"] = 0.0, ["rotationZ"] = -0.31496068835258, ["cameraId"] = 0 },

	["PolicePosition"] = { ["x"] = 402.91702270508, ["y"] = -1000.6376953125, ["z"] = -99.004028320313, ["h"] = 356.88052368164 }
}


Config.Teleports = {
	["Prison Work"] = { 
		["x"] = 992.51770019531, 
		["y"] = -3097.8413085938, 
		["z"] = -38.995861053467, 
		["h"] = 81.15771484375, 
		["goal"] = { 
			"Jail" 
		} 
	},

	["Boiling Broke"] = { 
		["x"] = 1845.6022949219, 
		["y"] = 2585.8029785156, 
		["z"] = 45.672061920166, 
		["h"] = 92.469093322754, 
		["goal"] = { 
			"Security" 
		} 
	},

	["Jail"] = { 
		["x"] = 1800.6979980469, 
		["y"] = 2483.0979003906, 
		["z"] = -122.68814849854, 
		["h"] = 271.75274658203, 
		["goal"] = { 
			"Prison Work", 
			"Security", 
			"Visitor" 
		} 
	},

	["Security"] = { 
		["x"] = 1706.7625732422,
		["y"] = 2581.0793457031, 
		["z"] = -69.407371520996, 
		["h"] = 267.72802734375, 
		["goal"] = { 
			"Jail",
			"Boiling Broke"
		} 
	},

	["Visitor"] = {
		["x"] = 1699.7196044922, 
		["y"] = 2574.5314941406, 
		["z"] = -69.403930664063, 
		["h"] = 169.65020751953, 
		["goal"] = { 
			"Jail" 
		} 
	}
}


Config.Jobs = {
	Marker = {
		Color = {r = 204, g = 204, b = 0},
		Size  = {x = 3.0, y = 3.0, z = 1.0}, 
		Type  = 1
	},
	List = {
		{
			Pos = {x = 1689.326, y = 2551.525, z = 44.564},
			Name = '#1'
		},
		{
			Pos = {x = 1700.200, y = 2474.780, z = 44.564},
			Name = '#2'
		},
		{
			Pos = {x = 1609.010, y = 2566.986, z = 44.564},
			Name = '#3'
		},
		{
			Pos = {x = 1717.449, y = 2567.409, z = 44.564},
			Name = '#4'
		},
		{
			Pos = {x = 1772.111, y = 2546.052, z = 44.586},
			Name = '#5'
		}
	}
}


Config.ArrestedCutScene = {
	Player = {coord = vector3(1817.81, 2593.97, 45.62), head = 91.55, dest = vector3(1791.79, 2593.74, 45.8)},

	NPC = {
		{coord = vector3(1818.24, 2595.68, 45.72), head = 91.55, dest = vector3(1792.56, 2595.48, 45.8), dhead = 350.66, ped = "s_m_m_prisguard_01"},
		{coord = vector3(1818.22, 2592.58, 45.72), head = 91.55, dest = vector3(1792.54, 2592.55, 45.8), dhead = 350.60, ped = "s_m_m_prisguard_01"}
	},

	Cams = {
		["Cam0"] = {
			coord = vector3(1813.53, 2592.08, 44.86),
			rot = vector3(0, 0, 0)
		},

		["Cam1"] = {
			coord = vector3(1803.19, 2594.77, 45.8),
			rot = vector3(0, 0, -90)
		},

		["Cam2"] = {
			coord = vector3(1800.04, 2596.17, 45.8),
			rot = vector3(0, 0, 140)
		},

		["Cam3"] = {
			coord = vector3(1757.1, 2510.36, 45.57),
			rot = vector3(0, 0, -17)
		},
	},
}

Config.PrisonZones = {
	["SPos"] = {
		coord = vector3(1775.54, 2552.04, 45.57),
		heading = 93.0
	},

	["9AB"] = {
		coord = vector3(1760.02, 2513.09, 45.81),
		peds = {coord = vector3(1760.02, 2513.09, 45.81-0.95), head = 76.42,	ped = "s_m_m_prisguard_01"}
	}
}


Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 56, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 0,   ['pants_1']  = 3,
			['pants_2']  = 7,   ['shoes_1']  = 89,
			['shoes_2']  = 0
		},
		female = {
			['tshirt_1'] = 15,   ['tshirt_2'] = 0,
			['torso_1']  = 23,  ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 0,   ['pants_1']  = 64,
			['pants_2']  = 1,  ['shoes_1']  = 69,
			['shoes_2']  = 1,   ['chain_1']  = 0,
			['chain_2']  = 0
		}
	}
}