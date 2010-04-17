module([main (win32)])

Var([static bool theQuitFlag = false;])

#
# The eventloop
#
code9([block([Event loop])[
static void eventloop(void) {
	while (!theQuitFlag) {
		MSG myMsg;
		switch (GetMessage(&myMsg,NULL,0,0)) {
		case FALSE:
			theQuitFlag = true;
			break;
		case TRUE:
			TranslateMessage(&myMsg);
			DispatchMessage(&myMsg);
]
indent(3,__eventloop)[
			break;
		default:
			theQuitFlag = true;
			break;
		}
	}
}
]])

#
# Main
#
code9([block([Main])
[int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR szCmdLine, int iCmdShow) {
	theInstance = hInstance;]
[// int main(int argc, char **argv) {]
indent(1,__init)
[	SetMenu(theMainWindow, generateMainMenu());]
[	eventloop();]
indent(1,__term)
[	return 0;
}]
])
