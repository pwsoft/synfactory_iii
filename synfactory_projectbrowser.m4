module([Project Browser])

DefWindow([theProjectsWindow], "Project Browser", [projectBrowserHandler], 400, 400, [isscrollable])
WatchVar([theProjects], [theProjectsWindowRefresh = true;])

code7([block([Project Browser window event handler])[
static void projectBrowserDrawExpandBox(Context_ptr_t aContext, int x, int y, bool expanded) {
	guiSelectFillColor(aContext, -1);
	guiDrawRect(aContext, x, y, x+14, y+12);
	guiDrawLine(aContext, x+4, y+6, x+11, y+6);
	if (!expanded) {
		guiDrawLine(aContext,  x+7, y+3, x+7, y+10);
	}
}

static void projectBrowserDrawText(Context_ptr_t aContext, int x, int y, const char *aString) {
//	int xSize = 0;
	guiDrawText(aContext, x, y, aString);
//	guiCalcTextSize(aContext, &xSize, NULL, aString);
}

static void projectBrowserClickExpandbox(Context_ptr_t aContext, int x, int y, Project_ptr_t aProject) {
	if (aContext->mouseX > x+2 && aContext->mouseX < x+16
	&& aContext->mouseY > y && aContext->mouseY < y+12) {
		aProject->unfolded = not aProject->unfolded;
		theProjectsWindowRefresh = true;
	}
}

static void projectBrowserHandler(Context_ptr_t aContext) {
	static int maxx = -1;
	static int maxy = -1;
	int x = -guiGetHScrollPos(aContext->currentWindow);
	int y = -guiGetVScrollPos(aContext->currentWindow);
	int xstart = x;
	int ystart = y;

	switch(aContext->currentEvent) {
	case GUI_EVENT_REFRESH:
		guiSetTextAlignment(aContext, alignTopLeft);
		guiDrawTransparent(aContext);
		guiSelectPenColor(aContext, -1, 0);
		guiSelectFillColor(aContext, COLOR_WHITE);
		guiDrawRect(aContext, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);
//		y += 500;
		for(int p=0; p<projects_count; p++)
		{
			guiSelectPenColor(aContext, COLOR_BLACK, 1);
			projectBrowserDrawExpandBox(aContext, x+2, y, theProjects[p].unfolded);
			projectBrowserDrawText(aContext, x+20, y, "New project");
			y+=14;
		}
		logprintf("vscroll %d %d %d\n", y, ystart, aContext->clientRect.bottom);
		if ((y-ystart) != maxy) {
			maxy = y-ystart;
			guiVScrollRange(aContext->currentWindow, 0, maxy, 1); //aContext->clientRect.bottom);
		}
		break;
	case GUI_EVENT_MOUSE_L_DOWN:
		for(int p=0; p<projects_count; p++)
		{
			projectBrowserClickExpandbox(aContext, x, y, theProjects + p);
			y+=14;
		}
		break;
	default:
		break;
	}
}
]])
