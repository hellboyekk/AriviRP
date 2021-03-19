Config                            = {}
Config.DrawDistance               = 10.0

Config.Blips = {
    ['org1'] = vector3(-1541.8, 126.41, 56.78),
	['org2'] = vector3(715.54, -767.54, 24.76), 
	['org3'] = vector3(-1037.0, 305.53, 66.99), 
	['org4'] = vector3(1398.81, 1146.78, 114.34),
	['org5'] = vector3(-2569.49, 1307.69, 147.12),
	['org6'] = vector3(829.93, 2190.65, 52.09),
	['org7'] = vector3(-1890.9, 2047.14, 140.86),        
	['org8'] = vector3(-818.58, 177.29, 72.23),
	['org9'] = vector3(392.69, -11.11, 85.67),  
	['org10'] = vector3(661.31, 6470.99, 32.87), 
	['org11'] = vector3(-1104.41, 4948.13, 218.54), 
	['org12'] = vector3(-1805.08, 444.74, 128.51), 
	['org13'] = vector3(-1569.46, 28.86, 59.38), 
	['org14'] = vector3(-661.33, 893.29, 229.25), 
	['org15'] = vector3(-120.86, 984.2, 235.78),
	['org16'] = vector3(-612.89, -1629.9, 33.01),
	['org17'] = vector3(975.15, -1830.43, 31.24), 
	['org18'] = vector3(817.06, -3087.98, 5.9),   
	['org19'] = vector3(826.87, -2333.3, 30.4),      
	['org20'] = vector3(8.99, 541.45, 176.03),  
	['org21'] = vector3(-1185.56, 287.95, 69.5),
	['org22'] = vector3(-87.86, 835.43, 235.72), 
	['org23'] = vector3(940.44, -1492.94, 30.08),    
	['org24'] = vector3(106.04, -1941.31, 20.8),
	['org25'] = vector3(333.52, -2037.32, 21.1),
	['org26'] = vector3(-1096.63, -1669.01, 8.41), 
	['org27'] = vector3(1151.03, -437.9, 67.0),    
	['org28'] = vector3(25.8, 6477.54, 31.88),  
	['org29'] = vector3(1569.54, -2130.13, 78.33),           
	['org30'] = vector3(872.92, -2203.24, 30.64),    
	['org31'] = vector3(1552.2, 2191.2, 78.85),     
	['org32'] = vector3(-1190.45, -1326.53, 5.29),         
}

Config.List = {
	[1] = 'SNS', -- Nazwa Borni (Label - Wyświetlana nazwa) 60k
	[2] = 'snspistol', -- Nazwa Borni (Spawn - Spawn borni) 60k
	[3] = 'SNS MK2', -- Nazwa Borni (Label - Wyświetlana nazwa) 80k
	[4] = 'snspistol_mk2', -- Nazwa Borni (Spawn - Spawn borni) 80k
	[5] = 'Pistolet', -- Nazwa Borni (Label - Wyświetlana nazwa) 90k
	[6] = 'pistol', -- Nazwa Borni (Spawn - Spawn borni) 90k
	[7] = 'Pistolet MK2', -- Nazwa Borni (Label - Wyświetlana nazwa) 100k
	[8] = 'pistol_mk2', -- Nazwa Borni (Spawn - Spawn borni) 100k
	[9] = 'Vintage', -- Nazwa Borni (Label - Wyświetlana nazwa) 120k
	[10] = 'vintagepistol', -- Nazwa Borni (Spawn - Spawn borni) 120k
	[11] = 'machete', -- Nazwa Borni (Spawn - Spawn borni) 15k
	[12] = 'Toporek', -- Nazwa Borni (Spawn - Spawn borni) 15k
	[13] = 'battleaxe', -- Nazwa Borni (Spawn - Spawn borni) 15k
	[14] = 'Kij bejsbolowy', -- Nazwa Borni (Spawn - Spawn borni) 10k
	[15] = 'bat', -- Nazwa Borni (Spawn - Spawn borni) 10k
	[16] = 'Nóż', -- Nazwa Borni (Spawn - Spawn borni) 20k
	[17] = 'knife', -- Nazwa Borni (Spawn - Spawn borni) 20k
}   

