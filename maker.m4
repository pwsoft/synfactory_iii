# ########################################################################
#
# Maker.m4
#
# M4 macros for aspect oriented programming and code weaving
# Based on earlier experiments with Perl scripts for StudioFactory.
# Copyright (C) 2002-2010  Peter Wendrich (pwsoft@syntiac.com)
# Homepage: http://www.syntiac.com
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

#
# Change quote characters to something more sane.
#
changequote(`[', `]')

#
# Initialise empty lists. Prevents syntax errors during compilation when certain macros are never filled.
#
define([__sysincludes],)
define([__locincludes],)
define([__defs],)
define([__enums],)
define([__typedefs],)
define([__structs],)
define([__callbacks],)
define([__consts],)
define([__code1],)
define([__code2],)
define([__code3],)
define([__code4],)
define([__code5],)
define([__code6],)
define([__code7],)
define([__code8],)
define([__code9],)

#
# Platform include, first include general include followed by platform specific files.
#
define([platforminclude],
	[sinclude($1.m4)]
	[sinclude($1_[]PLATFORM_OS[].m4)]
	[sinclude($1_[]PLATFORM_GUI[].m4)]
)

#
# Indent a block of code. First parameter is amount of indent (in nr of tabs), second parameter is block of code.
# Can be used to layout code that is generated by various macros, so the end result is aligned and properly indented.
#
define([indent],[patsubst([[$2]],[^],substr([										],0,$1))])

#
# Macros to collect strings. MacroFront places new string at the beginning
# MacroBack adds new string at the end of the existing strings.
# All strings are separated by a newline
#
define([MacroFront], [define([$1],[]
[$2]defn([$1]))])
define([MacroBack], [define([$1],defn([$1])
[$2])])
define([MacroBackCont], [define([$1],defn([$1])[$2])])

#
# Support for the 'Enum' macro
#
#
define([CreateEnum],[
	MacroBack([__enums],[__enum_$1])
	define([__enum_$1],[[typedef enum _$1 {]indent(1,__enum_$1_values)
[} $1_t;]])
	code1([block([Convert an enum $1_t value to a string.])
[static const char *convert$1ToString($1_t aEnumValue) {
	switch(aEnumValue) {]indent(1,__enum_$1_convert)
	default: break;
	}
	return "???";
}])
])
#
# Support for the 'Struct' macro
#
#
define([CreateStruct], [
	MacroFront([__structs],[__struct_$1])
	define([__struct_$1],[[typedef struct _$1 {]indent(1,__struct_$1_values)
[} $1_t, *$1_ptr_t;]])])

define([block],
[/*********************************************************************\
* $1
\*********************************************************************/])
define([sysinclude], [ifdef([__sysincludes_$1],,[define([__sysincludes_$1],)MacroBack([__sysincludes],[[#include <$1>]])])])
define([locinclude], [ifdef([__locincludes_$1],,[define([__sysincludes_$1],)MacroBack([__sysincludes],[[#include "$1"]])])])
define([Init], [MacroBack([__init],[[$1]])])
define([Term], [MacroFront([__term],[[$1]])])
define([Enum],
	[ifdef([__enum_$1],
		[MacroBackCont]([[__enum_$1_values]],[[[,]]]),
		[CreateEnum([$1])])]
	[MacroBack]([[__enum_$1_values]],[[[$2]]])
	[MacroBack]([[__enum_$1_convert]],[[[case $2: return "$2";]]]))
define([Struct], [ifdef([__struct_$1],,[CreateStruct([$1])])MacroBack([__struct_$1_values],[[$2]])])
define([Def], [MacroBack([__defs],[[$1]])])
define([Typedef], [MacroBack([__typedefs],[[$1]])])
define([DefCallback], [MacroBack([__callbacks],[[$1]])])
define([DefConst], [MacroBack([__consts],[[$1]])])
define([DefVar], [MacroBack([__vars],[[$1]])])
define([DefSetVar], [
	define([__set_$2],)
	MacroBack([__vars],[[static $1 $2 = $3;]])
	code1([block([Set function for $2])[
static void __set_$2($1 aNewValue) {
	if (aNewValue != $2) {
		$2 = aNewValue;
]indent(2,__set_$2)[
	}
}
]])])
define([WatchVar], [MacroBack([__set_$1], [[$2]])])
define([SetVar], [[__set_$1($2);]])

#
# Code block macros. Depending on required order take one of the blocks.
# Library and support routines must use low numbers, toplevel functions use higher number.
# This ordering requires less forward declarations for the functions.
#
define([code1], [MacroBack([__code1],
[$1])])
define([code2], [MacroBack([__code2],
[$1])])
define([code3], [MacroBack([__code3],
[$1])])
define([code4], [MacroBack([__code4],
[$1])])
define([code5], [MacroBack([__code5],
[$1])])
define([code6], [MacroBack([__code6],
[$1])])
define([code7], [MacroBack([__code7],
[$1])])
define([code8], [MacroBack([__code8],
[$1])])
define([code9], [MacroBack([__code9],
[$1])])
define([module],[MacroBack([__modules],*	[[$1]]substr([]                              ,len([$1]))"__file__")])
