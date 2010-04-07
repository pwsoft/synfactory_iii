
synfactory: *.m4
	m4 synfactory.m4 >synfactory_iii.cpp
	gcc -O3 -Wall -Wextra -o synfactory_iii -mwindows -mno-cygwin synfactory_iii.cpp
	strip synfactory_iii.exe


