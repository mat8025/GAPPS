# Microsoft Developer Studio Generated NMAKE File, Based on ex23_01.dsp
!IF "$(CFG)" == ""
CFG=ex23_01 - Win32 Debug
!MESSAGE No configuration specified. Defaulting to ex23_01 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "ex23_01 - Win32 Release" && "$(CFG)" !=\
 "ex23_01 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ex23_01.mak" CFG="ex23_01 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ex23_01 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ex23_01 - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex23_01.exe"

!ELSE 

ALL : "$(OUTDIR)\ex23_01.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\ar_est.obj"
	-@erase "$(INTDIR)\ar_proc.obj"
	-@erase "$(INTDIR)\autometh.obj"
	-@erase "$(INTDIR)\bilinear.obj"
	-@erase "$(INTDIR)\cmpxpoly.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\dir1_iir.obj"
	-@erase "$(INTDIR)\ex23_01.obj"
	-@erase "$(INTDIR)\filtfunc.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\iir_dsgn.obj"
	-@erase "$(INTDIR)\laguerre.obj"
	-@erase "$(INTDIR)\levin.obj"
	-@erase "$(INTDIR)\numinteg.obj"
	-@erase "$(INTDIR)\pause.obj"
	-@erase "$(INTDIR)\polefunc.obj"
	-@erase "$(INTDIR)\poly.obj"
	-@erase "$(INTDIR)\polydiv.obj"
	-@erase "$(INTDIR)\toeplitz.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\unq_iir.obj"
	-@erase "$(INTDIR)\unwrap.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\yulewalk.obj"
	-@erase "$(OUTDIR)\ex23_01.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\ex23_01.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c\
 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex23_01.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\ex23_01.pdb" /machine:I386 /out:"$(OUTDIR)\ex23_01.exe" 
LINK32_OBJS= \
	"$(INTDIR)\ar_est.obj" \
	"$(INTDIR)\ar_proc.obj" \
	"$(INTDIR)\autometh.obj" \
	"$(INTDIR)\bilinear.obj" \
	"$(INTDIR)\cmpxpoly.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\dir1_iir.obj" \
	"$(INTDIR)\ex23_01.obj" \
	"$(INTDIR)\filtfunc.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\iir_dsgn.obj" \
	"$(INTDIR)\laguerre.obj" \
	"$(INTDIR)\levin.obj" \
	"$(INTDIR)\numinteg.obj" \
	"$(INTDIR)\pause.obj" \
	"$(INTDIR)\polefunc.obj" \
	"$(INTDIR)\poly.obj" \
	"$(INTDIR)\polydiv.obj" \
	"$(INTDIR)\toeplitz.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\unq_iir.obj" \
	"$(INTDIR)\unwrap.obj" \
	"$(INTDIR)\yulewalk.obj"

"$(OUTDIR)\ex23_01.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex23_01.exe"

!ELSE 

ALL : "$(OUTDIR)\ex23_01.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\ar_est.obj"
	-@erase "$(INTDIR)\ar_proc.obj"
	-@erase "$(INTDIR)\autometh.obj"
	-@erase "$(INTDIR)\bilinear.obj"
	-@erase "$(INTDIR)\cmpxpoly.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\dir1_iir.obj"
	-@erase "$(INTDIR)\ex23_01.obj"
	-@erase "$(INTDIR)\filtfunc.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\iir_dsgn.obj"
	-@erase "$(INTDIR)\laguerre.obj"
	-@erase "$(INTDIR)\levin.obj"
	-@erase "$(INTDIR)\numinteg.obj"
	-@erase "$(INTDIR)\pause.obj"
	-@erase "$(INTDIR)\polefunc.obj"
	-@erase "$(INTDIR)\poly.obj"
	-@erase "$(INTDIR)\polydiv.obj"
	-@erase "$(INTDIR)\toeplitz.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\unq_iir.obj"
	-@erase "$(INTDIR)\unwrap.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\yulewalk.obj"
	-@erase "$(OUTDIR)\ex23_01.exe"
	-@erase "$(OUTDIR)\ex23_01.ilk"
	-@erase "$(OUTDIR)\ex23_01.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\ex23_01.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex23_01.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\ex23_01.pdb" /debug /machine:I386 /out:"$(OUTDIR)\ex23_01.exe"\
 /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\ar_est.obj" \
	"$(INTDIR)\ar_proc.obj" \
	"$(INTDIR)\autometh.obj" \
	"$(INTDIR)\bilinear.obj" \
	"$(INTDIR)\cmpxpoly.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\dir1_iir.obj" \
	"$(INTDIR)\ex23_01.obj" \
	"$(INTDIR)\filtfunc.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\iir_dsgn.obj" \
	"$(INTDIR)\laguerre.obj" \
	"$(INTDIR)\levin.obj" \
	"$(INTDIR)\numinteg.obj" \
	"$(INTDIR)\pause.obj" \
	"$(INTDIR)\polefunc.obj" \
	"$(INTDIR)\poly.obj" \
	"$(INTDIR)\polydiv.obj" \
	"$(INTDIR)\toeplitz.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\unq_iir.obj" \
	"$(INTDIR)\unwrap.obj" \
	"$(INTDIR)\yulewalk.obj"

