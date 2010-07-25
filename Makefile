
synfactory: *.m4 synfactory_res.o
	m4 synfactory.m4 >synfactory_iii.cpp
	gcc -O3 -Wall -Wextra -Wswitch-default -Wundef -Wshadow -Wpointer-arith -Wcast-align -Wwrite-strings -Wpadded -Winline -fomit-frame-pointer -fno-rtti -fno-exceptions -o synfactory_iii -mwindows -mno-cygwin synfactory_res.o synfactory_iii.cpp
	strip synfactory_iii.exe

synfactory_res.o: synfactory.rc resource.h
	windres synfactory.rc synfactory_res.o

