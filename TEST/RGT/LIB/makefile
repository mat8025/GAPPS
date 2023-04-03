# Makefile for rgt task code

       

noinst_LIBRARIES = librgt_asl.a


EXTRA_DIST = README.txt
             

CC = g++

SRCS = rgt_table.cpp 

OBJS = rgt_table.o 






libname = rgt_asl


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



