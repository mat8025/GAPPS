

  makefile  for compiling asc files to cpp exe uses susbet of asl libs
  the asc file is produced by translating the asl file via the asl -T foo.asl option to produce foo.asc

  asl can use a subset of C++ syntax

  then g++ operates on the asc files to produce C++ exe

navi: navi.asc
	g++ -x c++ -fpermissive  -rdynamic -o navi navi.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

use
 ASL_CPP
to redefine ASL, CPP flags in asl file

 use makeasc
 make -f ~/gapps/LIB/aslmake TAR=$1


g++ -x c++  -g -fpermissive  -rdynamic -o $(TAR) $(TAR).asc  -DMYFILE=\"$(TAR).asc\" -I$(gasp_sys)/include -ldl  $(LDADD)
