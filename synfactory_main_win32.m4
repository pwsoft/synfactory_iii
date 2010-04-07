module([main])
var([static bool theQuitFlag = false;])

#
# The eventloop
#
code9([block([Event loop])
[void eventloop(void) {
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
indent(3,[__eventloop])
[			break;
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
[int main(int argc, char **argv) {]
indent(1,[__init])
/* [    eventloop();] */
indent(1,[__term])
[    return 0;
}]
])
