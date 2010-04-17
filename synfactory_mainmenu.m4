module([main menu])


Enum([Menu], [MENU_NEW])
Enum([Menu], [MENU_OPEN])
Enum([Menu], [MENU_CLOSE])
Enum([Menu], [MENU_SAVE])
Enum([Menu], [MENU_SAVE_AS])
Enum([Menu], [MENU_SAVE_ALL])
Enum([Menu], [MENU_EXIT])

Enum([Menu], [MENU_COPY])
Enum([Menu], [MENU_PASTE])
Enum([Menu], [MENU_CUT])
Enum([Menu], [MENU_DELETE])
Enum([Menu], [MENU_SELECT_ALL])


DefMenu([generateMainMenu],[
	DefSubMenu([&File],[
		DefMenuItem([&New], [MENU_NEW])
		DefMenuItem([&Open], [MENU_OPEN])
		DefMenuItem([&Close], [MENU_CLOSE])
		DefMenuSeparator()
		DefMenuItem([&Save], [MENU_SAVE])
		DefMenuItem([Save &As], [MENU_SAVE_AS])
		DefMenuItem([Save A&ll], [MENU_SAVE_ALL])
		DefMenuSeparator()
		DefMenuItem([E&xit], [MENU_EXIT])
	])
	DefSubMenu([&Edit],[
		DefMenuItem([Copy], [MENU_COPY])
		DefMenuItem([Paste], [MENU_PASTE])
		DefMenuItem([Cut], [MENU_CUT])
		DefMenuSeparator()
		DefMenuItem([Delete], [MENU_DELETE])
		DefMenuSeparator()
		DefMenuItem([Select All], [MENU_SELECT_ALL])
	])
	DefSubMenu([Help],[
	])
])
