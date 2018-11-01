.PHONY: default
default: all ;

CC        := g++
SRCDIR    := src
BUILDDIR  := build
LIBRARY   := libParallelRNG.so
STATICLIB := libParallelRNG.a
TARGETDIR := bin
LIBDIR    := lib
TESTDIR   := testing

SRCEXT   := cpp
SOURCES  := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS  := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
OBJECTS_ := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
#CFLAGS   := -std=c++17 -O3 -fPIC -fopenmp # -Wall
CFLAGS   := -std=c++11 -g3 -fPIC -fopenmp # -Wall
SO_FLAGS := -shared
INC      := -I include

library: $(LIBDIR)/$(LIBRARY)

all: $(LIBDIR)/$(LIBRARY)

static: $(LIBDIR)/$(STATICLIB)

$(LIBDIR)/$(STATICLIB) : $(OBJECTS_)
	@mkdir -p $(LIBDIR)
	@ar rsv $@ $^

install: all
	cp lib/$(LIBRARY) /usr/lib/
	cp -R include /usr/include/ParallelRNG

#testing: $(LIBDIR)/$(LIBRARY)
#	@mkdir -p $(TARGETDIR)
#	@echo " $(CC) $(CFLAGS) $(INC) $(TESTDIR)/FunctionNetwork.cpp -o bin/FunctionNetwork -L$(LIBDIR) -lFunctionalAP"
#	$(CC) $(CFLAGS) $(INC) $(TESTDIR)/FunctionNetwork.cpp -o bin/FunctionNetwork -L$(LIBDIR) -lFunctionalAP

$(LIBDIR)/$(LIBRARY): $(OBJECTS)
	@mkdir -p $(LIBDIR)
	$(CC) $(SO_FLAGS) -Wl,-soname,$(LIBRARY) -o $@ $^ -lc

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@echo " $(CC) $(CFLAGS) $(INC) -c -o $@ $<"
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<

clean:
	@echo " Cleaning...";
	@echo " $(RM) -r $(BUILDDIR) $(LIBDIR) $(TARGETDIR)"
	$(RM) -r $(BUILDDIR) $(LIBDIR) $(TARGETDIR)
