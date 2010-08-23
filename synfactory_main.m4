module([main])

DefWindow([theMainWindow], [MAINWINDOW], ["SynFactory III"], [mainWindowHandler], 400, 400, , [ismainwindow])

code7([block([Main window event handler])[
static void mainWindowHandler(Context_ptr_t aContext) {
	switch (aContext->currentEvent) {
	case GUI_EVENT_MENU:
		logprintf("mainWindowHandler: GUI_EVENT_MENU %d\n", aContext->currentMenu);
		switch(aContext->currentMenu) {
		case MENU_EXIT:
			theQuitFlag = true;
			break;
		case MENU_PROJECT_BROWSER:
			guiShowWindow(theProjectsWindow);
			break;
		case MENU_COLOR_SELECTOR:
			guiShowWindow(theColorSelectorWindow);
			break;
		case MENU_TRANSPORT:
			guiShowWindow(theTransportWindow);
			break;
		case MENU_AUDIO_SCOPE:
			guiShowWindow(theAudioOutputScope);
			break;
		case MENU_AUDIO_MIXER: break;    // no window defined yet
		case MENU_VIDEO_PREVIEW: break;  // no window defined yet
		case MENU_MESSAGES: break;       // no window defined yet
		case MENU_PREFERENCES:
			guiShowWindow(thePreferencesWindow);
			break;
		case MENU_ABOUT:
			guiShowWindow(theHelpWindow);
			break;
		default:
			break;
		}
		break;
	case GUI_EVENT_REFRESH:
		SelectObject(aContext->currentHdc, GetStockObject(WHITE_BRUSH));
		Rectangle(aContext->currentHdc, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);		
		break;
	default:
		break;
	}
}
]])
