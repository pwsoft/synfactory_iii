
define([window],[
	var([static HWND $1;])
	var([static bool $1Refresh;])
	init([//TODO: create window $1])
	term([DestroyWindow($1);])
	MacroBack([__eventloop],[if ($1Refresh) {
	(void)InvalidateRect($1, (RECT *)NULL, FALSE);
	$1Refresh=false;
}])
])