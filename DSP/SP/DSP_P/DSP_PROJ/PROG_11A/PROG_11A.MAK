# Microsoft Developer Studio Generated NMAKE File, Based on prog_11a.dsp
!IF "$(CFG)" == ""
CFG=prog_11a - Win32 Debug
!MESSAGE No configuration specified. Defaulting to prog_11a - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "prog_11a - Win32 Release" && "$(CFG)" !=\
 "prog_11a - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "prog_11a.mak" CFG="prog_11a - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "prog_11a - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "prog_11a - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "prog_11a - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_11a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_11a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\fir_dsgn.obj"
	-@erase "$(INTDIR)\fir_resp.obj"
	-@erase "$(INTDIR)\firideal.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\lin_dsgn.obj"
	-@erase "$(INTDIR)\lin_resp.obj"
	-@erase "$(INTDIR)\prog_11a.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\prog_11a.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\prog_11a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_11a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\prog_11a.pdb" /machine:I386 /out:"$(OUTDIR)\prog_11a.exe" 
LINK32_OBJS= \
	"$(INTDIR)\fir_dsgn.obj" \
	"$(INTDIR)\fir_resp.obj" \
	"$(INTDIR)\firideal.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\lin_dsgn.obj" \
	"$(INTDIR)\lin_resp.obj" \
	"$(INTDIR)\prog_11a.obj"

"$(OUTDIR)\prog_11a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "prog_11a - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_11a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_11a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\fir_dsgn.obj"
	-@erase "$(INTDIR)\fir_resp.obj"
	-@erase "$(INTDIR)\firideal.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\lin_dsgn.obj"
	-@erase "$(INTDIR)\lin_resp.obj"
	-@erase "$(INTDIR)\prog_11a.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\prog_11a.exe"
	-@erase "$(OUTDIR)\prog_11a.ilk"
	-@erase "$(OUTDIR)\prog_11a.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\prog_11a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_11a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\prog_11a.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\prog_11a.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\fir_dsgn.obj" \
	"$(INTDIR)\fir_resp.obj" \
	"$(INTDIR)\firideal.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\lin_dsgn.obj" \
	"$(INTDIR)\lin_resp.obj" \
	"$(INTDIR)\prog_11a.obj"

"$(OUTDIR)\prog_11a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "prog_11a - Win32 Release" || "$(CFG)" ==\
 "prog_11a - Win32 Debug"
SOURCE=..\sources\fir_dsgn.cpp

!IF  "$(CFG)" == "prog_11a - Win32 Release"

DEP_CPP_FIR_D=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fir_dsgn.obj" : $(SOURCE) $(DEP_CPP_FIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_11a - Win32 Debug"

DEP_CPP_FIR_D=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fir_dsgn.obj" : $(SOURCE) $(DEP_CPP_FIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fir_resp.cpp

!IF  "$(CFG)" == "prog_11a - Win32 Release"

DEP_CPP_FIR_R=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fir_resp.obj" : $(SOURCE) $(DEP_CPP_FIR_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_11a - Win32 Debug"

DEP_CPP_FIR_R=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fir_resp.obj" : $(SOURCE) $(DEP_CPP_FIR_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\firideal.cpp

!IF  "$(CFG)" == "prog_11a - Win32 Release"

DEP_CPP_FIRID=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"firideal.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"lin_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\firideal.obj" : $(SOURCE) $(DEP_CPP_FIRID) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_11a - Win32 Debug"

DEP_CPP_FIRID=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"firideal.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"lin_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\firideal.obj" : $(SOURCE) $(DEP_CPP_FIRID) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gen_win.cpp
DEP_CPP_GEN_W=\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\gen_win.obj" : $(SOURCE) $(DEP_CPP_GEN_W) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\lin_dsgn.cpp

!IF  "$(CFG)" == "prog_11a - Win32 Release"

DEP_CPP_LIN_D=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"lin_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\lin_dsgn.obj" : $(SOURCE) $(DEP_CPP_LIN_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_11a - Win32 Debug"

DEP_CPP_LIN_D=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"lin_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\lin_dsgn.obj" : $(SOURCE) $(DEP_CPP_LIN_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\lin_resp.cpp

!IF  "$(CFG)" == "prog_11a - Win32 Release"

DEP_CPP_LIN_R=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"lin_dsgn.h"\
	{$(INCLUDE)}"lin_resp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\lin_resp.obj" : $(SOURCE) $(DEP_CPP_LIN_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_11a - Win32 Debug"

DEP_CPP_LIN_R=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"lin_dsgn.h"\
	{$(INCLUDE)}"lin_resp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\lin_resp.obj" : $(SOURCE) $(DEP_CPP_LIN_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\prog_11a.cpp

!IF  "$(CFG)" == "prog_11a - Win32 Release"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"firideal.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"lin_dsgn.h"\
	{$(INCLUDE)}"lin_resp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\prog_11a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_11a - Win32 Debug"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"firideal.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"lin_dsgn.h"\
	{$(INCLUDE)}"lin_resp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\prog_11a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

