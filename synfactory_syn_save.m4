module([SYN save])

code7([
static bool syn_save(const char *filename) {
	FILE *synfile = fopen(filename, "wt");
	bool result = true;
	
	if (synfile) {
		fprintf(synfile, "FILETYPE SYN\nPROGRAM ]PROGRAM[\n");
		fclose(synfile);
	} else {
		result = false;
	}

	return result;
}
])