"$(OUTDIR)\ex23_01.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "ex23_01 - Win32 Release" || "$(CFG)" ==\
 "ex23_01 - Win32 Debug"
SOURCE=..\sources\ar_est.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_AR_ES=\
	{$(INCLUDE)}"ar_est.h"\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\ar_est.obj" : $(SOURCE) $(DEP_CPP_AR_ES) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_AR_ES=\
	{$(INCLUDE)}"ar_est.h"\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\ar_est.obj" : $(SOURCE) $(DEP_CPP_AR_ES) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ar_proc.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_AR_PR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_proc.obj" : $(SOURCE) $(DEP_CPP_AR_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_AR_PR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_proc.obj" : $(SOURCE) $(DEP_CPP_AR_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\autometh.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_AUTOM=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"overload.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\autometh.obj" : $(SOURCE) $(DEP_CPP_AUTOM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_AUTOM=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"overload.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\autometh.obj" : $(SOURCE) $(DEP_CPP_AUTOM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\bilinear.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

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


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

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

SOURCE=..\sources\cmpxpoly.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_CMPXP=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	{$(INCLUDE)}"pause.h"\
	

"$(INTDIR)\cmpxpoly.obj" : $(SOURCE) $(DEP_CPP_CMPXP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

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

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_DIR1_=\
	{$(INCLUDE)}"dir1_iir.h"\
	{$(INCLUDE)}"filt_imp.h"\
	

"$(INTDIR)\dir1_iir.obj" : $(SOURCE) $(DEP_CPP_DIR1_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_DIR1_=\
	{$(INCLUDE)}"dir1_iir.h"\
	{$(INCLUDE)}"filt_imp.h"\
	

"$(INTDIR)\dir1_iir.obj" : $(SOURCE) $(DEP_CPP_DIR1_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ex23_01.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_EX23_=\
	{$(INCLUDE)}"ar_est.h"\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\ex23_01.obj" : $(SOURCE) $(DEP_CPP_EX23_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_EX23_=\
	{$(INCLUDE)}"ar_est.h"\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\ex23_01.obj" : $(SOURCE) $(DEP_CPP_EX23_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\filtfunc.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

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


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

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

SOURCE=..\sources\gausrand.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\iir_dsgn.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_IIR_D=\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\iir_dsgn.obj" : $(SOURCE) $(DEP_CPP_IIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_IIR_D=\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\iir_dsgn.obj" : $(SOURCE) $(DEP_CPP_IIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\laguerre.cpp
DEP_CPP_LAGUE=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	

"$(INTDIR)\laguerre.obj" : $(SOURCE) $(DEP_CPP_LAGUE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\levin.cpp
DEP_CPP_LEVIN=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"overload.h"\
	

"$(INTDIR)\levin.obj" : $(SOURCE) $(DEP_CPP_LEVIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\numinteg.cpp
DEP_CPP_NUMIN=\
	{$(INCLUDE)}"numinteg.h"\
	

"$(INTDIR)\numinteg.obj" : $(SOURCE) $(DEP_CPP_NUMIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\pause.cpp

"$(INTDIR)\pause.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\polefunc.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_POLEF=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"polefunc.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\polefunc.obj" : $(SOURCE) $(DEP_CPP_POLEF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_POLEF=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"polefunc.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\polefunc.obj" : $(SOURCE) $(DEP_CPP_POLEF) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\poly.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_POLY_=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\poly.obj" : $(SOURCE) $(DEP_CPP_POLY_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_POLY_=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\poly.obj" : $(SOURCE) $(DEP_CPP_POLY_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\polydiv.cpp
DEP_CPP_POLYD=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"polydiv.h"\
	

"$(INTDIR)\polydiv.obj" : $(SOURCE) $(DEP_CPP_POLYD) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\toeplitz.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_TOEPL=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"toeplitz.h"\
	

"$(INTDIR)\toeplitz.obj" : $(SOURCE) $(DEP_CPP_TOEPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_TOEPL=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"toeplitz.h"\
	

"$(INTDIR)\toeplitz.obj" : $(SOURCE) $(DEP_CPP_TOEPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\uni_rand.cpp
DEP_CPP_UNI_R=\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\uni_rand.obj" : $(SOURCE) $(DEP_CPP_UNI_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\unq_iir.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_UNQ_I=\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\unq_iir.obj" : $(SOURCE) $(DEP_CPP_UNQ_I) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_UNQ_I=\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\unq_iir.obj" : $(SOURCE) $(DEP_CPP_UNQ_I) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\unwrap.cpp
DEP_CPP_UNWRA=\
	{$(INCLUDE)}"unwrap.h"\
	

"$(INTDIR)\unwrap.obj" : $(SOURCE) $(DEP_CPP_UNWRA) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\yulewalk.cpp

!IF  "$(CFG)" == "ex23_01 - Win32 Release"

DEP_CPP_YULEW=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\yulewalk.obj" : $(SOURCE) $(DEP_CPP_YULEW) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_01 - Win32 Debug"

DEP_CPP_YULEW=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\yulewalk.obj" : $(SOURCE) $(DEP_CPP_YULEW) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

