module('Support logfile')
sysinclude([stdarg.h])
sysinclude([stdio.h])

code1([
//
// Write formatted output to logfile
//
static FILE *theLogfile=NULL;
#ifdef _MSC_VER
static int __cdecl logprintf(const char *formatstr, ...) {
#else
static int logprintf(const char *formatstr, ...) {
#endif
        int retval=0;

        va_list(arglist);
        va_start(arglist, formatstr);
        if (theLogfile) {
                retval=vfprintf(theLogfile, formatstr, arglist);
                fflush(theLogfile);
        }

        va_end(arglist);
        return retval;
}

static void createLogfile(const char *aLogFileName) {
        if (theLogfile) {
                fclose(theLogfile);
                theLogfile=NULL;
        }
        if (aLogFileName) {
                theLogfile=fopen(aLogFileName, "w");
                if (theLogfile) {
                        logprintf("Logfile '%s' created.\n", aLogFileName);
                }
        }
}
])

init([createLogfile("]EXENAME[.log");])
term([logprintf("Closing ]EXENAME[ logfile.\n");])
