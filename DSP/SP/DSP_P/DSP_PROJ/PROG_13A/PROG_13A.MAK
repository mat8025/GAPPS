# Microsoft Developer Studio Generated NMAKE File, Based on prog_13a.dsp
!IF "$(CFG)" == ""
CFG=prog_13a - Win32 Debug
!MESSAGE No configuration specified. Defaulting to prog_13a - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "prog_13a - Win32 Release" && "$(CFG)" !=\
 "prog_13a - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "prog_13a.mak" CFG="prog_13a - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "prog_13a - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "prog_13a - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "prog_13a - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_13a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_13a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\dirform1.obj"
	-@erase "$(INTDIR)\fir_dsgn.obj"
	-@erase "$(INTDIR)\fir_resp.obj"
	-@erase "$(INTDIR)\fs_dsgn.obj"
	-@erase "$(INTDIR)\fs_resp.obj"
	-@erase "$(INTDIR)\fs_spec.obj"
	-@erase "$(INTDIR)\fs_util.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\goldsrch.obj"
	-@erase "$(INTDIR)\goldsrh2.obj"
	-@erase "$(INTDIR)\optmiz2.obj"
	-@erase "$(INTDIR)\prog_13a.obj"
	-@erase "$(INTDIR)\sb_peak.obj"
	-@erase "$(INTDIR)\swept.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\prog_13a.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\prog_13a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_13a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\prog_13a.pdb" /machine:I386 /out:"$(OUTDIR)\prog_13a.exe" 
LINK32_OBJS= \
	"$(INTDIR)\dirform1.obj" \
	"$(INTDIR)\fir_dsgn.obj" \
	"$(INTDIR)\fir_resp.obj" \
	"$(INTDIR)\fs_dsgn.obj" \
	"$(INTDIR)\fs_resp.obj" \
	"$(INTDIR)\fs_spec.obj" \
	"$(INTDIR)\fs_util.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\goldsrch.obj" \
	"$(INTDIR)\goldsrh2.obj" \
	"$(INTDIR)\optmiz2.obj" \
	"$(INTDIR)\prog_13a.obj" \
	"$(INTDIR)\sb_peak.obj" \
	"$(INTDIR)\swept.obj"

"$(OUTDIR)\prog_13a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_13a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_13a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\dirform1.obj"
	-@erase "$(INTDIR)\fir_dsgn.obj"
	-@erase "$(INTDIR)\fir_resp.obj"
	-@erase "$(INTDIR)\fs_dsgn.obj"
	-@erase "$(INTDIR)\fs_resp.obj"
	-@erase "$(INTDIR)\fs_spec.obj"
	-@erase "$(INTDIR)\fs_util.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\goldsrch.obj"
	-@erase "$(INTDIR)\goldsrh2.obj"
	-@erase "$(INTDIR)\optmiz2.obj"
	-@erase "$(INTDIR)\prog_13a.obj"
	-@erase "$(INTDIR)\sb_peak.obj"
	-@erase "$(INTDIR)\swept.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\prog_13a.exe"
	-@erase "$(OUTDIR)\prog_13a.ilk"
	-@erase "$(OUTDIR)\prog_13a.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\prog_13a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_13a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\prog_13a.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\prog_13a.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\dirform1.obj" \
	"$(INTDIR)\fir_dsgn.obj" \
	"$(INTDIR)\fir_resp.obj" \
	"$(INTDIR)\fs_dsgn.obj" \
	"$(INTDIR)\fs_resp.obj" \
	"$(INTDIR)\fs_spec.obj" \
	"$(INTDIR)\fs_util.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\goldsrch.obj" \
	"$(INTDIR)\goldsrh2.obj" \
	"$(INTDIR)\optmiz2.obj" \
	"$(INTDIR)\prog_13a.obj" \
	"$(INTDIR)\sb_peak.obj" \
	"$(INTDIR)\swept.obj"

"$(OUTDIR)\prog_13a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "prog_13a - Win32 Release" || "$(CFG)" ==\
 "prog_13a - Win32 Debug"
SOURCE=..\sources\dirform1.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_DIRFO=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\dirform1.obj" : $(SOURCE) $(DEP_CPP_DIRFO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_DIRFO=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\dirform1.obj" : $(SOURCE) $(DEP_CPP_DIRFO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fir_dsgn.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_FIR_D=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fir_dsgn.obj" : $(SOURCE) $(DEP_CPP_FIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

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

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_FIR_R=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fir_resp.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fir_resp.obj" : $(SOURCE) $(DEP_CPP_FIR_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

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

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_FS_DS=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_dsgn.obj" : $(SOURCE) $(DEP_CPP_FS_DS) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

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

SOURCE=..\sources\fs_resp.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_FS_RE=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_resp.obj" : $(SOURCE) $(DEP_CPP_FS_RE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_FS_RE=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_resp.obj" : $(SOURCE) $(DEP_CPP_FS_RE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fs_spec.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_FS_SP=\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_spec.obj" : $(SOURCE) $(DEP_CPP_FS_SP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_FS_SP=\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_spec.obj" : $(SOURCE) $(DEP_CPP_FS_SP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fs_util.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_FS_UT=\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_util.obj" : $(SOURCE) $(DEP_CPP_FS_UT) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_FS_UT=\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\fs_util.obj" : $(SOURCE) $(DEP_CPP_FS_UT) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gen_win.cpp
DEP_CPP_GEN_W=\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\gen_win.obj" : $(SOURCE) $(DEP_CPP_GEN_W) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\goldsrch.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_GOLDS=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"goldsrch.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sb_peak.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\goldsrch.obj" : $(SOURCE) $(DEP_CPP_GOLDS) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_GOLDS=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"goldsrch.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sb_peak.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\goldsrch.obj" : $(SOURCE) $(DEP_CPP_GOLDS) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\goldsrh2.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_GOLDSR=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"goldsrch.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sb_peak.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\goldsrh2.obj" : $(SOURCE) $(DEP_CPP_GOLDSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_GOLDSR=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"goldsrch.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sb_peak.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\goldsrh2.obj" : $(SOURCE) $(DEP_CPP_GOLDSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\optmiz2.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_OPTMI=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"goldsrh2.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"optmiz2.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\optmiz2.obj" : $(SOURCE) $(DEP_CPP_OPTMI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_OPTMI=\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"goldsrh2.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"optmiz2.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\optmiz2.obj" : $(SOURCE) $(DEP_CPP_OPTMI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\prog_13a.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"goldsrch.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"optmiz2.h"\
	{$(INCLUDE)}"swept.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\prog_13a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"fir_dsgn.h"\
	{$(INCLUDE)}"fs_dsgn.h"\
	{$(INCLUDE)}"fs_resp.h"\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"fs_util.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"goldsrch.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"optmiz2.h"\
	{$(INCLUDE)}"swept.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\prog_13a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\sb_peak.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_SB_PE=\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\sb_peak.obj" : $(SOURCE) $(DEP_CPP_SB_PE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_SB_PE=\
	{$(INCLUDE)}"fs_spec.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\sb_peak.obj" : $(SOURCE) $(DEP_CPP_SB_PE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\swept.cpp

!IF  "$(CFG)" == "prog_13a - Win32 Release"

DEP_CPP_SWEPT=\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"swept.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\swept.obj" : $(SOURCE) $(DEP_CPP_SWEPT) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_13a - Win32 Debug"

DEP_CPP_SWEPT=\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"swept.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\swept.obj" : $(SOURCE) $(DEP_CPP_SWEPT) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

