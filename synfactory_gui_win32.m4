
define([window],[
	var([static HWND $1;])
	var([static bool $1Refresh;])
	MacroBack([__eventloop],[if ($1Refresh) { (void)InvalidateRect($1, (RECT *)NULL, FALSE); $1Refresh=false; }])
])