# Makefile for glide task code

       

noinst_LIBRARIES = libglide_asl.a


EXTRA_DIST = README.txt
             

CC = g++

SRCS = glide_table.cpp glide.cpp

OBJS = glide_table.o glide.o






libname = glide_asl
libnamex = glide_aslx

CFLAGS= -pg -g  -fpermissive

gasp_sys = ~/gasp-CARBON

gslibdir = $(gasp_sys)/lib



AM_CFLAGS =  -fPIC -DPIC -Wall -I/usr/include -I$(gasp_sys) -I. -I../ -I/home/mark/gapps/LIB -I/home/mark/gasp-CARBON/include -c


install : 
	echo $(gasp_sys)
	$(CC) $(CFLAGS) $(AM_CFLAGS) $(SRCS)
	g++  -shared -Wl,-soname,lib$(libname).so.0 -o lib$(libname).so.0.0  $(OBJS)  -lc
	cp lib$(libname).so.0.0 $(gslibdir)
	cd $(gslibdir) && ln -sf lib$(libname).so.0.0 lib$(libname).so.0
	cd $(gslibdir) && ln -sf lib$(libname).so.0 lib$(libname).so



