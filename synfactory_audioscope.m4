module([audio output scope])

DefConst([static const int OUTPUT_SCOPE_BUFFER_SIZE=1024;])
DefVar([static int theAudioOutputScopeMode=0;])

DefWindow([theAudioOutputScope], "Audio Output Scope", [audioOutputScopeHandler], 400, 400)
PrefColorSelector([Audio Output Scope Color], [theAudioOutputScopeBgColor], [COLOR_BLACK])
PrefColorSelector([Audio Output Scope Line Color], [theAudioOutputScopeLineColor], [0x00BB00])
WatchVar([theAudioOutputScopeBgColor], [theAudioOutputScopeRefresh = true;])
WatchVar([theAudioOutputScopeLineColor], [theAudioOutputScopeRefresh = true;])

code7([block([Audio Output Scope event handler])[
void audioOutputScopeHandler(Context_ptr_t aContext) {
	int yRange = 0;
	
	switch(aContext->currentEvent) {
	case GUI_EVENT_TIMER:
		break;
	case GUI_EVENT_REFRESH:
		logprintf("audioOutputScopeHandler refresh\n");
		
		yRange=((aContext->clientRect.bottom-16)/4);

		
		SelectObject(aContext->currentHdc, GetStockObject(WHITE_BRUSH));
		guiSelectFillColor(aContext, theAudioOutputScopeBgColor);
		Rectangle(aContext->currentHdc, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);		


		// Draw base lines
		guiSelectPenColor(aContext, theAudioOutputScopeLineColor, 1);
		guiDrawLine(aContext, 0, yRange, aContext->clientRect.right,   yRange);
		guiDrawLine(aContext, 0, 3*yRange+16, aContext->clientRect.right, 3*yRange+16);
		break;
	default:
		break;
	}
}
]])