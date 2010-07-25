module([GUI (gdi)])

locinclude([resource.h])

Struct([Context], [HWND currentWindow;])
Struct([Context], [HDC currentHdc;])
Struct([Context], [RECT clientRect;])
Typedef([typedef int color_t;])
DefCallback([typedef void (*GuiCallback_t)(Context_ptr_t);])

Const([static const char * const mainWindowClass="StudioFactoryMainClass";])
Var([static HINSTANCE theInstance;])
Var([static ATOM mainClassAtom;])

# 1=name, 2=title, 3=handler, 4=xsize, 5=ysize, 6=main window flag
define([DefWindow],[
	Var([static HWND $1;])
	Var([static bool $1Refresh;])
	Init(ifelse([$6],,
		[$1 = CreateWindowEx(WS_EX_TOOLWINDOW, mainWindowClass, $2, WS_VISIBLE | WS_SYSMENU | WS_CLIPCHILDREN | WS_OVERLAPPED | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_VSCROLL, CW_USEDEFAULT, CW_USEDEFAULT, $4, $5, theMainWindow, NULL, theInstance, NULL);],
		[$1 = CreateWindowEx(0, mainWindowClass, $2, WS_VISIBLE | WS_SYSMENU | WS_CLIPCHILDREN | WS_OVERLAPPED | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_VSCROLL, CW_USEDEFAULT, CW_USEDEFAULT, $4, $5, theMainWindow, NULL, theInstance, NULL);]))
	Init([SetWindowLong($1, 0, (LONG)$3);])
	Init([UpdateWindow($1);])
	Term([DestroyWindow($1);])
	MacroBack([__eventloop],[if ($1Refresh) {
	(void)InvalidateRect($1, (RECT *)NULL, FALSE);
	$1Refresh=false;
}])
])

code5([block([GUI primitives (gdi)])[
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

static void guiSetWindowTitle(HWND aWindow, const char *aTitle) {
	SetWindowText(aWindow, aTitle);
}

static inline bool guiIsWindowVisible(HWND aWindow) {
	return (IsWindowVisible(aWindow) == TRUE);
}

]])

code8([block([Default window event handler (gdi)])[
static void sendEvent(Context_t *aContext, HWND aWindow, GuiEvent_t event) {
	GuiCallback_t myCallback = (GuiCallback_t)GetWindowLong(aWindow, 0);

	if (myCallback) {
		aContext->currentEvent = event;
		aContext->currentWindow = aWindow;
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
				myContext.currentEvent = GUI_EVENT_MENU;
				myContext.currentWindow = aWindow;
				myContext.currentMenu = (Menu_t)LOWORD(wParam);
// TODO:				myContext.currentHdc = hdc;
				GetClientRect(aWindow, &(myContext.clientRect));

				logprintf("Menu item %d %s\n", LOWORD(wParam), convertMenuToString(myContext.currentMenu));

				GuiCallback_t myCallback = (GuiCallback_t)GetWindowLong(aWindow, 0);
				if (myCallback) {
					myCallback(&myContext);					
				}
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
	case WM_LBUTTONDOWN:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_L_DOWN);
		break;
	case WM_LBUTTONUP:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_L_UP);
		break;
	case WM_LBUTTONDBLCLK:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_L_DCLK);
		break;
	case WM_MBUTTONDOWN:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_M_DOWN);
		break;
	case WM_MBUTTONUP:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_M_UP);
		break;
	case WM_MBUTTONDBLCLK:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_M_DCLK);
		break;
	case WM_RBUTTONDOWN:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_R_DOWN);
		break;
	case WM_RBUTTONUP:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_R_UP);
		break;
	case WM_RBUTTONDBLCLK:
		sendEvent(&myContext, aWindow, GUI_EVENT_MOUSE_R_DCLK);
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
