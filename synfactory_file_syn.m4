module([SYN load/save])

define([__synload],)
define([__synsave_settings],)
define([__synsave_windows],)

define([SynFileDecimal],[
	MacroBack([__synload], [[if (strcmp(command, "$1") == 0) { color_t t; fscanf(synfile, "%d", &t); ]SetVar($2, t) }])
	MacroBack([__synsave_settings], [[fprintf(synfile, "$1 %d\n", $2);]])
])
define([SynFileHex],[
	MacroBack([__synload], [[if (strcmp(command, "$1") == 0) { color_t t; fscanf(synfile, "%x", &t); ]SetVar($2, t) }])
	MacroBack([__synsave_settings], [[fprintf(synfile, "$1 %08X\n", $2);]])
])
define([SynFileWindow],[
	MacroBack([__synload], [[if (strcmp(command, "$1") == 0) { SynFileLoadWindowPosition(synfile, $2); }]])
	MacroBack([__synsave_windows], [[SynFileSaveWindowPosition(synfile, "$1", $2);]])
])

code7([block([Load routine for SYN files.])[
static void SynFileLoadWindowPosition(FILE *file, GuiWindow_t window) {
	int s,x,y,w,h;
	if (fscanf(file, "%d %d %d %d %d ", &s, &x, &y, &w, &h) == 5) {
		guiSetWindowPosition(window, x, y, w, h);
		switch(s) {
		case 1:
			guiShowWindow(window);
			break;
		case 2:
			guiShowWindow(window);
			guiMaximizeWindow(window);
			break;
		default:
			guiHideWindow(window);
			break;
		}
	} else {
		logprintf("Error reading window position\n");
	}
}

static bool SynFileLoad(const char *aFilename) {
	FILE *synfile = fopen(aFilename, "rt");
	bool result = true;

	if (synfile) {
		logprintf("%s open for reading\n", aFilename);
		while(!feof(synfile)) {
			char command[128];
			int command_read = fscanf(synfile, "%127s ", command);
			logprintf("fscanf result %d\n", command_read);
			if (command_read == 1) {
				logprintf("fscanf command '%s'\n", command);
			}
]indent(3,__synload)[
		}
		fclose(synfile);
	} else {
		result = false;
	}

	return result;
}

]block([Save routines for SYN files.])[
static void SynFileSaveWindowPosition(FILE *file, const char *saveName, GuiWindow_t window) {
	int show=0;
	int x,y,w,h;

	guiGetWindowPosition(window, &x, &y, &w, &h);
	if (guiIsWindowVisible(window)) {
		if (guiIsWindowMaximized(window)) {
			show=2;
		} else {
			show=1;
		}
	}
	fprintf(file, "%s %d %d %d %d %d\n", saveName, show, x, y, w, h);
}

static bool SynFileSave(const char *aFilename) {
	FILE *synfile = fopen(aFilename, "wt");
	bool result = true;
	
	if (synfile) {
		/* Write SYN header */
		fprintf(synfile, "FILETYPE SYN\nPROGRAM %s\nVERSION 3.00\n", theProgramName);
		fprintf(synfile, "NAME %s\n", aFilename);
		fprintf(synfile, "{{{SETTINGS\n");
]indent(2,__synsave_settings)[
		fprintf(synfile, "}}}SETTINGS\n");
		fprintf(synfile, "{{{WINDOWS\n");
]indent(2,__synsave_windows)[
		fprintf(synfile, "}}}WINDOWS\n");
		fclose(synfile);
	} else {
		result = false;
	}

	return result;
}
]])
