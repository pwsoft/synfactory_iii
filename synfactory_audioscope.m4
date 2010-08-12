module([audio output scope])

DefWindow([theAudioOutputScope], "Audio Output Scope", [audioOutputScopeHandler], 400, 400)

DefConst([static const int OUTPUT_SCOPE_BUFFER_SIZE=1024;])
DefVar([static int theAudioOutputScopeMode=0;])

PrefColorSelector([OUTPUT_SCOPE_BGCOL], [Audio Output Scope Color], [theAudioOutputScopeBgColor], [COLOR_BLACK])
PrefColorSelector([OUTPUT_SCOPE_BLINE], [Audio Output Scope Base Color], [theAudioOutputScopeBaseColor], [0x00BB00])
PrefColorSelector([OUTPUT_SCOPE_TRACE], [Audio Output Scope Trace Color], [theAudioOutputScopeTraceColor], [0x00BB00])
WatchVar([theAudioOutputScopeBgColor], [theAudioOutputScopeRefresh = true;])
WatchVar([theAudioOutputScopeBaseColor], [theAudioOutputScopeRefresh = true;])
WatchVar([theAudioOutputScopeTraceColor], [theAudioOutputScopeRefresh = true;])

code7([block([Audio Output Scope event handler])[
static void drawScopeTopBottom(Context_ptr_t aContext) {
	int cnt;
	int yRange;

	SelectObject(aContext->currentHdc, GetStockObject(WHITE_BRUSH));
	guiSelectFillColor(aContext, theAudioOutputScopeBgColor);
	Rectangle(aContext->currentHdc, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);

	yRange=((aContext->clientRect.bottom-16)/4);

	/* reenable this when able
	guiSelectPen1Color(aContext, 0xFFFFFF);
	guiDrawLineFrom(aContext, 0, yRange-(DSP_ScopeL[0]*yRange)/32768);
	for(cnt=1; cnt<OUTPUT_SCOPE_BUFFER_SIZE; cnt++) {
		guiDrawLineTo(aContext, (cnt*aContext->clientRect.right)/OUTPUT_SCOPE_BUFFER_SIZE, yRange-(DSP_ScopeL[cnt]*yRange)/32768);
	}

	guiDrawLineFrom(aContext, 0, 3*yRange+16-(DSP_ScopeR[0]*yRange)/32768);
	for(cnt=1; cnt<OUTPUT_SCOPE_BUFFER_SIZE; cnt++) {
		guiDrawLineTo(aContext, (cnt*aContext->clientRect.right)/OUTPUT_SCOPE_BUFFER_SIZE, 3*yRange+16-(DSP_ScopeR[cnt]*yRange)/32768);
	}
	*/
	
	// Draw base lines
	guiSelectPenColor(aContext, theAudioOutputScopeBaseColor, 1);
	guiDrawLine(aContext, 0, yRange, aContext->clientRect.right,   yRange);
	guiDrawLine(aContext, 0, 3*yRange+16, aContext->clientRect.right, 3*yRange+16);

	//guiSelectTitleFont(aContext);
	//guiDrawTransparent(aContext);
	//guiSetTextAlignment(aContext, alignBottomLeft);
	//guiSelectPen1Color(aContext, 0x00BB00);
	//guiDrawText(aContext, 2, 0, aContext->clientRect.right, yRange, "Left");
	//guiDrawText(aContext, 2, 0, aContext->clientRect.right, 3*yRange+16, "Right");

	//DSP_ScopePosition = 0;
}

static void drawScopeLeftRight(Context_ptr_t aContext) {
	int cnt;
	int yRange;
	int xRange;

	SelectObject(aContext->currentHdc, GetStockObject(WHITE_BRUSH));
	guiSelectFillColor(aContext, theAudioOutputScopeBgColor);
	Rectangle(aContext->currentHdc, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);

	yRange=(aContext->clientRect.bottom/2);
	xRange=((aContext->clientRect.right-16)/2);

	guiSelectPenColor(aContext, theAudioOutputScopeTraceColor, 1);
	
	/* reenable this when able
	guiDrawLineFrom(aContext, 0, yRange-(DSP_ScopeL[0]*yRange)/32768);
	for(cnt=1; cnt<OUTPUT_SCOPE_BUFFER_SIZE; cnt++) {
		guiDrawLineTo(aContext, (cnt*xRange)/OUTPUT_SCOPE_BUFFER_SIZE, yRange-(DSP_ScopeL[cnt]*yRange)/32768);
	}

	guiDrawLineFrom(aContext, xRange+16, yRange-(DSP_ScopeR[0]*yRange)/32768);
	for(cnt=1; cnt<OUTPUT_SCOPE_BUFFER_SIZE; cnt++) {
		guiDrawLineTo(aContext, (cnt*xRange)/OUTPUT_SCOPE_BUFFER_SIZE+xRange+16, yRange-(DSP_ScopeR[cnt]*yRange)/32768);
	}
	*/

	// Draw base lines
	guiSelectPenColor(aContext, theAudioOutputScopeBaseColor, 1);
	guiDrawLine(aContext, 0, yRange, xRange, yRange);
	guiDrawLine(aContext, xRange+16, yRange, aContext->clientRect.right, yRange);

	//guiSelectTitleFont(aContext);
	//guiDrawTransparent(aContext);
	//guiSetTextAlignment(aContext, alignBottomLeft);
	//guiSelectPen1Color(aContext, 0x00BB00);
	//guiDrawText(aContext, 2, 0, aContext->clientRect.right, yRange, "Left");
	//guiDrawText(aContext, xRange+18, 0, aContext->clientRect.right, yRange, "Right");

	//DSP_ScopePosition = 0;
}

static void audioOutputScopeHandler(Context_ptr_t aContext) {
	int yRange = 0;
	
	switch(aContext->currentEvent) {
	case GUI_EVENT_TIMER:
		break;
	case GUI_EVENT_REFRESH:
		logprintf("audioOutputScopeHandler refresh\n");
		
		switch(theAudioOutputScopeMode)
		{
			case 0: // top bottom
				drawScopeTopBottom(aContext);
				break;
			case 1: // left right
				drawScopeLeftRight(aContext);
				break;
		}
		
		/*
		yRange=((aContext->clientRect.bottom-16)/4);
		
		SelectObject(aContext->currentHdc, GetStockObject(WHITE_BRUSH));
		guiSelectFillColor(aContext, theAudioOutputScopeBgColor);
		Rectangle(aContext->currentHdc, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);		

		// Draw base lines
		guiSelectPenColor(aContext, theAudioOutputScopeBaseColor, 1);
		guiDrawLine(aContext, 0, yRange, aContext->clientRect.right,   yRange);
		guiDrawLine(aContext, 0, 3*yRange+16, aContext->clientRect.right, 3*yRange+16);
		*/
		break;
	case GUI_EVENT_MOUSE_R_DOWN:
		theAudioOutputScopeMode=1-theAudioOutputScopeMode;
		theAudioOutputScopeRefresh=true;
		break;
	default:
		break;
	}
}
]])
