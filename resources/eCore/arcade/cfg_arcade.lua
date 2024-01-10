cfg_arcade = {}

cfg_arcade.alcooloui = {
    {
        label = "Whisky Coca",
        price = 15,
        item  = "whiskycoca",
    },
    {
        label = "Vodka Fruit",
        price = 15,
        item  = "vodkafruit",
	},
    {
        label = "Vin",
        price = 15,
        item  = "vine",
	},
    {
        label = "Tequila",
        price = 15,
        item  = "tequila",
	},
    {
        label = "Rhum",
        price = 15,
        item  = "rhum",
	},
    {
        label = "Martini",
        price = 15,
        item  = "martini",
	},
    {
        label = "Champagne",
        price = 15,
        item  = "Champagne",
	},
    {
        label = "Heineken",
        price = 15,
        item  = "Heineken",
	},
    {
        label = "Mojito",
        price = 15,
        item  = "mojito",
	},
    {
        label = "Jägerbomb",
        price = 15,
        item  = "jagerbomb",
	},
}

cfg_arcade.alcoolnon = {
    {
        label = "Sprunk",
        price = 15,
        item  = "Sprunk",
    },
    {
        label = "Sprite",
        price = 15,
        item  = "sprite",
	},
    {
        label = "Redbull",
        price = 15,
        item  = "redbull",
    },
    {
        label = "Limonade",
        price = 15,
        item  = "limonade",
	},
    {
        label = "Icetea",
        price = 15,
        item  = "icetea",
    },
    {
        label = "Fanta",
        price = 15,
        item  = "fanta",
	},
    {
        label = "Dr Pepper",
        price = 15,
        item  = "drpepper",
    },
    {
        label = "Coca-cola",
        price = 15,
        item  = "cocacola",
	},
    {
        label = "Jus de raisin",
        price = 15,
        item  = "jus_raisin",
	},
    {
        label = "Jus d'orange",
        price = 15,
        item  = "Jus_orange",
	},
    {
        label = "Jus de fruit",
        price = 15,
        item  = "jusfruit",
	},
}

cfg_arcade.snacks = {
    {
        label = "Chips",
        price = 15,
        item  = "Chips",
    },
    {
        label = "Donut",
        price = 15,
        item  = "Donut",
    },
    {
        label = "Cacahuètes",
        price = 15,
        item  = "cacahuète",
    },
    {
        label = "Bretzels",
        price = 15,
        item  = "bretzels",
    },
    {
        label = "Barre chocolatée",
        price = 15,
        item  = "barrechocolat",
    },
    {
        label = "Cookie",
        price = 15,
        item  = "cookie",
    },
    {
        label = "Pop-corn",
        price = 15,
        item  = "popcorn",
    },
    {
        label = "Saucisson",
        price = 15,
        item  = "saucisson",
    },
}

cfg_arcade.max = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
	"11",
	"12",
	"13",
	"14",
	"15",
	"16",
	"17",
	"18",
	"19",
	"20",
	"21",
	"22",
	"23",
	"24",
	"25",
}

cfg_arcade.TimeSeconde = 1
cfg_arcade.TimeMinutes = 30



cfg_arcade.GPUList = {
    [1] = "ETX2080",
    [2] = "ETX1050",
    [3] = "ETX660",
}

cfg_arcade.CPUList = {
    [1] = "U9_9900",
    [2] = "U7_8700",
    [3] = "U3_6300",
    [4] = "BENTIUM",
}

cfg_arcade.RetroMachine = {
    {
        name = "Pacman",
        link = "http://xogos.robinko.eu/PACMAN/",
    },
    {
        name = "Tetris",
        link = "http://xogos.robinko.eu/TETRIS/",
    },
    {
        name = "Ping Pong",
        link = "http://xogos.robinko.eu/PONG/",
    },
    {
        name = "DOOM",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Doom.zip", "./DOOM.EXE"),
    },
    {
        name = "Duke Nukem 3D",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
    },
    {
        name = "Wolfenstein 3D",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Wolfenstein3D.zip", "./WOLF3D.EXE"),
    },

    {
        name = "Slide a Lama",
        link = "http://lama.robinko.eu/fullscreen.html",
    },
    {
        name = "Uno",
        link = "https://duowfriends.eu/",
    },
    {
        name = "Ants",
        link = "http://ants.robinko.eu/fullscreen.html",
    },
    {
        name = "FlappyParrot",
        link = "http://xogos.robinko.eu/FlappyParrot/",
    },
    {
        name = "Zoopaloola",
        link = "http://zoopaloola.robinko.eu/Embed/fullscreen.html"
    }
}