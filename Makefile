
M4=m4
GCC=$(PREFIX)gcc
WINDRES=$(PREFIX)windres
STRIP=$(PREFIX)strip
PROGRAM_NAME=synfactory_iii
OUTPUT_NAME=$(PROGRAM_NAME).exe
MAP_FILE=-Wl,-Map,$(PROGRAM_NAME).map
CPPFLAGS=-O3 -Wall -Wextra -Wswitch-default -Wundef -Wshadow -Wpointer-arith -Wcast-align -Wwrite-strings -Wpadded -Winline -fomit-frame-pointer -fno-rtti -fno-exceptions

all: $(OUTPUT_NAME)

$(OUTPUT_NAME): synfactory_res.o synfactory_iii.cpp
	$(GCC) $(CPPFLAGS) -o $(OUTPUT_NAME) $(MAP_FILE) -mwindows -mno-cygwin synfactory_res.o synfactory_iii.cpp
	$(STRIP) $(OUTPUT_NAME)

synfactory_res.o: synfactory.rc resource.h
	$(WINDRES) synfactory.rc $@ 

synfactory_iii.cpp: *.m4
	$(M4) synfactory.m4 > $@

clean:
	rm -f *.o
	rm -f $(OUTPUT_NAME)
