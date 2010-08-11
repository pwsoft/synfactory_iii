module([preferences])

DefWindow([thePreferencesWindow], ["Preferences"], [preferencesWindowHandler], 400, 400)

define([__preferences_refresh],)
define([__preferences_click],)
define([PrefColorSelector],[
	EN([LANG_]StringToId($1), [$1])
	DefSetVar([color_t], [$2], [$3])
	MacroBack([__preferences_refresh], [[preferencesDrawHeader(aContext, x, y, LANG_]StringToId($1)[);]])
	MacroBack([__preferences_refresh], [[preferencesDrawColorBar(aContext, x, y, $2);]])
	MacroBack([__preferences_click], [[preferencesClickColorBar(aContext, x, y, $2);]])
	SynSave("StringToId($1)[ %08X\n", $2]);
])

code7([block([Preference window event handler])[
static void preferencesDrawHeader(Context_ptr_t aContext, int x, int &y, Lang_t aString) {
	guiSelectFillColor(aContext, COLOR_WHITE);
	guiSelectPenColor(aContext, 0x004466, 1);
	guiDrawText(aContext, x, y, _(aString), strlen(_(aString)));
	y += 14;
}

static int colorNotMask[3]={0xFFFF00,0xFF00FF,0x00FFFF};
static int colorMask[3]={0x0000FF,0x00FF00,0xFF0000};
static int colorSelector[3][16]={
	{0x000000,0x000011,0x000022,0x000033,0x000044,0x000055,0x000066,0x000077,0x000088,0x000099,0x0000AA,0x0000BB,0x0000CC,0x0000DD,0x0000EE,0x0000FF},
	{0x000000,0x001100,0x002200,0x003300,0x004400,0x005500,0x006600,0x007700,0x008800,0x009900,0x00AA00,0x00BB00,0x00CC00,0x00DD00,0x00EE00,0x00FF00},
	{0x000000,0x110000,0x220000,0x330000,0x440000,0x550000,0x660000,0x770000,0x880000,0x990000,0xAA0000,0xBB0000,0xCC0000,0xDD0000,0xEE0000,0xFF0000}};
static const size_t colorSelectorSteps = sizeof(colorSelector[0])/sizeof(colorSelector[0][0]);
static void preferencesDrawColorBar(Context_ptr_t aContext, int x, int &y, color_t current) {
	guiSelectPenColor(aContext, -1, 0);
	for(int i=0;i<3;i++) {
		for(size_t j=0;j<colorSelectorSteps;j++) {
			guiSelectFillColor(aContext, (current&colorNotMask[i])+colorSelector[i][j]);
			guiDrawRect(aContext, x+30+j*14, y+20*i, x+30+j*14+10, y+20*i+12);
			if ((current&colorMask[i])==colorSelector[i][j])
			{
				guiSelectFillColor(aContext, 0);
				guiDrawRect(aContext, x+30+j*14, y+20*i+13, x+30+j*14+10, y+20*i+15);
			}
		}
	}
	y += 60;
}

static bool preferencesClickColorBar(Context_ptr_t aContext, int x, int &y, color_t &value) {
	bool result = false;

	/* Skip header text */
	y += 14;
	
	for(int color=0; color<3; color++) {
		if (aContext->mouseX >= 30 && aContext->mouseX < 30+colorSelectorSteps*14
		&& aContext->mouseY >= y && aContext->mouseY < y+20) {
			value = (value & colorNotMask[color]) | colorSelector[color][(aContext->mouseX-30)/14];
			thePreferencesWindowRefresh = true;
			result = true;
		}
		y += 20;
	}
	
	return result;
}

static void preferencesWindowHandler(Context_ptr_t aContext) {
	int x = 0;
	int y = 0;

	switch(aContext->currentEvent) {
	case GUI_EVENT_REFRESH:
//		guiSetTextAlignment(aContext, alignTopLeft);
		guiSelectPenColor(aContext, -1, 0);
		guiSelectFillColor(aContext, COLOR_WHITE);
		guiDrawRect(aContext, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);]
indent(2,__preferences_refresh)[
		break;
	case GUI_EVENT_MOUSE_L_DOWN:]
indent(2,__preferences_click)[
		break;
	default:
		break;
	}
}
]])

