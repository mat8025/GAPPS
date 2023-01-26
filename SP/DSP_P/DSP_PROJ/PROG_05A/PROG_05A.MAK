# Microsoft Developer Studio Generated NMAKE File, Based on prog_05a.dsp
!IF "$(CFG)" == ""
CFG=prog_05a - Win32 Debug
!MESSAGE No configuration specified. Defaulting to prog_05a - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "prog_05a - Win32 Release" && "$(CFG)" !=\
 "prog_05a - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "prog_05a.mak" CFG="prog_05a - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "prog_05a - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "prog_05a - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "prog_05a - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_05a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_05a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\anlgfilt.obj"
	-@erase "$(INTDIR)\bessfunc.obj"
	-@erase "$(INTDIR)\buttfunc.obj"
	-@erase "$(INTDIR)\chebfunc.obj"
	-@erase "$(INTDIR)\cmpxpoly.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\elipfunc.obj"
	-@erase "$(INTDIR)\filtfunc.obj"
	-@erase "$(INTDIR)\impresp.obj"
	-@erase "$(INTDIR)\laguerre.obj"
	-@erase "$(INTDIR)\numinteg.obj"
	-@erase "$(INTDIR)\pause.obj"
	-@erase "$(INTDIR)\polefilt.obj"
	-@erase "$(INTDIR)\poly.obj"
	-@erase "$(INTDIR)\prog_05a.obj"
	-@erase "$(INTDIR)\pzfilt.obj"
	-@erase "$(INTDIR)\stepresp.obj"
	-@erase "$(INTDIR)\unwrap.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\prog_05a.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\prog_05a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_05a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\prog_05a.pdb" /machine:I386 /out:"$(OUTDIR)\prog_05a.exe" 
LINK32_OBJS= \
	"$(INTDIR)\anlgfilt.obj" \
	"$(INTDIR)\bessfunc.obj" \
	"$(INTDIR)\buttfunc.obj" \
	"$(INTDIR)\chebfunc.obj" \
	"$(INTDIR)\cmpxpoly.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\elipfunc.obj" \
	"$(INTDIR)\filtfunc.obj" \
	"$(INTDIR)\impresp.obj" \
	"$(INTDIR)\laguerre.obj" \
	"$(INTDIR)\numinteg.obj" \
	"$(INTDIR)\pause.obj" \
	"$(INTDIR)\polefilt.obj" \
	"$(INTDIR)\poly.obj" \
	"$(INTDIR)\prog_05a.obj" \
	"$(INTDIR)\pzfilt.obj" \
	"$(INTDIR)\stepresp.obj" \
	"$(INTDIR)\unwrap.obj"

"$(OUTDIR)\prog_05a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_05a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_05a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\anlgfilt.obj"
	-@erase "$(INTDIR)\bessfunc.obj"
	-@erase "$(INTDIR)\buttfunc.obj"
	-@erase "$(INTDIR)\chebfunc.obj"
	-@erase "$(INTDIR)\cmpxpoly.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\elipfunc.obj"
	-@erase "$(INTDIR)\filtfunc.obj"
	-@erase "$(INTDIR)\impresp.obj"
	-@erase "$(INTDIR)\laguerre.obj"
	-@erase "$(INTDIR)\numinteg.obj"
	-@erase "$(INTDIR)\pause.obj"
	-@erase "$(INTDIR)\polefilt.obj"
	-@erase "$(INTDIR)\poly.obj"
	-@erase "$(INTDIR)\prog_05a.obj"
	-@erase "$(INTDIR)\pzfilt.obj"
	-@erase "$(INTDIR)\stepresp.obj"
	-@erase "$(INTDIR)\unwrap.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\prog_05a.exe"
	-@erase "$(OUTDIR)\prog_05a.ilk"
	-@erase "$(OUTDIR)\prog_05a.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\prog_05a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_05a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\prog_05a.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\prog_05a.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\anlgfilt.obj" \
	"$(INTDIR)\bessfunc.obj" \
	"$(INTDIR)\buttfunc.obj" \
	"$(INTDIR)\chebfunc.obj" \
	"$(INTDIR)\cmpxpoly.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\elipfunc.obj" \
	"$(INTDIR)\filtfunc.obj" \
	"$(INTDIR)\impresp.obj" \
	"$(INTDIR)\laguerre.obj" \
	"$(INTDIR)\numinteg.obj" \
	"$(INTDIR)\pause.obj" \
	"$(INTDIR)\polefilt.obj" \
	"$(INTDIR)\poly.obj" \
	"$(INTDIR)\prog_05a.obj" \
	"$(INTDIR)\pzfilt.obj" \
	"$(INTDIR)\stepresp.obj" \
	"$(INTDIR)\unwrap.obj"

"$(OUTDIR)\prog_05a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<


!IF "$(CFG)" == "prog_05a - Win32 Release" || "$(CFG)" ==\
 "prog_05a - Win32 Debug"
