module([main])

DefWindow([theMainWindow], ["SynFactory III"], [mainWindowHandler], 400, 400, [ismainwindow])

code7([block([Main window event handler])[
static void mainWindowHandler(Context_ptr_t aContext) {
	switch (aContext->currentEvent) {
	case GUI_EVENT_MENU:
		logprintf("mainWindowHandler: GUI_EVENT_MENU %d", aContext->currentMenu);
		switch(aContext->currentMenu) {
		case MENU_PROJECT_BROWSER:
			ShowWindow(theProjectsWindow, SW_SHOW);
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