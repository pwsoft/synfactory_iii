module([audio output scope])

DefWindow([theAudioOutputScope], "Audio Output Scope", [audioOutputScopeHandler], 400, 400)

DefSetVar([int], [theAudioOutputScopeMode], [0])
SynFileDecimal([OUTPUT_SCOPE_MODE], [theAudioOutputScopeMode]);
WatchVar([theAudioOutputScopeMode], [theAudioOutputScopeRefresh = true;])

PrefColorSelector([OUTPUT_SCOPE_BGCOL], [Audio Output Scope Color], [theAudioOutputScopeBgColor], [COLOR_BLACK])
PrefColorSelector([OUTPUT_SCOPE_BLINE], [Audio Output Scope Base Color], [theAudioOutputScopeBaseColor], [0x00BB00])
PrefColorSelector([OUTPUT_SCOPE_TRACE], [Audio Output Scope Trace Color], [theAudioOutputScopeTraceColor], [0x00BB00])
WatchVar([theAudioOutputScopeBgColor], [theAudioOutputScopeRefresh = true;])
WatchVar([theAudioOutputScopeBaseColor], [theAudioOutputScopeRefresh = true;])
WatchVar([theAudioOutputScopeTraceColor], [theAudioOutputScopeRefresh = true;])

DefConst([static const int OUTPUT_SCOPE_BUFFER_SIZE=1024;])
DefVar([static signed short audioScopeBufferL[OUTPUT_SCOPE_BUFFER_SIZE];])
DefVar([static signed short audioScopeBufferR[OUTPUT_SCOPE_BUFFER_SIZE];])

code7([block([Audio Output Scope event handler])[
static void drawScopeTopBottom(Context_ptr_t aContext) {
	int cnt;
	int yRange;

	SelectObject(aContext->currentHdc, GetStockObject(WHITE_BRUSH));
	guiSelectFillColor(aContext, theAudioOutputScopeBgColor);
	Rectangle(aContext->currentHdc, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);

	yRange=((aContext->clientRect.bottom-16)/4);

	guiSelectPenColor(aContext, theAudioOutputScopeTraceColor, 1);
	guiDrawLineFrom(aContext, 0, yRange-(audioScopeBufferL[0]*yRange)/32768);
	for(cnt=1; cnt<OUTPUT_SCOPE_BUFFER_SIZE; cnt++) {
		guiDrawLineTo(aContext, (cnt*aContext->clientRect.right)/OUTPUT_SCOPE_BUFFER_SIZE, yRange-(audioScopeBufferL[cnt]*yRange)/32768);
	}

	guiDrawLineFrom(aContext, 0, 3*yRange+16-(audioScopeBufferR[0]*yRange)/32768);
	for(cnt=1; cnt<OUTPUT_SCOPE_BUFFER_SIZE; cnt++) {
		guiDrawLineTo(aContext, (cnt*aContext->clientRect.right)/OUTPUT_SCOPE_BUFFER_SIZE, 3*yRange+16-(audioScopeBufferR[cnt]*yRange)/32768);
	}
	
	// Draw base lines
	guiSelectPenColor(aContext, theAudioOutputScopeBaseColor, 1);
	guiDrawLine(aContext, 0, yRange, aContext->clientRect.right,   yRange);
	guiDrawLine(aContext, 0, 3*yRange+16, aContext->clientRect.right, 3*yRange+16);

	//guiSelectTitleFont(aContext);
	guiDrawTransparent(aContext);
	guiSetTextAlignment(aContext, alignBottomLeft);
	guiSelectPenColor(aContext, theAudioOutputScopeBaseColor, 1);
	guiDrawText(aContext, 2, 0, aContext->clientRect.right, yRange, "Left");
	guiDrawText(aContext, 2, 0, aContext->clientRect.right, 3*yRange+16, "Right");

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
	
	
	guiDrawLineFrom(aContext, 0, yRange-(audioScopeBufferL[0]*yRange)/32768);
	for(cnt=1; cnt<OUTPUT_SCOPE_BUFFER_SIZE; cnt++) {
		guiDrawLineTo(aContext, (cnt*xRange)/OUTPUT_SCOPE_BUFFER_SIZE, yRange-(audioScopeBufferL[cnt]*yRange)/32768);
	}

	guiDrawLineFrom(aContext, xRange+16, yRange-(audioScopeBufferR[0]*yRange)/32768);
	for(cnt=1; cnt<OUTPUT_SCOPE_BUFFER_SIZE; cnt++) {
		guiDrawLineTo(aContext, (cnt*xRange)/OUTPUT_SCOPE_BUFFER_SIZE+xRange+16, yRange-(audioScopeBufferR[cnt]*yRange)/32768);
	}
	

	// Draw base lines
	guiSelectPenColor(aContext, theAudioOutputScopeBaseColor, 1);
	guiDrawLine(aContext, 0, yRange, xRange, yRange);
	guiDrawLine(aContext, xRange+16, yRange, aContext->clientRect.right, yRange);

	//guiSelectTitleFont(aContext);
	guiDrawTransparent(aContext);
	guiSetTextAlignment(aContext, alignBottomLeft);
	guiSelectPenColor(aContext, theAudioOutputScopeBaseColor, 1);
	guiDrawText(aContext, 2, 0, aContext->clientRect.right, yRange, "Left");
	guiDrawText(aContext, xRange+18, 0, aContext->clientRect.right, yRange, "Right");

	//DSP_ScopePosition = 0;
}

static void audioOutputScopeHandler(Context_ptr_t aContext) {
	switch(aContext->currentEvent) {
	case GUI_EVENT_TIMER:
		break;
	case GUI_EVENT_REFRESH:
		logprintf("audioOutputScopeHandler refresh\n");

		switch(theAudioOutputScopeMode) {
			case 0:
				// top bottom
				drawScopeTopBottom(aContext);
				break;
			case 1:
				// left right
				drawScopeLeftRight(aContext);
				break;
			default:
				// Fix wrong mode
				]SetVar([theAudioOutputScopeMode], 0)[
				break;
		}
		break;
	case GUI_EVENT_MOUSE_R_DOWN:
		]SetVar([theAudioOutputScopeMode], [1-theAudioOutputScopeMode])[
		break;
	default:
		break;
	}
}
]])
