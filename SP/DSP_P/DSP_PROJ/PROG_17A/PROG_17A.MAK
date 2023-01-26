# Microsoft Developer Studio Generated NMAKE File, Based on prog_17a.dsp
!IF "$(CFG)" == ""
CFG=prog_17a - Win32 Debug
!MESSAGE No configuration specified. Defaulting to prog_17a - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "prog_17a - Win32 Release" && "$(CFG)" !=\
 "prog_17a - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "prog_17a.mak" CFG="prog_17a - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "prog_17a - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "prog_17a - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "prog_17a - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_17a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_17a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\anlg_rcn.obj"
	-@erase "$(INTDIR)\bilinear.obj"
	-@erase "$(INTDIR)\buttfunc.obj"
	-@erase "$(INTDIR)\chebfunc.obj"
	-@erase "$(INTDIR)\cmpxpoly.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\dir1_iir.obj"
	-@erase "$(INTDIR)\elipfunc.obj"
	-@erase "$(INTDIR)\filtfunc.obj"
	-@erase "$(INTDIR)\iir_dsgn.obj"
	-@erase "$(INTDIR)\iir_resp.obj"
	-@erase "$(INTDIR)\iirswept.obj"
	-@erase "$(INTDIR)\laguerre.obj"
	-@erase "$(INTDIR)\pause.obj"
	-@erase "$(INTDIR)\poly.obj"
	-@erase "$(INTDIR)\prog_17a.obj"
	-@erase "$(INTDIR)\sinc.obj"
	-@erase "$(INTDIR)\unq_iir.obj"
	-@erase "$(INTDIR)\unwrap.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\prog_17a.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\prog_17a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_17a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\prog_17a.pdb" /machine:I386 /out:"$(OUTDIR)\prog_17a.exe" 
LINK32_OBJS= \
	"$(INTDIR)\anlg_rcn.obj" \
	"$(INTDIR)\bilinear.obj" \
	"$(INTDIR)\buttfunc.obj" \
	"$(INTDIR)\chebfunc.obj" \
	"$(INTDIR)\cmpxpoly.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\dir1_iir.obj" \
	"$(INTDIR)\elipfunc.obj" \
	"$(INTDIR)\filtfunc.obj" \
	"$(INTDIR)\iir_dsgn.obj" \
	"$(INTDIR)\iir_resp.obj" \
	"$(INTDIR)\iirswept.obj" \
	"$(INTDIR)\laguerre.obj" \
	"$(INTDIR)\pause.obj" \
	"$(INTDIR)\poly.obj" \
	"$(INTDIR)\prog_17a.obj" \
	"$(INTDIR)\sinc.obj" \
	"$(INTDIR)\unq_iir.obj" \
	"$(INTDIR)\unwrap.obj"

"$(OUTDIR)\prog_17a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_17a.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_17a.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\anlg_rcn.obj"
	-@erase "$(INTDIR)\bilinear.obj"
	-@erase "$(INTDIR)\buttfunc.obj"
	-@erase "$(INTDIR)\chebfunc.obj"
	-@erase "$(INTDIR)\cmpxpoly.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\dir1_iir.obj"
	-@erase "$(INTDIR)\elipfunc.obj"
	-@erase "$(INTDIR)\filtfunc.obj"
	-@erase "$(INTDIR)\iir_dsgn.obj"
	-@erase "$(INTDIR)\iir_resp.obj"
	-@erase "$(INTDIR)\iirswept.obj"
	-@erase "$(INTDIR)\laguerre.obj"
	-@erase "$(INTDIR)\pause.obj"
	-@erase "$(INTDIR)\poly.obj"
	-@erase "$(INTDIR)\prog_17a.obj"
	-@erase "$(INTDIR)\sinc.obj"
	-@erase "$(INTDIR)\unq_iir.obj"
	-@erase "$(INTDIR)\unwrap.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\prog_17a.exe"
	-@erase "$(OUTDIR)\prog_17a.ilk"
	-@erase "$(OUTDIR)\prog_17a.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\prog_17a.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_17a.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\prog_17a.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\prog_17a.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\anlg_rcn.obj" \
	"$(INTDIR)\bilinear.obj" \
	"$(INTDIR)\buttfunc.obj" \
	"$(INTDIR)\chebfunc.obj" \
	"$(INTDIR)\cmpxpoly.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\dir1_iir.obj" \
	"$(INTDIR)\elipfunc.obj" \
	"$(INTDIR)\filtfunc.obj" \
	"$(INTDIR)\iir_dsgn.obj" \
	"$(INTDIR)\iir_resp.obj" \
	"$(INTDIR)\iirswept.obj" \
	"$(INTDIR)\laguerre.obj" \
	"$(INTDIR)\pause.obj" \
	"$(INTDIR)\poly.obj" \
	"$(INTDIR)\prog_17a.obj" \
	"$(INTDIR)\sinc.obj" \
	"$(INTDIR)\unq_iir.obj" \
	"$(INTDIR)\unwrap.obj"

