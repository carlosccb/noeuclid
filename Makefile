all: noeuclid


SRCS=$(wildcard *.cpp)
OBJS=$(subst .cpp,.o,$(SRCS))

OS:=$(shell uname)

LDFLAGS:=$(LDFLAGS) -lsfml-graphics -lsfml-window -lsfml-system
CXXFLAGS:=$(CXXFLAGS) -std=c++11 -DGLEW_STATIC -DGL_GLEXT_PROTOTYPES -g -Wall -O2
LDFLAGS:=$(LDFLAGS) -g -Wall
LINK.o = $(LINK.cc)

ifeq ($(OS),Darwin)
  LDFLAGS:=$(LDFLAGS) -I/usr/local/include/ -L /usr/local/lib/
  CXXFLAGS:=$(CXXFLAGS) -I/usr/local/include/
  LDLIBS:=$(LDFLAGS) $(LDLIBS) -framework GLUT -framework OpenGL -framework Cocoa -lGLEW -ltcc -ldl
else
  LDLIBS:=$(LDFLAGS) $(LDLIBS) -lGLEW -lGLU -lGL -ltcc -ldl
endif

WINCXXFLAGS:=-DGLEXT -std=c++11 -g -O2 -IWindows -IWindows/SFML-2.2/include -DGLEW_STATIC  -DDrawText=DrawText
WINLDFL:=Windows/libtcc.a -LWindows/SFML-2.2/lib -lglew -lsfml-graphics -lsfml-window -lsfml-system -lopengl32 -lkernel32 -lm -lgdiplus -lole32 -lglu32 -lopengl32  ./libtcc1.a
noeuclid.exe : $(SRCS) Windows/SFML-2.2	
	i686-w64-mingw32-g++ -m32 $(WINCXXFLAGS) -o $@ $(SRCS) $(WINLDFL)

Windows/SFML-2.2:
	cd Windows
	wget http://www.sfml-dev.org/files/SFML-2.2-windows-gcc-4.9.2-mingw-32-bit.zip
	unzip SFML-2.2-windows-gcc-4.9.2-mingw-32-bit.zip
	cd ..


noeuclid: $(OBJS)

clean:
	rm -f $(OBJS) noeuclid noeuclid.exe
