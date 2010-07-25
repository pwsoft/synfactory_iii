#
# Object macros
#
define([defobj],[
	Enum([Object],[OBJECT_$1])
	Enum([Menu], [MENU_OBJECT_$1])
	MacroBack([__ObjectTitles],[	case OBJECT_$1: return "[$2]";])
	ifelse([$3],,,[MacroBack([__ObjectKeys],[[	case '$3': return OBJECT_$1;]])])
	ifelse([$7],NULL,,[MacroBack([__ObjectMenus],[[	case OBJECT_$1: return $7;]])])
])

#
# Object support functions
#
code3([block([[Get the module title for given object type]])[
static const char *objectToTitle(Object_t aObject) {
	switch(aObject) {]]
__ObjectTitles
[[	default:
		break;
	}
	return "???";
}]])

code3([block([[Convert a key pressed on the keyboard to object type]])[
static Object_t keyToObject(int aKey) {
	switch(aKey) {]]
__ObjectKeys
[[	default:
		break;
	}
	return OBJECT_NONE;
}]])

code3([block([[Convert from object to menu name]])[
static const char *objectToMenu(Object_t aObject) {
	switch(aObject) {]]
__ObjectMenus
[[	default:
		break;
	}
	return NULL;
}]])

#
# Object definitions
#                             flags
#                               |
#      Object id  Title    key  | dsp help menu
#
defobj([NONE],    [---],      ,  ,   ,   , [NULL])
defobj([UNKNOWN], [???],      ,  ,   ,   , [NULL])
defobj([ADD],     [ADD],     a,  ,   ,   , ["ADD - Adder\tA"])
defobj([MUL],     [MUL],     m,  ,   ,   , ["MUL - Multiplier/Ringmodulator\tM"])
defobj([SUB],     [SUB],     s,  ,   ,   , ["SUB - Subtractor\tU"])
defobj([SPLIT],   [SPLIT],   I,  ,   ,   , ["SPLIT - Positive and negative signal splitter\tShift+I"])
defobj([MINMAX],  [MINMAX],   ,  ,   ,   , ["MINMAX - Get minimum and maximum of two input signals"])
defobj([BETWEEN], [BETWEEN],  ,  ,   ,   , ["BETWEEN - Window comparator"])
defobj([EXPLIN],  [EXPLIN],   ,  ,   ,   , ["EXPLIN - Convert exponential input to linear range"])

# Cleanup
#
undefine([defobj])