"$(OUTDIR)\prog_17a.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "prog_17a - Win32 Release" || "$(CFG)" ==\
 "prog_17a - Win32 Debug"
SOURCE=..\sources\anlg_rcn.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_ANLG_=\
	{$(INCLUDE)}"anlg_rcn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sinc.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\anlg_rcn.obj" : $(SOURCE) $(DEP_CPP_ANLG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

DEP_CPP_ANLG_=\
	{$(INCLUDE)}"anlg_rcn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sinc.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\anlg_rcn.obj" : $(SOURCE) $(DEP_CPP_ANLG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\bilinear.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_BILIN=\
	{$(INCLUDE)}"bilinear.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\bilinear.obj" : $(SOURCE) $(DEP_CPP_BILIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

DEP_CPP_BILIN=\
	{$(INCLUDE)}"bilinear.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\bilinear.obj" : $(SOURCE) $(DEP_CPP_BILIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\buttfunc.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

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

!IF  "$(CFG)" == "prog_17a - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

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

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_CMPXP=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	{$(INCLUDE)}"pause.h"\
	

"$(INTDIR)\cmpxpoly.obj" : $(SOURCE) $(DEP_CPP_CMPXP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

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


SOURCE=..\sources\dir1_iir.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_DIR1_=\
	{$(INCLUDE)}"dir1_iir.h"\
	{$(INCLUDE)}"filt_imp.h"\
	

"$(INTDIR)\dir1_iir.obj" : $(SOURCE) $(DEP_CPP_DIR1_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

DEP_CPP_DIR1_=\
	{$(INCLUDE)}"dir1_iir.h"\
	{$(INCLUDE)}"filt_imp.h"\
	

"$(INTDIR)\dir1_iir.obj" : $(SOURCE) $(DEP_CPP_DIR1_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\elipfunc.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

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

!IF  "$(CFG)" == "prog_17a - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

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

SOURCE=..\sources\iir_dsgn.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_IIR_D=\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\iir_dsgn.obj" : $(SOURCE) $(DEP_CPP_IIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

DEP_CPP_IIR_D=\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\iir_dsgn.obj" : $(SOURCE) $(DEP_CPP_IIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\iir_resp.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_IIR_R=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"iir_resp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unwrap.h"\
	

"$(INTDIR)\iir_resp.obj" : $(SOURCE) $(DEP_CPP_IIR_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

DEP_CPP_IIR_R=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"iir_resp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unwrap.h"\
	

"$(INTDIR)\iir_resp.obj" : $(SOURCE) $(DEP_CPP_IIR_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\iirswept.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_IIRSW=\
	{$(INCLUDE)}"anlg_rcn.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"iirswept.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\iirswept.obj" : $(SOURCE) $(DEP_CPP_IIRSW) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

DEP_CPP_IIRSW=\
	{$(INCLUDE)}"anlg_rcn.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"iirswept.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\iirswept.obj" : $(SOURCE) $(DEP_CPP_IIRSW) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\laguerre.cpp
DEP_CPP_LAGUE=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	

"$(INTDIR)\laguerre.obj" : $(SOURCE) $(DEP_CPP_LAGUE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\pause.cpp

"$(INTDIR)\pause.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\poly.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_POLY_=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\poly.obj" : $(SOURCE) $(DEP_CPP_POLY_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

DEP_CPP_POLY_=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\poly.obj" : $(SOURCE) $(DEP_CPP_POLY_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\prog_17a.cpp

!IF  "$(CFG)" == "prog_17a - Win32 Release"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"bilinear.h"\
	{$(INCLUDE)}"buttfunc.h"\
	{$(INCLUDE)}"chebfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dir1_iir.h"\
	{$(INCLUDE)}"elipfunc.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"iir_resp.h"\
	{$(INCLUDE)}"iirswept.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\prog_17a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_17a - Win32 Debug"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"bilinear.h"\
	{$(INCLUDE)}"buttfunc.h"\
	{$(INCLUDE)}"chebfunc.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dir1_iir.h"\
	{$(INCLUDE)}"elipfunc.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"iir_resp.h"\
	{$(INCLUDE)}"iirswept.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\prog_17a.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\sinc.cpp
DEP_CPP_SINC_=\
	{$(INCLUDE)}"sinc.h"\
	

"$(INTDIR)\sinc.obj" : $(SOURCE) $(DEP_CPP_SINC_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\unq_iir.cpp
DEP_CPP_UNQ_I=\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\unq_iir.obj" : $(SOURCE) $(DEP_CPP_UNQ_I) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\unwrap.cpp
DEP_CPP_UNWRA=\
	{$(INCLUDE)}"unwrap.h"\
	

"$(INTDIR)\unwrap.obj" : $(SOURCE) $(DEP_CPP_UNWRA) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

