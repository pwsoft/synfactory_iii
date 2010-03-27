include(maker.m4)
define(PROGRAM,[SynFactory III])
define(VERSION,[20100327])

sysinclude([stdlib.h])
sysinclude([stdio.h])
sysinclude([string.h])

init([init_files();])
term([term_files();])

init([init_gui();])
term([term_gui();])
enum([GuiEvent], [GUIEVENT_RIGHT_CLICK])
enum([GuiEvent], [GUIEVENT_LEFT_CLICK])
enum([GuiEvent], [GUIEVENT_REDRAW])

----------------------------------------------
dumpdef([__enum_GuiEvent])
dumpdef([__sysincludes])
dumpdef([init])
dumpdef([__init])
dumpdef([__enums])
__windows__
__unix__

----------------------------------------------
block([Includes])
__sysincludes

block([Enums])
__enums[]dnl

block([Constants])
static const char theProgramName[]="PROGRAM - VERSION";

block([Main])
[int main(int argc, char **argv) {]
__init[]
[    eventloop();]
__term[]
[    return 0;
}]

