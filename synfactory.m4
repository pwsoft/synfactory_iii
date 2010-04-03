include(maker.m4)
divert(-1)
define(EXENAME,[synfactory_iii])
define(PROGRAM,[SynFactory III])
define(VERSION,[20100327])

const([static const char theProgramName[]="]PROGRAM - VERSION[";])
include([synfactory_logfile.m4])
include([synfactory_perlin.m4])
divert[]dnl

/* -------------------------------------------------------------------- */
block([Includes])dnl
__sysincludes[]dnl

block([Enums])dnl
__enums[]dnl

block([Structs])dnl
__structs[]dnl

block([Constants])dnl
__const[]dnl

block([Code])
__code1[]dnl
__code2[]dnl
__code3[]dnl
__code4[]dnl

linefile[]block([Main])
[int main(int argc, char **argv) {]
__init[]
/* [    eventloop();] */
__term[]
[    return 0;
}]

