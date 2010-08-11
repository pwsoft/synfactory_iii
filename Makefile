
M4=m4
GCC=$(PREFIX)gcc
WINDRES=$(PREFIX)windres
STRIP=$(PREFIX)strip
OUTPUT_NAME=synfactory_iii.exe
CPPFLAGS=-O3 -Wall -Wextra -Wswitch-default -Wundef -Wshadow -Wpointer-arith -Wcast-align -Wwrite-strings -Wpadded -Winline -fomit-frame-pointer -fno-rtti -fno-exceptions

all: $(OUTPUT_NAME)

$(OUTPUT_NAME): *.m4 synfactory_res.o
	$(M4) synfactory.m4 >synfactory_iii.cpp
	$(GCC) $(CPPFLAGS) -o $(OUTPUT_NAME) -mwindows -mno-cygwin synfactory_res.o synfactory_iii.cpp
	$(STRIP) $(OUTPUT_NAME)

synfactory_res.o: synfactory.rc resource.h
	$(WINDRES) synfactory.rc $@ 

clean:
	rm -f *.o
	rm -f $(OUTPUT_NAME)
