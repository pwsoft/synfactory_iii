module([preferences])

DefWindow([thePreferencesWindow], ["Preferences"], [preferencesWindowHandler], 400, 400)

define([PrefColorSelector],[
	Var([static color_t $2;])
	MacroBack([__preferences_refresh], [[/* Color selector "$1" */]])
])

code7([block([Preference window event handler])[
static void preferencesWindowHandler(Context_ptr_t aContext) {
	switch(aContext->currentEvent) {
	case GUI_EVENT_REFRESH:]
indent(2,[__preferences_refresh])[
		break;
	default:
		break;
	}
}
]])

