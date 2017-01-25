# Microsoft Developer Studio Generated NMAKE File, Based on ex27_02.dsp
!IF "$(CFG)" == ""
CFG=ex27_02 - Win32 Debug
!MESSAGE No configuration specified. Defaulting to ex27_02 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "ex27_02 - Win32 Release" && "$(CFG)" !=\
 "ex27_02 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ex27_02.mak" CFG="ex27_02 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ex27_02 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ex27_02 - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "ex27_02 - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex27_02.exe"

!ELSE 

ALL : "$(OUTDIR)\ex27_02.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\bitrev.obj"
	-@erase "$(INTDIR)\cbitrev.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\dit_sino.obj"
	-@erase "$(INTDIR)\ex27_02.obj"
	-@erase "$(INTDIR)\fft.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\hamming.obj"
	-@erase "$(INTDIR)\log2.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\ex27_02.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\ex27_02.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c\
 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex27_02.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\ex27_02.pdb" /machine:I386 /out:"$(OUTDIR)\ex27_02.exe" 
LINK32_OBJS= \
	"$(INTDIR)\bitrev.obj" \
	"$(INTDIR)\cbitrev.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\dit_sino.obj" \
	"$(INTDIR)\ex27_02.obj" \
	"$(INTDIR)\fft.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\hamming.obj" \
	"$(INTDIR)\log2.obj"

"$(OUTDIR)\ex27_02.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "ex27_02 - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex27_02.exe"

!ELSE 

ALL : "$(OUTDIR)\ex27_02.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\bitrev.obj"
	-@erase "$(INTDIR)\cbitrev.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\dit_sino.obj"
	-@erase "$(INTDIR)\ex27_02.obj"
	-@erase "$(INTDIR)\fft.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\hamming.obj"
	-@erase "$(INTDIR)\log2.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\ex27_02.exe"
	-@erase "$(OUTDIR)\ex27_02.ilk"
	-@erase "$(OUTDIR)\ex27_02.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\ex27_02.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex27_02.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\ex27_02.pdb" /debug /machine:I386 /out:"$(OUTDIR)\ex27_02.exe"\
 /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\bitrev.obj" \
	"$(INTDIR)\cbitrev.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\dit_sino.obj" \
	"$(INTDIR)\ex27_02.obj" \
	"$(INTDIR)\fft.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\hamming.obj" \
	"$(INTDIR)\log2.obj"

"$(OUTDIR)\ex27_02.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "ex27_02 - Win32 Release" || "$(CFG)" ==\
 "ex27_02 - Win32 Debug"
SOURCE=..\sources\bitrev.cpp
DEP_CPP_BITRE=\
	{$(INCLUDE)}"bitrev.h"\
	

"$(INTDIR)\bitrev.obj" : $(SOURCE) $(DEP_CPP_BITRE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\cbitrev.cpp
DEP_CPP_CBITR=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	

"$(INTDIR)\cbitrev.obj" : $(SOURCE) $(DEP_CPP_CBITR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\complex.cpp
DEP_CPP_COMPL=\
	{$(INCLUDE)}"complex.h"\
	

"$(INTDIR)\complex.obj" : $(SOURCE) $(DEP_CPP_COMPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\dit_sino.cpp

!IF  "$(CFG)" == "ex27_02 - Win32 Release"

DEP_CPP_DIT_S=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"log2.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\dit_sino.obj" : $(SOURCE) $(DEP_CPP_DIT_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex27_02 - Win32 Debug"

DEP_CPP_DIT_S=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"log2.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\dit_sino.obj" : $(SOURCE) $(DEP_CPP_DIT_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ex27_02.cpp

!IF  "$(CFG)" == "ex27_02 - Win32 Release"

DEP_CPP_EX27_=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"hamming.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\ex27_02.obj" : $(SOURCE) $(DEP_CPP_EX27_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex27_02 - Win32 Debug"

DEP_CPP_EX27_=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"hamming.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\ex27_02.obj" : $(SOURCE) $(DEP_CPP_EX27_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fft.cpp

!IF  "$(CFG)" == "ex27_02 - Win32 Release"

DEP_CPP_FFT_C=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"fft.h"\
	

"$(INTDIR)\fft.obj" : $(SOURCE) $(DEP_CPP_FFT_C) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex27_02 - Win32 Debug"

DEP_CPP_FFT_C=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"fft.h"\
	

"$(INTDIR)\fft.obj" : $(SOURCE) $(DEP_CPP_FFT_C) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gen_win.cpp
DEP_CPP_GEN_W=\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\gen_win.obj" : $(SOURCE) $(DEP_CPP_GEN_W) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\hamming.cpp

!IF  "$(CFG)" == "ex27_02 - Win32 Release"

DEP_CPP_HAMMI=\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"hamming.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\hamming.obj" : $(SOURCE) $(DEP_CPP_HAMMI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex27_02 - Win32 Debug"

DEP_CPP_HAMMI=\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"hamming.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\hamming.obj" : $(SOURCE) $(DEP_CPP_HAMMI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\log2.cpp
DEP_CPP_LOG2_=\
	{$(INCLUDE)}"log2.h"\
	

"$(INTDIR)\log2.obj" : $(SOURCE) $(DEP_CPP_LOG2_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

