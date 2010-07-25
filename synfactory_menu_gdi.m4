module([menu (gdi)])

define([DefMenu],[code6([block([Menu])][
static HMENU $1(void) {
	HMENU menu = CreateMenu();
indent(1,$2)
	return menu;
}])])

define([DefSubMenu],[{
HMENU topmenu = menu;
HMENU menu = CreatePopupMenu();
$2
AppendMenu(topmenu, MF_POPUP, (UINT)menu, "$1");
}])

define([DefMenuItem],[AppendMenu(menu, MF_STRING, $2, "$1");])

define([DefMenuSeparator],[AppendMenu(menu, MF_SEPARATOR, 0, NULL);])

