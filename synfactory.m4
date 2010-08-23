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
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ########################################################################
include(maker.m4)
define(PLATFORM_OS,[[win32]])
define(PLATFORM_GUI,[[gdi]])
define(EXENAME,[synfactory_iii])
define(PROGRAM,[SynFactory III])
define(VERSION,[20100812])

Def([#define UNUSED(x) ((void)(0 && (x)))])
DefConst([static const char theProgramName[]="]PROGRAM - VERSION[";])
platforminclude([synfactory_logfile])
platforminclude([synfactory_language])
platforminclude([synfactory_threads])
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
platforminclude([synfactory_file_syn])
platforminclude([synfactory_projects])
platforminclude([synfactory_colorselector])
platforminclude([synfactory_patcheditor])
platforminclude([synfactory_audioscope])
platforminclude([synfactory_transport])
platforminclude([synfactory_virtual_keyboard])
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

