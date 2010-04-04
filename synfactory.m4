divert(-1)
include(maker.m4)
define(PLATFORM,[win32])
define(EXENAME,[synfactory_iii])
define(PROGRAM,[SynFactory III])
define(VERSION,[20100327])

const([static const char theProgramName[]="]PROGRAM - VERSION[";])
platforminclude([synfactory_logfile])
platforminclude([synfactory_threads])
platforminclude([synfactory_gui])
platforminclude([synfactory_audio])
platforminclude([synfactory_midi])
platforminclude([synfactory_objects])
platforminclude([synfactory_perlin])
platforminclude([synfactory_dsp])
platforminclude([synfactory_transport])
platforminclude([synfactory_main])
divert[]dnl
block([[
* SynFactory III
*
* Copyright (C) 2002-2010  Peter Wendrich (pwsoft@syntiac.com)
* Homepage: http://www.syntiac.com/synfactory_iii.html
*
***********************************************************************
*
* Generated from the following modules:
*]__modules])

block([System includes])dnl
__sysincludes[]dnl

block([Defines])dnl
__defs[]dnl

block([Enums])dnl
__enums[]dnl

block([Structs])dnl
__structs[]dnl

block([Constants])dnl
__const[]dnl

block([Variables])dnl
__vars[]dnl

block([Code])
__code1[]dnl
__code2[]dnl
__code3[]dnl
__code4[]dnl
__code5[]dnl
__code6[]dnl
__code7[]dnl
__code8[]dnl
__code9[]dnl

