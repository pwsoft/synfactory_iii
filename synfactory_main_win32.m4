module([main])

#
# The eventloop
#
code9([block([Event loop])
[void eventloop(void) {]
indent(1,[__eventloop])
[}]
])

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
