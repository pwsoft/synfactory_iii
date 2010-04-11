#
# Object macros
#
define([defobj],[
	Enum([Objects],$1)
	MacroBack([__ObjectTitles],[		case $1: return "[$2]";])
	ifelse([$3],,,[MacroBack([__ObjectKeys],[		case '$3': return [$1];])])
	ifelse([$7],NULL,,[MacroBack([__ObjectMenus],[		case $1: return [$7];])])
])

#
# Object support functions
#
sysinclude([assert.h])
code1([[static const char *object_title(Objects_t aObject) {
	switch(aObject) {]]
__ObjectTitles
		default:
			break;
[[	}
	return "???";
}]])

code1([[static Objects_t key_to_object(int aKey) {
	switch(aKey) {]]
__ObjectKeys
[[	}
	return OBJECT_NONE;
}]])

code1([[static const char *object_to_menu(Objects_t aObject) {
	switch(aObject) {]]
__ObjectMenus
		default:
			break;
[[	}
	return NULL;
}]])

#
# Object definitions
#                                flags
#                                  |
#      Object id       Title  key  | dsp help menu
#
defobj(OBJECT_NONE,    ---,      ,  ,   ,   , [NULL])
defobj(OBJECT_UNKNOWN, ???,      ,  ,   ,   , [NULL])
defobj(OBJECT_ADD,     ADD,     a,  ,   ,   , ["ADD - Adder\tA"])
defobj(OBJECT_MUL,     MUL,     m,  ,   ,   , ["MUL - Multiplier/Ringmodulator\tM"])
defobj(OBJECT_SUB,     SUB,     s,  ,   ,   , ["SUB - Subtractor\tU"])
defobj(OBJECT_SPLIT,   SPLIT,   I,  ,   ,   , ["SPLIT - Positive and negative signal splitter\tShift+I"])
defobj(OBJECT_MINMAX,  MINMAX,   ,  ,   ,   , ["MINMAX - Get minimum and maximum of two input signals"])
defobj(OBJECT_BETWEEN, BETWEEN,  ,  ,   ,   , ["BETWEEN - Window comparator"])
defobj(OBJECT_EXPLIN,  EXPLIN,   ,  ,   ,   , ["EXPLIN - Convert exponential input to linear range"])

# Cleanup
#
undefine([defobj])
