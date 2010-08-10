divert(-1)
# ########################################################################
#
# SynFactory III
#
# The desktop modular Audio/Video studio.
# Copyright (C) 2002-2010  Peter Wendrich (pwsoft@syntiac.com)
# Homepage: http://www.syntiac.com/synfactory.html
#
# ########################################################################
include(maker.m4)
define(PLATFORM_OS,[win32])
define(PLATFORM_GUI,[gdi])
define(EXENAME,[synfactory_iii])
define(PROGRAM,[SynFactory III])
define(VERSION,[20100327])

Const([static const char theProgramName[]="]PROGRAM - VERSION[";])
platforminclude([synfactory_logfile])
platforminclude([synfactory_language])
platforminclude([synfactory_threads])
platforminclude([synfactory_arealist])
platforminclude([synfactory_gui])
platforminclude([synfactory_menu])
platforminclude([synfactory_main])
platforminclude([synfactory_mainmenu])
platforminclude([synfactory_audio])
platforminclude([synfactory_midi])
platforminclude([synfactory_objects])
platforminclude([synfactory_perlin])
platforminclude([synfactory_dsp])
platforminclude([synfactory_help])
platforminclude([synfactory_preferences])
platforminclude([synfactory_projects])
platforminclude([synfactory_colorselector])
platforminclude([synfactory_patcheditor])
platforminclude([synfactory_audioscope])
platforminclude([synfactory_transport])
divert[]dnl
block([[
* SynFactory III
*
* Copyright (C) 2002-2010  Peter Wendrich (pwsoft@syntiac.com)
* Homepage: http://www.syntiac.com/synfactory.html
*
***********************************************************************
*
* Generated from the following modules:
*]__modules])

block([[System includes]])dnl
__sysincludes[]dnl
__locincludes[]dnl

block([[Defines]])dnl
__defs[]dnl

block([[Enums]])dnl
__enums[]dnl

block([[Typedefs]])dnl
__typedefs[]dnl

block([[Structs]])dnl
__structs[]dnl

block([[Callback definitions]])dnl
__callbacks[]dnl

block([Constants])dnl
__consts[]dnl

block([Variables])dnl
__vars[]dnl

__code1[]dnl
__code2[]dnl
__code3[]dnl
__code4[]dnl
__code5[]dnl
__code6[]dnl
__code7[]dnl
__code8[]dnl
__code9[]dnl

