# Microsoft Developer Studio Generated NMAKE File, Based on prog_20c.dsp
!IF "$(CFG)" == ""
CFG=prog_20c - Win32 Debug
!MESSAGE No configuration specified. Defaulting to prog_20c - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "prog_20c - Win32 Release" && "$(CFG)" !=\
 "prog_20c - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "prog_20c.mak" CFG="prog_20c - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "prog_20c - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "prog_20c - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "prog_20c - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_20c.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_20c.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\anlg_rcn.obj"
	-@erase "$(INTDIR)\croscorr.obj"
	-@erase "$(INTDIR)\dirform1.obj"
	-@erase "$(INTDIR)\filtmath.obj"
	-@erase "$(INTDIR)\fir_dsgn.obj"
	-@erase "$(INTDIR)\fir_resp.obj"
	-@erase "$(INTDIR)\fs_dsgn.obj"
	-@erase "$(INTDIR)\fs_spec.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\mr_lpf.obj"
	-@erase "$(INTDIR)\prog_20c.obj"
	-@erase "$(INTDIR)\remezalg.obj"
	-@erase "$(INTDIR)\sinc.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\prog_20c.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\prog_20c.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_20c.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\prog_20c.pdb" /machine:I386 /out:"$(OUTDIR)\prog_20c.exe" 
LINK32_OBJS= \
	"$(INTDIR)\anlg_rcn.obj" \
	"$(INTDIR)\croscorr.obj" \
	"$(INTDIR)\dirform1.obj" \
	"$(INTDIR)\filtmath.obj" \
	"$(INTDIR)\fir_dsgn.obj" \
	"$(INTDIR)\fir_resp.obj" \
	"$(INTDIR)\fs_dsgn.obj" \
	"$(INTDIR)\fs_spec.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\mr_lpf.obj" \
	"$(INTDIR)\prog_20c.obj" \
	"$(INTDIR)\remezalg.obj" \
	"$(INTDIR)\sinc.obj"

"$(OUTDIR)\prog_20c.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_20c.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_20c.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\anlg_rcn.obj"
	-@erase "$(INTDIR)\croscorr.obj"
	-@erase "$(INTDIR)\dirform1.obj"
	-@erase "$(INTDIR)\filtmath.obj"
	-@erase "$(INTDIR)\fir_dsgn.obj"
	-@erase "$(INTDIR)\fir_resp.obj"
	-@erase "$(INTDIR)\fs_dsgn.obj"
	-@erase "$(INTDIR)\fs_spec.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\mr_lpf.obj"
	-@erase "$(INTDIR)\prog_20c.obj"
	-@erase "$(INTDIR)\remezalg.obj"
	-@erase "$(INTDIR)\sinc.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\prog_20c.exe"
	-@erase "$(OUTDIR)\prog_20c.ilk"
	-@erase "$(OUTDIR)\prog_20c.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\prog_20c.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_20c.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\prog_20c.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\prog_20c.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\anlg_rcn.obj" \
	"$(INTDIR)\croscorr.obj" \
	"$(INTDIR)\dirform1.obj" \
	"$(INTDIR)\filtmath.obj" \
	"$(INTDIR)\fir_dsgn.obj" \
	"$(INTDIR)\fir_resp.obj" \
	"$(INTDIR)\fs_dsgn.obj" \
	"$(INTDIR)\fs_spec.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\mr_lpf.obj" \
	"$(INTDIR)\prog_20c.obj" \
	"$(INTDIR)\remezalg.obj" \
	"$(INTDIR)\sinc.obj"

"$(OUTDIR)\prog_20c.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "prog_20c - Win32 Release" || "$(CFG)" ==\
 "prog_20c - Win32 Debug"
SOURCE=..\sources\anlg_rcn.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_ANLG_=\
	{$(INCLUDE)}"anlg_rcn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sinc.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\anlg_rcn.obj" : $(SOURCE) $(DEP_CPP_ANLG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_ANLG_=\
	{$(INCLUDE)}"anlg_rcn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sinc.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\anlg_rcn.obj" : $(SOURCE) $(DEP_CPP_ANLG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\croscorr.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_CROSC=\
	{$(INCLUDE)}"croscorr.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\croscorr.obj" : $(SOURCE) $(DEP_CPP_CROSC) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_CROSC=\
	{$(INCLUDE)}"croscorr.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\croscorr.obj" : $(SOURCE) $(DEP_CPP_CROSC) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\dirform1.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_DIRFO=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\dirform1.obj" : $(SOURCE) $(DEP_CPP_DIRFO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_DIRFO=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\dirform1.obj" : $(SOURCE) $(DEP_CPP_DIRFO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\filtmath.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_FILTM=\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\filtmath.obj" : $(SOURCE) $(DEP_CPP_FILTM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_FILTM=\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\filtmath.obj" : $(SOURCE) $(DEP_CPP_FILTM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fir_dsgn.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_FIR_D=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fir_dsgn.obj" : $(SOURCE) $(DEP_CPP_FIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

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

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_FIR_R=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fir_resp.obj" : $(SOURCE) $(DEP_CPP_FIR_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

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

SOURCE=..\sources\fs_dsgn.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_FS_DS=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_dsgn.obj" : $(SOURCE) $(DEP_CPP_FS_DS) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_FS_DS=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_dsgn.obj" : $(SOURCE) $(DEP_CPP_FS_DS) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fs_spec.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_FS_SP=\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_spec.obj" : $(SOURCE) $(DEP_CPP_FS_SP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_FS_SP=\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_spec.obj" : $(SOURCE) $(DEP_CPP_FS_SP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gen_win.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_GEN_W=\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\gen_win.obj" : $(SOURCE) $(DEP_CPP_GEN_W) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_GEN_W=\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\gen_win.obj" : $(SOURCE) $(DEP_CPP_GEN_W) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\mr_lpf.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_MR_LP=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"mr_lpf.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\mr_lpf.obj" : $(SOURCE) $(DEP_CPP_MR_LP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_MR_LP=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"mr_lpf.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\mr_lpf.obj" : $(SOURCE) $(DEP_CPP_MR_LP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\prog_20c.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"anlg_rcn.h"\
	{$(INCLUDE)}"croscorr.h"\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"mr_lpf.h"\
	{$(INCLUDE)}"remezalg.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\prog_20c.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"anlg_rcn.h"\
	{$(INCLUDE)}"croscorr.h"\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"filtmath.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"mr_lpf.h"\
	{$(INCLUDE)}"remezalg.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\prog_20c.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\remezalg.cpp

!IF  "$(CFG)" == "prog_20c - Win32 Release"

DEP_CPP_REMEZ=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"remezalg.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\remezalg.obj" : $(SOURCE) $(DEP_CPP_REMEZ) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_20c - Win32 Debug"

DEP_CPP_REMEZ=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"remezalg.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\remezalg.obj" : $(SOURCE) $(DEP_CPP_REMEZ) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\sinc.cpp
DEP_CPP_SINC_=\
	{$(INCLUDE)}"sinc.h"\
	

"$(INTDIR)\sinc.obj" : $(SOURCE) $(DEP_CPP_SINC_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