Config.Organisations = {
    ['org1'] = {
		Label = 'Secra Corona Unita',
		Cloakroom = {
			coords = vector3(-1534.66, 131.25, 57.37),
		},
		Inventory = {
			coords = vector3(-1517.61, 125.91, 48.65),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-1545.89, 137.45, 55.65),
			from = 4 -- grade od ktorego to ma
		},
 	},
	 ['org2'] = {
		Label = 'Creeper',
		Cloakroom = {
			coords = vector3(732.82, -795.88, 18.07),
		},
		Inventory = {
			coords = vector3(724.36, -791.24, 16.47),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(739.78, -814.46, 24.27),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(727.38, -791.03, 15.47+0.95),
			from = 0,
			Utils = {
				Label = Config.List[3],
				Weapon = Config.List[4],
				Account = 'black_money',
				Price = 80000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org3'] = {
		Label = 'CiS',
		Cloakroom = {
			coords = vector3(-1042.5, 300.6, 66.99),
		},
		Inventory = {
			coords = vector3(-1047.95, 298.22, 62.22),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-1045.39, 299.56, 66.99),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-1051.52, 308.29, 61.22+0.95),
			from = 0,
			Utils = {
				Label = Config.List[3],
				Weapon = Config.List[4],
				Account = 'black_money',
				Price = 80000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org4'] = {
		Label = 'AS',
		Cloakroom = {
			coords = vector3(1403.04, 1154.34, 117.5),
		},
		Inventory = {
			coords = vector3(1394.36, 1138.78, 109.75),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(1393.3, 1159.63, 114.34),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(1400.88, 1130.24, 108.75+0.95),
			from = 0,
			Utils = {
				Label = Config.List[9],
				Weapon = Config.List[10],
				Account = 'black_money',
				Price = 100000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org5'] = {
		Label = 'DKP',
		Cloakroom = {
			coords = vector3(-2674.67, 1304.17, 152.01),
		},
		Inventory = {
			coords = vector3(-2677.95, 1327.29, 140.88),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-2679.14, 1338.5, 152.01),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-2679.56, 1334.58, 139.88+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 100000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org6'] = {
		Label = 'JEFT',
		Cloakroom = {
			coords = vector3(977.43, 2071.14, 36.67),
		},
		Inventory = {
			coords = vector3(979.99, 2065.53, 36.67),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(939.02, 2073.58, 36.66),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(977.04, 2066.55, 35.68+0.95),
			from = 0,
			Utils = {
				Label = Config.List[3],
				Weapon = Config.List[4],
				Account = 'black_money',
				Price = 80000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org7'] = {
		Label = '666',
		Cloakroom = {
			coords = vector3(-1887.15, 2070.48, 145.57),
		},
		Inventory = {
			coords = vector3(-1869.84, 2059.46, 135.43),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-1876.02, 2060.75, 145.57),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-1856.94, 2055.48, 134.46+0.95),
			from = 0,
			Utils = {
				Label = Config.List[3],
				Weapon = Config.List[4],
				Account = 'black_money',
				Price = 90000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org8'] = {
		Label = 'OIOM',
		Cloakroom = {
			coords = vector3(-811.98, 175.18, 76.75),
		},
		Inventory = {
			coords = vector3(-799.79, 177.6, 72.83),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-804.87, 169.15, 72.84),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-797.01, 186.01, 71.6+0.95),
			from = 0,
			Utils = {
				Label = Config.List[9],
				Weapon = Config.List[10],
				Account = 'black_money',
				Price = 120000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org9'] = {
		Label = 'Klauny',
		Cloakroom = {
			coords = vector3(392.69, -11.11, 85.67+0.95),
		},
		Inventory = {
			coords = vector3(394.57, -6.68, 83.92+0.95),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(390.36, -10.19, 85.68+0.95),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-1525.49, 139.31, 48.41+0.95),
			from = 0,
			Utils = {
				Label = Config.List[3],
				Weapon = Config.List[4],
				Account = 'black_money',
				Price = 99999999,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org10'] = {
		Label = 'The Red Family',
		Cloakroom = {
			coords = vector3(464.05, 6525.93, 13.74),
		},
		Inventory = {
			coords = vector3(460.44, 6530.57, 13.74),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(500.43, 6538.34, 13.73),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(463.28, 6530.66, 12.74+0.95),
			from = 0,
			Utils = {
				Label = Config.List[9],
				Weapon = Config.List[10],
				Account = 'black_money',
				Price = 120000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org11'] = {
		Label = 'THC',
		Cloakroom = {
			coords = vector3(-1109.96, 4949.28, 218.45),
		},
		Inventory = {
			coords = vector3(-1102.01, 4945.82, 218.45),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-1112.51, 4941.34, 218.45),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-1111.75, 4944.56, 217.45+0.95), 
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 100000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org12'] = {
		Label = 'BCV',
		Cloakroom = {
			coords = vector3(-1793.97, 438.22, 128.29),
		},
		Inventory = {
			coords = vector3(-1835.81, 439.49, 118.37),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-1796.8, 449.99, 128.29),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-1819.77, 429.69 , 126.92+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 999999999,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org13'] = {
		Label = 'BAGNO',
		Cloakroom = {
			coords = vector3(-1563.43, 17.23, 64.62),
		},
		Inventory = {
			coords = vector3(-1562.96, 20.58, 64.62),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-1577.82, 15.58, 64.62),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-1586.68, 23.49, 60.21+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 100000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org14'] = {
		Label = 'LFC',
		Cloakroom = {
			coords = vector3(-649.31, 860.2, 229.25),
		},
		Inventory = {
			coords = vector3(-644.95, 857.38, 220.42),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-645.66, 861.39, 229.25),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-654.05, 886.49, 228.25+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 100000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org15'] = {
		Label = 'DEVIL',
		Cloakroom = {
			coords = vector3(-95.63, 993.46, 235.76),
		},
		Inventory = {
			coords = vector3(-65.7, 998.14, 229.0),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-86.81, 996.03, 234.4),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-67.9, 992.96, 229.0),
			from = 0,
			Utils = {
				Label = Config.List[3],
				Weapon = Config.List[4],
				Account = 'black_money',
				Price = 80000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org16'] = {
		Label = 'LRF',
		Cloakroom = {
			coords = vector3(-594.41, -1618.95, 33.01),
		},
		Inventory = {
			coords = vector3(-567.91, -1625.38, 33.01),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-623.78, -1629.23, 33.01),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-606.03, -1630.84, 32.01+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 99999999,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org17'] = {
		Label = 'TDO',
		Cloakroom = {
			coords = vector3(966.05, -1832.27, 36.11),
		},
		Inventory = {
			coords = vector3(965.7, -1837.35, 31.28),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(968.53, -1832.21, 31.28),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(978.42, -1833.24, 35.11+0.95), 
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 100000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org18'] = {
		Label = 'MOVE',
		Cloakroom = {
			coords = vector3(922.66, -3198.59, -17.31),
		},
		Inventory = {
			coords = vector3(924.73, -3199.54, -17.31),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(929.4, -3174.26, -17.32),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(919.7, -3192.31, -16.31+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[7],
				Account = 'black_money',
				Price = 100000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org19'] = {
		Label = 'TFM',
		Cloakroom = {
			coords = vector3(807.91, -2310.24, 29.46),
		},
		Inventory = {
			coords = vector3(812.23, -2312.13, 30.46),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(811.28, -2322.27, 30.46),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(815.72, -2315.21, 29.71+0.95),
			from = 0,
			Utils = {
				Label = Config.List[5],
				Weapon = Config.List[6],
				Account = 'black_money',
				Price = 90000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org20'] = {
		Label = 'SD',
		Cloakroom = {
			coords = vector3(-15.0, 517.05, 170.62),
		},
		Inventory = {
			coords = vector3(-10.67, 519.02, 170.62),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-4.13, 523.46, 170.62),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-6.93, 514.73, 169.62+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 100000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org21'] = {
		Label = 'FDS',
		Cloakroom = {
			coords = vector3(-1182.04, 297.54, 73.65),
		},
		Inventory = {
			coords = vector3(-1205.35, 296.07, 69.72),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-1175.4, 302.29, 73.66),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-1201.27, 298.21, 69.72+0.95), 
			from = 0,
			Utils = {
				Label = Config.List[3],
				Weapon = Config.List[4],
				Account = 'black_money',
				Price = 80000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org22'] = {
		Label = '750',
		Cloakroom = {
			coords = vector3(-66.81, 827.38, 231.33),
		},
		Inventory = {
			coords = vector3(-59.68, 833.88, 231.33),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-99.25, 834.64, 227.79),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-101.17, 823.28, 226.88+0.95),
			from = 0,
			Utils = {
				Label = Config.List[9],
				Weapon = Config.List[10],
				Account = 'black_money',
				Price = 120000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org23'] = {
		Label = 'Marsjanki',
		Cloakroom = {
			coords = vector3(932.47, -1462.09, 33.61),
		},
		Inventory = {
			coords = vector3(942.9, -1473.32, 30.1),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(946.52, -1463.36, 33.61),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(947.35, -1462.16, 29.4+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 9999999,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org24'] = {
		Label = 'Kilo Tray Ballas',
		Cloakroom = {
			coords = vector3(118.15, -2008.07, 18.3),
		},
		Inventory = {
			coords = vector3(113.66, -2010.73, 18.3),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(114.28, -2003.73, 18.3),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(120.34, -2004.31, 11.6+0.95),
			from = 0,
			Utils = {
				Label = Config.List[5],
				Weapon = Config.List[6],
				Account = 'black_money',
				Price = 90000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org25'] = {
		Label = 'VAGOS',
		Cloakroom = {
			coords = vector3(359.8, -2037.84, 25.59),
		},
		Inventory = {
			coords = vector3(332.53, -2013.85, 22.39),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(360.1, -2039.17, 25.59),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(329.93, -2014.25, 21.39+0.95),
			from = 0,
			Utils = {
				Label = Config.List[5],
				Weapon = Config.List[6],
				Account = 'black_money',
				Price = 90000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org26'] = {
		Label = 'CRIPS',
		Cloakroom = {
			coords = vector3(-1089.07, -1667.17, 8.41),
		},
		Inventory = {
			coords = vector3(-1092.96, -1663.11, 8.41),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(-1092.81, -1668.95, 8.42),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(-1106.56, -1672.24, 7.41+0.95),
			from = 0,
			Utils = {
				Label = Config.List[5],
				Weapon = Config.List[6],
				Account = 'black_money',
				Price = 90000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org27'] = {
		Label = 'Bloods',
		Cloakroom = {
			coords = vector3(1157.23, -437.29, 62.23),
		},
		Inventory = {
			coords = vector3(1141.09, -438.62, 62.22),
			from = 4, -- grade od ktorego to ma
		},
		BossMenu = {
			coords = vector3(1141.93, -440.04, 62.22),
			from = 4 -- grade od ktorego to ma
		},
		Contract = {
			coords = vector3(1149.39, -428.55, 61.23+0.95),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 999999,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	['org28'] = {
		Label = 'IllegalCustomers',
		Cloakroom = {
            coords = vector3(25.8, 6477.54, 31.88),
		},
        Inventory = {
            coords = vector3(36.3, 6471.99, 30.88),
            from = 4, -- grade od ktorego to ma
        },
        BossMenu = {
            coords = vector3(37.29, 6463.68, 31.08),
            from = 4 -- grade od ktorego to ma
        },
        Contract = {
            coords = vector3(29.86, 6480.75 , 30.88+0.95),
			from = 0,
			Utils = {
				Label = Config.List[5],
				Weapon = Config.List[6],
				Account = 'black_money',
				Price = 90000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org29'] = {
		Label = 'Yamaguchi',
		Cloakroom = {
            coords = vector3(1566.78, -2113.73, 73.08),
		},	
        Inventory = {
            coords = vector3(1561.63, -2110.41, 78.32),
            from = 4, -- grade od ktorego to ma
        },
        BossMenu = {
            coords = vector3(1565.55, -2113.77, 78.32),
            from = 4, -- grade od ktorego to ma
        },
        Contract = {
            coords = vector3(1564.05, -2106.15, 73.08),
			from = 0,
			Utils = {
				Label = Config.List[5],
				Weapon = Config.List[6],
				Account = 'black_money',
				Price = 90000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	 ['org30'] = {
		Label = 'Ghost Zehtas',
		Cloakroom = {
            coords = vector3(875.61, -2210.23, 30.64),
		},	
        Inventory = {
            coords = vector3(879.83, -2210.59, 30.64),
            from = 4, -- grade od ktorego to ma
        },
        BossMenu = {
            coords = vector3(863.52, -2210.39, 30.64),
            from = 4 -- grade od ktorego to ma
        },
        Contract = {
            coords = vector3(881.06, -2202.94, 30.64),
			from = 0,
			Utils = {
				Label = Config.List[5],
				Weapon = Config.List[6],
				Account = 'black_money',
				Price = 99999999,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	['org31'] = {
		Label = 'GJO',
		Cloakroom = {
            coords = vector3(1548.57, 2171.95, 78.99),
		},	
        Inventory = {
            coords = vector3(1549.0, 2162.97, 78.99),
            from = 4, -- grade od ktorego to ma
        },
        BossMenu = {
            coords = vector3(1535.61, 2221.69, 77.26),
            from = 4, -- grade od ktorego to ma
        },
        Contract = {
            coords = vector3(1548.63, 2160.88, 78.99),
			from = 0,
			Utils = {
				Label = Config.List[5],
				Weapon = Config.List[6],
				Account = 'black_money',
				Price = 99999999,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	},
	['org32'] = {
		Label = 'NGR',
		Cloakroom = {
            coords = vector3(-1214.09, -1303.42, -4.92),
		},	
        Inventory = {
            coords = vector3(-1203.29, -1306.77, -4.92),
            from = 4 -- grade od ktorego to ma
        },
        BossMenu = {
            coords = vector3(-1226.03, -1305.03, -4.92),
            from = 4 -- grade od ktorego to ma
        },
        Contract = {
            coords = vector3(-1205.08, -1308.95, -4.92),
			from = 0,
			Utils = {
				Label = Config.List[7],
				Weapon = Config.List[8],
				Account = 'black_money',
				Price = 120000,
				Ammo = {
					Account = 'black_money',
					Price = 200, -- za ammo ilość niżej podana
					Number = 1, -- ile ma dodawać amunicji za powyższą cenę
				},
			},
		}
 	}
}

Config.Interactions = {
    ['org1'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org2'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org3'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org4'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org5'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org6'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org7'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org8'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org9'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org1'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org10'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org11'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org12'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org1'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org13'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org14'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org15'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org16'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org17'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org18'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org19'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org20'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org21'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org22'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org23'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org24'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org25'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org26'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org27'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org28'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org29'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org30'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org31'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
	['org32'] = {
		handcuffs = 0, 
		repair = 0,
		worek = 0
	},
}