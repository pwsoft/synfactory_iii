module([GUI (gdi)])

Const([static const char * const mainWindowClass="StudioFactoryMainClass";])
Var([static HINSTANCE theInstance;])
Var([static ATOM mainClassAtom;])

define([window],[
	Var([static HWND $1;])
	Var([static bool $1Refresh;])
	Init([$1 = CreateWindowEx(WS_EX_TOOLWINDOW, mainWindowClass, $2, WS_VISIBLE | WS_SYSMENU | WS_CLIPCHILDREN | WS_OVERLAPPED | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_VSCROLL, CW_USEDEFAULT, CW_USEDEFAULT, 400, 400, theMainWindow, NULL, theInstance, NULL);])
	Init([UpdateWindow($1);])
	Term([DestroyWindow($1);])
	MacroBack([__eventloop],[if ($1Refresh) {
	(void)InvalidateRect($1, (RECT *)NULL, FALSE);
	$1Refresh=false;
}])
])

code8([[
static LRESULT CALLBACK stdWindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	switch(uMsg) {
	case WM_PAINT: {
			PAINTSTRUCT ps;
			HDC hdc=BeginPaint(hwnd, &ps);
			RECT myClientRect;
			GetClientRect(hwnd, &myClientRect);
			SelectObject(hdc, GetStockObject(BLACK_BRUSH));
			Rectangle(hdc, myClientRect.left, myClientRect.top, myClientRect.right, myClientRect.bottom);


			EndPaint(hwnd, &ps);    

		} break;
	case WM_CLOSE:
		if (hwnd == theMainWindow) {
			PostQuitMessage(0);
		}
		break;
	default:
		return DefWindowProc(hwnd, uMsg, wParam, lParam);
	}
	
	return 0;
}

static void createWindowClass(void) {
	WNDCLASSEX myClass;
	myClass.cbSize=sizeof(myClass);
	myClass.style=CS_DBLCLKS; /* Enable double click processing */
	myClass.lpfnWndProc=stdWindowProc;
	myClass.cbClsExtra=0;
	myClass.cbWndExtra=0;
	myClass.hInstance=theInstance;
	myClass.hIcon=NULL; //LoadIcon(theInstance, MAKEINTRESOURCE(IDI_MAINICON));
	myClass.hCursor=LoadCursor(NULL, IDC_ARROW);
	myClass.hbrBackground=NULL; // (HBRUSH)GetStockObject(GRAY_BRUSH);
	myClass.lpszMenuName=NULL;
	myClass.lpszClassName=mainWindowClass;
	myClass.hIconSm=NULL;
	mainClassAtom=RegisterClassEx(&myClass);
}
]])

Init([createWindowClass();])
