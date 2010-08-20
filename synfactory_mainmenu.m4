module([main menu])


Enum([Menu], [MENU_OPEN_FILE])
Enum([Menu], [MENU_ADD_FILE])
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
Enum([Menu], [MENU_CLONE])
Enum([Menu], [MENU_TOGGLE_LABEL])

Enum([Menu], [MENU_PROJECT_BROWSER])
Enum([Menu], [MENU_COLOR_SELECTOR])
Enum([Menu], [MENU_TRANSPORT])
Enum([Menu], [MENU_AUDIO_SCOPE])
Enum([Menu], [MENU_AUDIO_MIXER])
Enum([Menu], [MENU_VIDEO_PREVIEW])
Enum([Menu], [MENU_MIDI_SCOPE])
Enum([Menu], [MENU_MIDI_ACTIVITY])
Enum([Menu], [MENU_MIDI_KEYBOARD])
Enum([Menu], [MENU_MESSAGES])

Enum([Menu], [MENU_REWIND])
Enum([Menu], [MENU_STOP])
Enum([Menu], [MENU_PLAY])
Enum([Menu], [MENU_RECORD])

Enum([Menu], [MENU_PREFERENCES])
Enum([Menu], [MENU_SAVE_SETTINGS_AS])

Enum([Menu], [MENU_ABOUT])




DefMenu([generateMainMenu],[
	DefSubMenu([&File],[
		DefSubMenu([&New...],[
		])
		DefMenuItem([&Open], [MENU_OPEN_FILE])
		DefMenuItem([Add/Merge file], [MENU_ADD_FILE])
		DefMenuItem([&Close], [MENU_CLOSE])
		DefMenuSeparator()
		DefMenuItem([&Save], [MENU_SAVE])
		DefMenuItem([Save &as], [MENU_SAVE_AS])
		DefMenuItem([Save a&ll], [MENU_SAVE_ALL])
		DefMenuSeparator()
		DefMenuItem([E&xit], [MENU_EXIT])
	])
	DefSubMenu([&Edit],[
		DefMenuItem([Cut], [MENU_CUT])
		DefMenuItem([Copy], [MENU_COPY])
		DefMenuItem([Paste], [MENU_PASTE])
		DefMenuSeparator()
		DefMenuItem([Delete], [MENU_DELETE])
		DefMenuSeparator()
		DefMenuItem([Select all], [MENU_SELECT_ALL])
		DefMenuItem([Cl&one], [MENU_CLONE])
		DefMenuItem([Show/Hide &label], [MENU_TOGGLE_LABEL])
		DefSubMenu([&Select cable color],[
		])
	])
	DefSubMenu([&View],[
		DefMenuItem([&Project browser\tF2], [MENU_PROJECT_BROWSER])
		DefMenuItem([&Color selector], [MENU_COLOR_SELECTOR])
		DefMenuSeparator()
		DefMenuItem([&Transport control], [MENU_TRANSPORT])
		DefMenuItem([Audio &output scope], [MENU_AUDIO_SCOPE])
		DefMenuItem([&Audio mixer], [MENU_AUDIO_MIXER])
		DefMenuItem([&Video preview], [MENU_VIDEO_PREVIEW])
		DefMenuSeparator()
		DefMenuItem([Midi &Scope], [MENU_MIDI_SCOPE])
		DefMenuItem([Midi Activit&y Monitor], [MENU_MIDI_ACTIVITY])
		DefMenuItem([Virtual Midi Keyboard], [MENU_MIDI_KEYBOARD])
		DefMenuSeparator()
		DefMenuItem([&Console and message window\tF11], [MENU_MESSAGES])
	])
	DefSubMenu([&Play mode],[
		DefMenuItem([Re&wind], [MENU_REWIND])
		DefMenuItem([&Stop], [MENU_STOP])
		DefMenuItem([Pla&y], [MENU_PLAY])
		DefMenuSeparator()
		DefMenuItem([&Record], [MENU_RECORD])
		DefMenuSeparator()
	])
	DefSubMenu([&Settings],[
		DefMenuItem([&Preferences], [MENU_PREFERENCES])
		DefMenuItem([&Save settings as], [MENU_SAVE_SETTINGS_AS])
	])
	DefSubMenu([&Help],[
		DefMenuItem([&About SynFactory], [MENU_ABOUT])
	])
])
