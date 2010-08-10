module([preferences])

DefWindow([thePreferencesWindow], ["Preferences"], [preferencesWindowHandler], 400, 400)

define([__preferences_refresh],)
define([PrefColorSelector],[
	DefVar([static color_t $2;])
	MacroBack([__preferences_refresh], [[/* Color selector "$1" */]])
])

code7([block([Preference window event handler])[
static void preferencesWindowHandler(Context_ptr_t aContext) {
	switch(aContext->currentEvent) {
	case GUI_EVENT_REFRESH: {
		int x = 0;
		int y = 0;
		SelectObject(aContext->currentHdc, GetStockObject(WHITE_BRUSH));
		Rectangle(aContext->currentHdc, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);]
indent(2,__preferences_refresh)[
		} break;
	default:
		break;
	}
}
]])

