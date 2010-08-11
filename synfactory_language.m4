module([language])

define([StringToLangId], [[LANG_]translit([[$1]],
	[ abcdefghijklmnopqrstuvwxyz],
	[_ABCDEFGHIJKLMNOPQRSTUVWXYZ])])

define([EN],[
	Enum([Lang],[$1])
	MacroBack([__Lang_switch],[[case $1: return "$2";]])
])

code3([[
static const char *_(Lang_t aLangValue) {
	switch(aLangValue) {]indent(1,__Lang_switch)[
	default: break;
	}

	return "<invalid Lang_t>";
}
]])

# EN([LANG_AUDIO_OUTPUT_SCOPE_BG_COLOR], [Audio Output Scope Background Color])
# EN([LANG_AUDIO_OUTPUT_SCOPE_LINE_COLOR], [Audio Output Scope Line Color])
# code9([
# StringToLang([Audio Output Scope Background Color])
# ])