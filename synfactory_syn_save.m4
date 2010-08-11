module([SYN save])

define([__synsave_settings],)
define([SynSave], [MacroBack([__synsave_settings], [[fprintf(synfile, $1);]])])

code7([[
static bool syn_save(const char *aFilename) {
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