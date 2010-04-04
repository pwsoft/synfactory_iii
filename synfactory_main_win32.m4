module([main])

#
# The eventloop
#
code9([block([Event loop])
[void eventloop(void) {]
__eventloop
[}]
])

#
# Main
#
code9([block([Main])
[int main(int argc, char **argv) {]
__init[]
/* [    eventloop();] */
__term[]
[    return 0;
}]
])
