divert(-1)
changequote(`[', `]')

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

define([block], [
/****************************************
* $1
****************************************/])
define([sysinclude], [MacroBack]([[__sysincludes]],[[[#include <$1>]]]))
define([init], [MacroBack]([[__init]],[[[    $1]]]))
define([term], [MacroFront]([[__term]],[[[    $1]]]))
define([enum], [ifdef([__enum_$1],[MacroBackCont]([[__enum_$1_values]],[[,]]),[CreateEnum([$1])])][MacroBack]([[__enum_$1_values]],[[    $2]]))
divert[]dnl
