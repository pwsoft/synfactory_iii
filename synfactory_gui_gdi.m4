module([GUI (gdi)])

sysinclude([windowsx.h])
locinclude([resource.h])
Def([#define COLOR_BLACK 0x00000000])
Def([#define COLOR_WHITE 0x00FFFFFF])

Struct([Context], [HWND currentWindow;])
Struct([Context], [HDC currentHdc;])
Struct([Context], [RECT clientRect;])
Struct([Context], [int textAlignment;])
Typedef([typedef int color_t;])
Typedef([typedef HWND GuiWindow_t;])
DefCallback([typedef void (*GuiCallback_t)(Context_ptr_t);])

DefConst([static const char * const mainWindowClass="StudioFactoryMainClass";])
DefConst([
static const int alignTopLeft=(DT_TOP | DT_LEFT);
static const int alignTopCenter=(DT_TOP | DT_CENTER);
static const int alignTopRight=(DT_TOP | DT_RIGHT);
static const int alignLineLeft=(DT_VCENTER | DT_LEFT);
static const int alignLineCenter=(DT_VCENTER | DT_CENTER);
static const int alignLineRight=(DT_VCENTER | DT_RIGHT);
static const int alignBottomLeft=(DT_BOTTOM | DT_LEFT);
static const int alignBottomCenter=(DT_BOTTOM | DT_CENTER);
static const int alignBottomRight=(DT_BOTTOM | DT_RIGHT);
])
DefVar([static HINSTANCE theInstance;])
DefVar([static ATOM mainClassAtom;])

DefVar([static HPEN theCurrentPen = NULL;])
DefVar([static HBRUSH theCurrentBrush = NULL;])


# 1=name, 2=title, 3=handler, 4=xsize, 5=ysize, 6=scroll, 7=main window flag
define([DefWindow],[
	DefVar([static HWND $1;])
	DefVar([static bool $1Refresh;])
	Init(ifelse([$7],,
		ifelse([$6],,
			[$1 = CreateWindowEx(WS_EX_TOOLWINDOW, mainWindowClass, $2, WS_VISIBLE | WS_SYSMENU | WS_CLIPCHILDREN | WS_OVERLAPPED | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX, CW_USEDEFAULT, CW_USEDEFAULT, $4, $5, theMainWindow, NULL, theInstance, NULL);],
			[$1 = CreateWindowEx(WS_EX_TOOLWINDOW, mainWindowClass, $2, WS_VISIBLE | WS_SYSMENU | WS_CLIPCHILDREN | WS_OVERLAPPED | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_HSCROLL | WS_VSCROLL, CW_USEDEFAULT, CW_USEDEFAULT, $4, $5, theMainWindow, NULL, theInstance, NULL);]),
		[$1 = CreateWindowEx(0, mainWindowClass, $2, WS_VISIBLE | WS_SYSMENU | WS_CLIPCHILDREN | WS_OVERLAPPED | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX, CW_USEDEFAULT, CW_USEDEFAULT, $4, $5, NULL, NULL, theInstance, NULL);]))
	Init([SetWindowLong($1, 0, (LONG)$3);])
	Init([UpdateWindow($1);])
	Term([DestroyWindow($1);])
	MacroBack([__eventloop],[if ($1Refresh) {
	(void)InvalidateRect($1, (RECT *)NULL, FALSE);
	$1Refresh=false;
}])
])

code5([block([GUI draw functions (gdi)])[
static void guiSelectPenColor(Context_ptr_t aContext, color_t color, int width) {
	HPEN newPen=NULL;
	if (color>=0 && color<0x1000000) {
		newPen=CreatePen(PS_SOLID, width, 0x02000000 | color);
		SelectObject(aContext->currentHdc, newPen);
		SetTextColor(aContext->currentHdc, 0x02000000 | color);
	} else {
		SelectObject(aContext->currentHdc, GetStockObject(NULL_PEN));
	}
	if (theCurrentPen) DeleteObject(theCurrentPen);
	theCurrentPen=newPen;
}

static void guiSelectFillColor(Context_ptr_t aContext, color_t color)
{
	HBRUSH newBrush=NULL;
	if (color>=0 && color<0x1000000) {
		newBrush=CreateSolidBrush(0x02000000 | color);
		SelectObject(aContext->currentHdc, newBrush);
		SetBkColor(aContext->currentHdc, 0x02000000 | color);
	} else {
		SelectObject(aContext->currentHdc, GetStockObject(NULL_BRUSH));
	}
	if (theCurrentBrush) DeleteObject(theCurrentBrush);
	theCurrentBrush=newBrush;
}

static void guiSetTextAlignment(Context_ptr_t aContext, int aAlignment)
{
	aContext->textAlignment = aAlignment;
}

static void guiDrawLine(Context_ptr_t aContext, int aStartX, int aStartY, int aEndX, int aEndY) {
	(void)MoveToEx(aContext->currentHdc, aStartX, aStartY, NULL);
	(void)LineTo(aContext->currentHdc, aEndX, aEndY);
}

static void guiDrawLineFrom(Context_ptr_t aContext, int aX, int aY) {
	(void)MoveToEx(aContext->currentHdc, aX, aY, NULL);
}

static void guiDrawLineTo(Context_ptr_t aContext, int aX, int aY) {
	(void)LineTo(aContext->currentHdc, aX, aY);
}

static void guiDrawRect(Context_ptr_t aContext, int left, int top, int right, int bottom) {
	(void)Rectangle(aContext->currentHdc, left, top, right+((theCurrentPen)?0:1), bottom+((theCurrentPen)?0:1));
}

static void guiDrawRoundRect(Context_ptr_t aContext, int left, int top, int right, int bottom, int width, int height) {
	(void)RoundRect(aContext->currentHdc, left, top, right, bottom, width, height);
}

static void guiDrawEllipse(Context_ptr_t aContext, int left, int top, int right, int bottom) {
	(void)Ellipse(aContext->currentHdc, left, top, right+((theCurrentPen)?0:1), bottom+((theCurrentPen)?0:1));
}

//static void guiPolygon(Context_ptr_t aContext, GuiPointPtr aPointList, int aCount) {
//	(void)Polygon(aContext->currentHdc, aPointList, aCount);
//}

static void guiDrawOpaque(Context_ptr_t aContext) {
	(void)SetBkMode(aContext->currentHdc, OPAQUE);
}

static void guiDrawTransparent(Context_ptr_t aContext) {
	(void)SetBkMode(aContext->currentHdc, TRANSPARENT);
}

static void guiDrawText(Context_ptr_t aContext, int left, int top, int right, int bottom, const char *text, int count=-1) {
	RECT myRect={left, top, right, bottom};
	DrawText(aContext->currentHdc, text, count, &myRect, aContext->textAlignment | DT_SINGLELINE | DT_NOPREFIX | DT_NOCLIP);
}

static void guiDrawText(Context_ptr_t aContext, int left, int top, const char *text, int count=-1) {
	RECT myRect={left, top, left, top};
	DrawText(aContext->currentHdc, text, count, &myRect, aContext->textAlignment | DT_SINGLELINE | DT_NOPREFIX | DT_NOCLIP);
}

static void guiCalcTextSize(Context_ptr_t aContext, int *xSize, int *ySize, const char *text, int count) {
	SIZE mySize;
	GetTextExtentPoint32(aContext->currentHdc, text, count, &mySize);
	if (xSize) *xSize = mySize.cx;
	if (ySize) *ySize = mySize.cy;
}

static void guiDraw3dFill(Context_ptr_t aContext, int left, int top, int right, int bottom) {
	RECT myRect={left, top, right, bottom};
	DrawEdge(aContext->currentHdc, &myRect, EDGE_SUNKEN, BF_MIDDLE);
}

static void guiDraw3dRect(Context_ptr_t aContext, int left, int top, int right, int bottom, bool pressed) {
	RECT myRect={left, top, right, bottom};
	if (theCurrentBrush) {
		(void)FillRect(aContext->currentHdc, &myRect, theCurrentBrush);
		DrawEdge(aContext->currentHdc, &myRect, (pressed)?EDGE_SUNKEN:EDGE_RAISED, BF_RECT);
	} else {
		DrawEdge(aContext->currentHdc, &myRect, (pressed)?EDGE_SUNKEN:EDGE_RAISED, BF_RECT | BF_MIDDLE);
	}
}
]])

code5([block([GUI window functions (gdi)])[
static inline void guiSetFocus(HWND aWindow) {
	(void)SetFocus(aWindow);
}

static inline void guiHideWindow(HWND aWindow) {
	(void)ShowWindow(aWindow, SW_HIDE);
	if (aWindow != theMainWindow) {
		(void)SetFocus(theMainWindow);
	}
}

static inline void guiShowWindow(HWND aWindow) {
	(void)ShowWindow(aWindow, SW_SHOW);
	(void)SetFocus(aWindow);
}

static void guiRefreshWindow(HWND window, int left, int top, int right, int bottom)  {
	RECT myRect={left, top, right, bottom};
	(void)InvalidateRect(window, &myRect, FALSE);
}

static void guiRefreshWindow(HWND window) {
	(void)InvalidateRect(window, (RECT *)NULL, FALSE);
}


static void guiSetWindowTitle(HWND aWindow, const char *aTitle) {
	SetWindowText(aWindow, aTitle);
}

static inline bool guiIsWindowVisible(HWND aWindow) {
	return (IsWindowVisible(aWindow) == TRUE);
}

static bool guiIsWindowMaximized(HWND aWindow) {
	WINDOWPLACEMENT winpos;
	winpos.length = sizeof(WINDOWPLACEMENT);
	GetWindowPlacement(aWindow, &winpos);
	return (SW_SHOWMAXIMIZED==winpos.showCmd);
}

static void guiGetWindowPosition(HWND aWindow, int *xPtr, int *yPtr, int *hPtr, int *wPtr) {
	WINDOWPLACEMENT winpos;
	winpos.length = sizeof(WINDOWPLACEMENT);
	GetWindowPlacement(aWindow, &winpos);
	*xPtr = winpos.rcNormalPosition.left;
	*yPtr = winpos.rcNormalPosition.top;
	*wPtr = winpos.rcNormalPosition.right-winpos.rcNormalPosition.left;
	*hPtr = winpos.rcNormalPosition.bottom-winpos.rcNormalPosition.top;
}

]])

code5([block([Scroll bar control (gdi)])[

static void guiHScrollWindowTo(HWND window, int pos) {
	SCROLLINFO myScrollInfo;
	int oldPos;
	int page;

	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS | SIF_TRACKPOS | SIF_PAGE | SIF_RANGE;
	GetScrollInfo(window, SB_HORZ, &myScrollInfo);

	oldPos = myScrollInfo.nPos;
	myScrollInfo.nPos=pos;
	page=(int)myScrollInfo.nPage;

	if (myScrollInfo.nPos<myScrollInfo.nMin) myScrollInfo.nPos=myScrollInfo.nMin;
	if (myScrollInfo.nPos>myScrollInfo.nMax-page) myScrollInfo.nPos=max(myScrollInfo.nMin, myScrollInfo.nMax-page);
	if (oldPos != myScrollInfo.nPos) {
		myScrollInfo.cbSize=sizeof(myScrollInfo);
		myScrollInfo.fMask=SIF_POS;
		SetScrollInfo(window, SB_HORZ, &myScrollInfo, TRUE);
		guiRefreshWindow(window);
	}
}

static void guiVScrollWindowTo(HWND window, int pos) {
	SCROLLINFO myScrollInfo;
	int oldPos;
	int page;

	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS | SIF_TRACKPOS | SIF_PAGE | SIF_RANGE;
	GetScrollInfo(window, SB_VERT, &myScrollInfo);

	oldPos = myScrollInfo.nPos;
	myScrollInfo.nPos = pos;
	page=(int)myScrollInfo.nPage;

	if (myScrollInfo.nPos<myScrollInfo.nMin) myScrollInfo.nPos=myScrollInfo.nMin;
	if (myScrollInfo.nPos>myScrollInfo.nMax-page) myScrollInfo.nPos=max(myScrollInfo.nMin, myScrollInfo.nMax-page);
	if (oldPos != myScrollInfo.nPos) {
		myScrollInfo.cbSize=sizeof(myScrollInfo);
		myScrollInfo.fMask=SIF_POS;
		SetScrollInfo(window, SB_VERT, &myScrollInfo, TRUE);
		guiRefreshWindow(window);
	}
}

static void guiHScrollRange(HWND window, int aMininum, int aMaximum, int aPage) {
	SCROLLINFO myScrollInfo;
	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS | SIF_PAGE | SIF_RANGE;
	GetScrollInfo(window, SB_HORZ, &myScrollInfo);
	myScrollInfo.nMin=aMininum;
	myScrollInfo.nMax=aMaximum;
	myScrollInfo.nPage=aPage;

	if (myScrollInfo.nPos<myScrollInfo.nMin) myScrollInfo.nPos=myScrollInfo.nMin;
	if (myScrollInfo.nPos>myScrollInfo.nMax-aPage) myScrollInfo.nPos=max(myScrollInfo.nMin, myScrollInfo.nMax-aPage);
	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS | SIF_PAGE | SIF_RANGE | SIF_DISABLENOSCROLL;
	SetScrollInfo(window, SB_HORZ, &myScrollInfo, TRUE);
}

static void guiVScrollRange(HWND window, int aMininum, int aMaximum, int aPage) {
	SCROLLINFO myScrollInfo;
	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS | SIF_PAGE | SIF_RANGE;
	GetScrollInfo(window, SB_VERT, &myScrollInfo);
	myScrollInfo.nMin=aMininum;
	myScrollInfo.nMax=aMaximum;
	myScrollInfo.nPage=aPage;

	if (myScrollInfo.nPos<myScrollInfo.nMin) myScrollInfo.nPos=myScrollInfo.nMin;
	if (myScrollInfo.nPos>myScrollInfo.nMax-aPage) myScrollInfo.nPos=max(myScrollInfo.nMin, myScrollInfo.nMax-aPage);
	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS | SIF_PAGE | SIF_RANGE | SIF_DISABLENOSCROLL;
	SetScrollInfo(window, SB_VERT, &myScrollInfo, TRUE);
}

static int guiGetHScrollPos(HWND window) {
	SCROLLINFO myScrollInfo;

	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS;
	GetScrollInfo(window, SB_HORZ, &myScrollInfo);
	return myScrollInfo.nPos;
}

static int guiGetVScrollPos(HWND window) {
	SCROLLINFO myScrollInfo;

	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS;
	GetScrollInfo(window, SB_VERT, &myScrollInfo);
	return myScrollInfo.nPos;
}

static void guiSetHScrollPos(HWND window, int pos) {
	SCROLLINFO myScrollInfo;

	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS;
	myScrollInfo.nPos=pos;
	SetScrollInfo(window, SB_HORZ, &myScrollInfo, TRUE);
	guiRefreshWindow(window);
}

static void guiSetVScrollPos(HWND window, int pos) {
	SCROLLINFO myScrollInfo;

	myScrollInfo.cbSize=sizeof(myScrollInfo);
	myScrollInfo.fMask=SIF_POS;
	myScrollInfo.nPos=pos;
	SetScrollInfo(window, SB_VERT, &myScrollInfo, TRUE);
	guiRefreshWindow(window);
}

]])

code8([block([Timer events (gdi)])[
static void guiRunTimer(HWND aWindow, int aTimeMs) {
	SetTimer(aWindow, 0, aTimeMs, NULL);
}
]])

code8([block([Default window event handler (gdi)])[
static void sendEvent(Context_t *aContext, HWND aWindow, GuiEvent_t event, int mouseX, int mouseY) {
	GuiCallback_t myCallback = (GuiCallback_t)GetWindowLong(aWindow, 0);

	if (myCallback) {
		aContext->currentEvent = event;
		aContext->currentWindow = aWindow;
		aContext->textAlignment = alignTopLeft;
		aContext->mouseX = mouseX;
		aContext->mouseY = mouseY;
		GetClientRect(aWindow, &(aContext->clientRect));

		/* Call handler */
		myCallback(aContext);					
	}
}

static LRESULT CALLBACK stdWindowProc(HWND aWindow, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	Context_t myContext;

	memset(&myContext, 0, sizeof(myContext));
	switch(uMsg) {
	case WM_COMMAND: {
			if (HIWORD(wParam) == 0) {
				logprintf("Menu item %d %s\n", LOWORD(wParam), convertMenuToString(myContext.currentMenu));
				myContext.currentMenu = (Menu_t)LOWORD(wParam);
				sendEvent(&myContext, aWindow, GUI_EVENT_MENU, 0, 0);
			}
		} break;
	case WM_SIZE: {
			InvalidateRect(aWindow, NULL, FALSE);
		} break;
	case WM_HSCROLL: {
			SCROLLINFO myScrollInfo;
			myScrollInfo.cbSize=sizeof(myScrollInfo);
			myScrollInfo.fMask=SIF_POS | SIF_TRACKPOS | SIF_PAGE | SIF_RANGE;
			GetScrollInfo(aWindow, SB_HORZ, &myScrollInfo);
			int page=(int)myScrollInfo.nPage;
			int oldPos=myScrollInfo.nPos;
		
			switch(LOWORD(wParam)) {
			case SB_PAGEUP:
				myScrollInfo.nPos-=myScrollInfo.nPage;
				break;
			case SB_LINEUP:
				myScrollInfo.nPos-=16;
				break;
			case SB_PAGEDOWN:
				myScrollInfo.nPos+=myScrollInfo.nPage;
				break;
			case SB_LINEDOWN:
				myScrollInfo.nPos+=16;
				break;
			case SB_THUMBTRACK:
				myScrollInfo.nPos=myScrollInfo.nTrackPos;
				break;
			default:
				break;
			}

			if (myScrollInfo.nPos<myScrollInfo.nMin) myScrollInfo.nPos=myScrollInfo.nMin;
			if (myScrollInfo.nPos>myScrollInfo.nMax-page) myScrollInfo.nPos=myScrollInfo.nMax-page;
			if (oldPos != myScrollInfo.nPos) {
				myScrollInfo.cbSize=sizeof(myScrollInfo);
				myScrollInfo.fMask=SIF_POS;
				SetScrollInfo(aWindow, SB_HORZ, &myScrollInfo, TRUE);
				InvalidateRect(aWindow, NULL, FALSE);
			}
		} break;
	case WM_VSCROLL: {
			SCROLLINFO myScrollInfo;
			myScrollInfo.cbSize=sizeof(myScrollInfo);
			myScrollInfo.fMask=SIF_POS | SIF_TRACKPOS | SIF_PAGE | SIF_RANGE;
			GetScrollInfo(aWindow, SB_VERT, &myScrollInfo);
			int page=(int)myScrollInfo.nPage;
			int oldPos=myScrollInfo.nPos;
		
			switch(LOWORD(wParam)) {
			case SB_PAGEUP:
				myScrollInfo.nPos-=myScrollInfo.nPage;
				break;
			case SB_LINEUP:
				myScrollInfo.nPos-=16;
				break;
			case SB_PAGEDOWN:
				myScrollInfo.nPos+=myScrollInfo.nPage;
				break;
			case SB_LINEDOWN:
				myScrollInfo.nPos+=16;
				break;
			case SB_THUMBTRACK:
				myScrollInfo.nPos=myScrollInfo.nTrackPos;
				break;
			default:
				break;
			}

			if (myScrollInfo.nPos<myScrollInfo.nMin) myScrollInfo.nPos=myScrollInfo.nMin;
			if (myScrollInfo.nPos>myScrollInfo.nMax-page) myScrollInfo.nPos=max(myScrollInfo.nMin, myScrollInfo.nMax-page);
			if (oldPos != myScrollInfo.nPos) {
				myScrollInfo.cbSize=sizeof(myScrollInfo);
				myScrollInfo.fMask=SIF_POS;
				SetScrollInfo(aWindow, SB_VERT, &myScrollInfo, TRUE);
				InvalidateRect(aWindow, NULL, FALSE);
			}
		} break;
	case WM_PAINT: {
			PAINTSTRUCT ps;
			HDC hdc=BeginPaint(aWindow, &ps);

			myContext.currentEvent = GUI_EVENT_REFRESH;
			myContext.currentWindow = aWindow;
			myContext.currentHdc = hdc;
			GetClientRect(aWindow, &(myContext.clientRect));

			GuiCallback_t myCallback = (GuiCallback_t)GetWindowLong(aWindow, 0);
			if (myCallback) {
				myCallback(&myContext);
			} else {
				SelectObject(hdc, GetStockObject(BLACK_BRUSH));
				Rectangle(hdc, myContext.clientRect.left, myContext.clientRect.top, myContext.clientRect.right, myContext.clientRect.bottom);
			}

			EndPaint(aWindow, &ps);

		} break;
	case WM_TIMER: {
			POINT p;
			GetCursorPos(&p);
			ScreenToClient(aWindow, &p);
			sendEvent(&myContext, aWindow, GUI_EVENT_TIMER, p.x, p.y);
		} break;
	case WM_LBUTTONDOWN:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_L_DOWN, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_LBUTTONUP:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_L_UP, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_LBUTTONDBLCLK:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_L_DCLK, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_MBUTTONDOWN:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_M_DOWN, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_MBUTTONUP:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_M_UP, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_MBUTTONDBLCLK:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_M_DCLK, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_RBUTTONDOWN:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_R_DOWN, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_RBUTTONUP:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_R_UP, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_RBUTTONDBLCLK:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_R_DCLK, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam));
		break;
	case WM_CLOSE:
		if (aWindow == theMainWindow) {
			theQuitFlag = true;
		} else {
			guiHideWindow(aWindow);
		}
		break;
	default:
		return DefWindowProc(aWindow, uMsg, wParam, lParam);
	}
	
	return 0;
}]

block([Create and register default window class])[
static void createWindowClass(void) {
	WNDCLASSEX myClass;
	myClass.cbSize=sizeof(myClass);
	myClass.style=CS_DBLCLKS; /* Enable double click processing */
	myClass.lpfnWndProc=stdWindowProc;
	myClass.cbClsExtra=0;
	myClass.cbWndExtra=4;
	myClass.hInstance=theInstance;
	myClass.hIcon=LoadIcon(theInstance, MAKEINTRESOURCE(IDI_MAINICON));
	myClass.hCursor=LoadCursor(NULL, IDC_ARROW);
	myClass.hbrBackground=NULL;
	myClass.lpszMenuName=NULL;
	myClass.lpszClassName=mainWindowClass;
	myClass.hIconSm=NULL;
	mainClassAtom=RegisterClassEx(&myClass);
}
]])

Init([createWindowClass();])
