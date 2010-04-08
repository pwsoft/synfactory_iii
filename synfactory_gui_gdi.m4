module([GUI (gdi)])

define([window],[
	Var([static HWND $1;])
	Var([static bool $1Refresh;])
	Init([//TODO: create window $1])
	Term([DestroyWindow($1);])
	MacroBack([__eventloop],[if ($1Refresh) {
	(void)InvalidateRect($1, (RECT *)NULL, FALSE);
	$1Refresh=false;
}])
])