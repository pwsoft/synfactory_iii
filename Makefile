
synfactory: *.m4
	m4 synfactory.m4 >synfactory.cpp
	gcc -O3 -Wall -Wextra -o synfactory -mwindows -mno-cygwin synfactory.cpp
	strip synfactory.exe


