module([SYN load/save])

define([__synload],)
define([__synsave_settings],)
define([SynFileDecimal],[
	MacroBack([__synload], [[if (strcmp(command, "$1") == 0) { color_t t; fscanf(synfile, "%d", &t); ]SetVar($2, t) }])
	MacroBack([__synsave_settings], [[fprintf(synfile, "$1 %d\n", $2);]])
])
define([SynFileHex],[
	MacroBack([__synload], [[if (strcmp(command, "$1") == 0) { color_t t; fscanf(synfile, "%x", &t); ]SetVar($2, t) }])
	MacroBack([__synsave_settings], [[fprintf(synfile, "$1 %08X\n", $2);]])
])

code7([block([Load routine for SYN files.])[
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

]block([Save routine for SYN files.])[
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
		fclose(synfile);
	} else {
		result = false;
	}

	return result;
}
]])