SOURCE=..\sources\anlgfilt.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_ANLGF=\
	{$(INCLUDE)}"anlgfilt.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"numinteg.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\anlgfilt.obj" : $(SOURCE) $(DEP_CPP_ANLGF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_ANLGF=\
	{$(INCLUDE)}"anlgfilt.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"numinteg.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\anlgfilt.obj" : $(SOURCE) $(DEP_CPP_ANLGF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\bessfunc.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_BESSF=\
	{$(INCLUDE)}"bessfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"elipfunc.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"laguerre.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\bessfunc.obj" : $(SOURCE) $(DEP_CPP_BESSF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_BESSF=\
	{$(INCLUDE)}"bessfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"elipfunc.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"laguerre.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\bessfunc.obj" : $(SOURCE) $(DEP_CPP_BESSF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\buttfunc.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_BUTTF=\
	{$(INCLUDE)}"buttfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\buttfunc.obj" : $(SOURCE) $(DEP_CPP_BUTTF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_BUTTF=\
	{$(INCLUDE)}"buttfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\buttfunc.obj" : $(SOURCE) $(DEP_CPP_BUTTF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\chebfunc.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_CHEBF=\
	{$(INCLUDE)}"chebfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\chebfunc.obj" : $(SOURCE) $(DEP_CPP_CHEBF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_CHEBF=\
	{$(INCLUDE)}"chebfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\chebfunc.obj" : $(SOURCE) $(DEP_CPP_CHEBF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\cmpxpoly.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_CMPXP=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	{$(INCLUDE)}"pause.h"\
	

"$(INTDIR)\cmpxpoly.obj" : $(SOURCE) $(DEP_CPP_CMPXP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_CMPXP=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	{$(INCLUDE)}"pause.h"\
	

"$(INTDIR)\cmpxpoly.obj" : $(SOURCE) $(DEP_CPP_CMPXP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\complex.cpp
DEP_CPP_COMPL=\
	{$(INCLUDE)}"complex.h"\
	

"$(INTDIR)\complex.obj" : $(SOURCE) $(DEP_CPP_COMPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\elipfunc.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_ELIPF=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"elipfunc.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\elipfunc.obj" : $(SOURCE) $(DEP_CPP_ELIPF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_ELIPF=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"elipfunc.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\elipfunc.obj" : $(SOURCE) $(DEP_CPP_ELIPF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\filtfunc.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_FILTF=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unwrap.h"\
	

"$(INTDIR)\filtfunc.obj" : $(SOURCE) $(DEP_CPP_FILTF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_FILTF=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unwrap.h"\
	

"$(INTDIR)\filtfunc.obj" : $(SOURCE) $(DEP_CPP_FILTF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\impresp.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_IMPRE=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"impresp.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\impresp.obj" : $(SOURCE) $(DEP_CPP_IMPRE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_IMPRE=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"impresp.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\impresp.obj" : $(SOURCE) $(DEP_CPP_IMPRE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\laguerre.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_LAGUE=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	

"$(INTDIR)\laguerre.obj" : $(SOURCE) $(DEP_CPP_LAGUE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_LAGUE=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	

"$(INTDIR)\laguerre.obj" : $(SOURCE) $(DEP_CPP_LAGUE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\numinteg.cpp
DEP_CPP_NUMIN=\
	{$(INCLUDE)}"numinteg.h"\
	

"$(INTDIR)\numinteg.obj" : $(SOURCE) $(DEP_CPP_NUMIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\pause.cpp

"$(INTDIR)\pause.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\polefilt.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_POLEF=\
	{$(INCLUDE)}"anlgfilt.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"numinteg.h"\
	{$(INCLUDE)}"polefilt.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\polefilt.obj" : $(SOURCE) $(DEP_CPP_POLEF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_POLEF=\
	{$(INCLUDE)}"anlgfilt.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"numinteg.h"\
	{$(INCLUDE)}"polefilt.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\polefilt.obj" : $(SOURCE) $(DEP_CPP_POLEF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\poly.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_POLY_=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\poly.obj" : $(SOURCE) $(DEP_CPP_POLY_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_POLY_=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\poly.obj" : $(SOURCE) $(DEP_CPP_POLY_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\prog_05a.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"anlgfilt.h"\
	{$(INCLUDE)}"bessfunc.h"\
	{$(INCLUDE)}"buttfunc.h"\
	{$(INCLUDE)}"chebfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"elipfunc.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"impresp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"numinteg.h"\
	{$(INCLUDE)}"polefilt.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"pzfilt.h"\
	{$(INCLUDE)}"stepresp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\prog_05a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"anlgfilt.h"\
	{$(INCLUDE)}"bessfunc.h"\
	{$(INCLUDE)}"buttfunc.h"\
	{$(INCLUDE)}"chebfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"elipfunc.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"impresp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"numinteg.h"\
	{$(INCLUDE)}"polefilt.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"pzfilt.h"\
	{$(INCLUDE)}"stepresp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\prog_05a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\pzfilt.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_PZFIL=\
	{$(INCLUDE)}"anlgfilt.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"numinteg.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"pzfilt.h"\
	

"$(INTDIR)\pzfilt.obj" : $(SOURCE) $(DEP_CPP_PZFIL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_PZFIL=\
	{$(INCLUDE)}"anlgfilt.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"numinteg.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"pzfilt.h"\
	

"$(INTDIR)\pzfilt.obj" : $(SOURCE) $(DEP_CPP_PZFIL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\stepresp.cpp

!IF  "$(CFG)" == "prog_05a - Win32 Release"

DEP_CPP_STEPR=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"impresp.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"stepresp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\stepresp.obj" : $(SOURCE) $(DEP_CPP_STEPR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_05a - Win32 Debug"

DEP_CPP_STEPR=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"impresp.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"stepresp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\stepresp.obj" : $(SOURCE) $(DEP_CPP_STEPR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\unwrap.cpp
DEP_CPP_UNWRA=\
	{$(INCLUDE)}"unwrap.h"\
	

"$(INTDIR)\unwrap.obj" : $(SOURCE) $(DEP_CPP_UNWRA) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

