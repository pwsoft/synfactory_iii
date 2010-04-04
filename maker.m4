changequote(`[', `]')
#
# Initialise empty lists. Prevents syntax error during compile if block is never filled.
#
define([__defs],)
define([__enums],)
define([__structs],)
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
# Platform include, first include general include followed by platform specific file.
#
define([platforminclude],
	[sinclude($1.m4)]
	[sinclude($1_[]PLATFORM[].m4)]
)

#
# Macros to collect strings. MacroFront places new string at the beginning
# MacroBack adds new string at the end of the existing strings.
# All strings are separated by a newline
#
define([MacroFront], [define([$1],[$2]
defn([$1]))])
define([MacroBack], [define([$1],defn([$1])
[$2])])
define([MacroBackCont], [define([$1],defn([$1])[$2])])

define([CreateEnum], [MacroBack([__enums],[__enum_$1])define([__enum_$1],[[typedef enum _$1 {]__enum_$1_values
[} $1;]])])
define([CreateStruct], [MacroFront([__structs],[__struct_$1])define([__struct_$1],[[typedef struct _$1 {]__struct_$1_values
[} $1;]])])

define([block],
[/*********************************************************************\
* $1
\*********************************************************************/])
define([sysinclude], [ifdef([__sysincludes_$1],,[define([__sysincludes_$1],)MacroBack([__sysincludes],[[#include <$1>]])])])
define([init], [MacroBack]([[__init]],[[[    $1]]]))
define([term], [MacroFront]([[__term]],[[[    $1]]]))
define([enum], [ifdef([__enum_$1],[MacroBackCont]([[__enum_$1_values]],[[,]]),[CreateEnum([$1])])][MacroBack]([[__enum_$1_values]],[[    $2]]))
define([struct], [ifdef([__struct_$1],,[CreateStruct([$1])])][MacroBack]([[__struct_$1_values]],[[    $2]]))
define([def], [MacroBack]([[__defs]],[[[$1]]]))
define([const], [MacroBack]([[__const]],[[[$1]]]))
define([var], [MacroBack]([[__vars]],[[[$1]]]))
#
# Code block macros. Depending on required order take one of the blocks.
# Library and support routines must use low numbers, toplevel functions use higher number.
# This ordering required less forward declarations for the functions.
#
define([linefile],[[#]line __line__ "__file__"])
define([code1], [MacroBack]([[__code1]],[linefile]
[[$1]]))
define([code2], [MacroBack]([[__code2]],[linefile]
[[$1]]))
define([code3], [MacroBack]([[__code3]],[linefile]
[[$1]]))
define([code4], [MacroBack]([[__code4]],[linefile]
[[$1]]))
define([code5], [MacroBack]([[__code5]],[linefile]
[[$1]]))
define([code6], [MacroBack]([[__code6]],[linefile]
[[$1]]))
define([code7], [MacroBack]([[__code7]],[linefile]
[[$1]]))
define([code8], [MacroBack]([[__code8]],[linefile]
[[$1]]))
define([code9], [MacroBack]([[__code9]],[linefile]
[[$1]]))
define([module],[MacroBack([__modules],*	[[$1]]substr([]                              ,len([$1]))"__file__")])
