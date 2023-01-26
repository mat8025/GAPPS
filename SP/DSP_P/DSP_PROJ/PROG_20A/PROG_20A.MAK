# Microsoft Developer Studio Generated NMAKE File, Based on prog_20a.dsp
!IF "$(CFG)" == ""
CFG=prog_20a - Win32 Debug
!MESSAGE No configuration specified. Defaulting to prog_20a - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "prog_20a - Win32 Release" && "$(CFG)" !=\
 "prog_20a - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "prog_20a.mak" CFG="prog_20a - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "prog_20a - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "prog_20a - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "prog_20a - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_20a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_20a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\abstmath.obj"
	-@erase "$(INTDIR)\filtmath.obj"
	-@erase "$(INTDIR)\msdcost.obj"
	-@erase "$(INTDIR)\prog_20a.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\prog_20a.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\prog_20a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_20a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\prog_20a.pdb" /machine:I386 /out:"$(OUTDIR)\prog_20a.exe" 
LINK32_OBJS= \
	"$(INTDIR)\abstmath.obj" \
	"$(INTDIR)\filtmath.obj" \
	"$(INTDIR)\msdcost.obj" \
	"$(INTDIR)\prog_20a.obj"

"$(OUTDIR)\prog_20a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "prog_20a - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_20a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_20a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\abstmath.obj"
	-@erase "$(INTDIR)\filtmath.obj"
	-@erase "$(INTDIR)\msdcost.obj"
	-@erase "$(INTDIR)\prog_20a.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\prog_20a.exe"
	-@erase "$(OUTDIR)\prog_20a.ilk"
	-@erase "$(OUTDIR)\prog_20a.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\prog_20a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_20a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\prog_20a.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\prog_20a.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\abstmath.obj" \
	"$(INTDIR)\filtmath.obj" \
	"$(INTDIR)\msdcost.obj" \
	"$(INTDIR)\prog_20a.obj"

"$(OUTDIR)\prog_20a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "prog_20a - Win32 Release" || "$(CFG)" ==\
 "prog_20a - Win32 Debug"
SOURCE=..\sources\abstmath.cpp

!IF  "$(CFG)" == "prog_20a - Win32 Release"

DEP_CPP_ABSTM=\
	{$(INCLUDE)}"abstmath.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\abstmath.obj" : $(SOURCE) $(DEP_CPP_ABSTM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20a - Win32 Debug"

DEP_CPP_ABSTM=\
	{$(INCLUDE)}"abstmath.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\abstmath.obj" : $(SOURCE) $(DEP_CPP_ABSTM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\filtmath.cpp

!IF  "$(CFG)" == "prog_20a - Win32 Release"

DEP_CPP_FILTM=\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\filtmath.obj" : $(SOURCE) $(DEP_CPP_FILTM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20a - Win32 Debug"

DEP_CPP_FILTM=\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\filtmath.obj" : $(SOURCE) $(DEP_CPP_FILTM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\msdcost.cpp
DEP_CPP_MSDCO=\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"msdcost.h"\
	

"$(INTDIR)\msdcost.obj" : $(SOURCE) $(DEP_CPP_MSDCO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\prog_20a.cpp

!IF  "$(CFG)" == "prog_20a - Win32 Release"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"abstmath.h"\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"msdcost.h"\
	

"$(INTDIR)\prog_20a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20a - Win32 Debug"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"abstmath.h"\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"msdcost.h"\
	

"$(INTDIR)\prog_20a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

