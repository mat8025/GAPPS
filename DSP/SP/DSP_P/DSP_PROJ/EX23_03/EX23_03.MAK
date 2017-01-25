# Microsoft Developer Studio Generated NMAKE File, Based on ex23_03.dsp
!IF "$(CFG)" == ""
CFG=ex23_03 - Win32 Debug
!MESSAGE No configuration specified. Defaulting to ex23_03 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "ex23_03 - Win32 Release" && "$(CFG)" !=\
 "ex23_03 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ex23_03.mak" CFG="ex23_03 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ex23_03 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ex23_03 - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex23_03.exe"

!ELSE 

ALL : "$(OUTDIR)\ex23_03.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\arsigsrc.obj"
	-@erase "$(INTDIR)\bilinear.obj"
	-@erase "$(INTDIR)\cholesky.obj"
	-@erase "$(INTDIR)\cmpxpoly.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\covmeth.obj"
	-@erase "$(INTDIR)\ex23_03.obj"
	-@erase "$(INTDIR)\filtfunc.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\iir_dsgn.obj"
	-@erase "$(INTDIR)\laguerre.obj"
	-@erase "$(INTDIR)\matrix_T.obj"
	-@erase "$(INTDIR)\pause.obj"
	-@erase "$(INTDIR)\polefunc.obj"
	-@erase "$(INTDIR)\poly.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\unq_iir.obj"
	-@erase "$(INTDIR)\unwrap.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vector_T.obj"
	-@erase "$(OUTDIR)\ex23_03.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\ex23_03.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c\
 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex23_03.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\ex23_03.pdb" /machine:I386 /out:"$(OUTDIR)\ex23_03.exe" 
LINK32_OBJS= \
	"$(INTDIR)\arsigsrc.obj" \
	"$(INTDIR)\bilinear.obj" \
	"$(INTDIR)\cholesky.obj" \
	"$(INTDIR)\cmpxpoly.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\covmeth.obj" \
	"$(INTDIR)\ex23_03.obj" \
	"$(INTDIR)\filtfunc.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\iir_dsgn.obj" \
	"$(INTDIR)\laguerre.obj" \
	"$(INTDIR)\matrix_T.obj" \
	"$(INTDIR)\pause.obj" \
	"$(INTDIR)\polefunc.obj" \
	"$(INTDIR)\poly.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\unq_iir.obj" \
	"$(INTDIR)\unwrap.obj" \
	"$(INTDIR)\vector_T.obj"

"$(OUTDIR)\ex23_03.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex23_03.exe" "$(OUTDIR)\ex23_03.bsc"

!ELSE 

ALL : "$(OUTDIR)\ex23_03.exe" "$(OUTDIR)\ex23_03.bsc"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\arsigsrc.obj"
	-@erase "$(INTDIR)\arsigsrc.sbr"
	-@erase "$(INTDIR)\bilinear.obj"
	-@erase "$(INTDIR)\bilinear.sbr"
	-@erase "$(INTDIR)\cholesky.obj"
	-@erase "$(INTDIR)\cholesky.sbr"
	-@erase "$(INTDIR)\cmpxpoly.obj"
	-@erase "$(INTDIR)\cmpxpoly.sbr"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\complex.sbr"
	-@erase "$(INTDIR)\covmeth.obj"
	-@erase "$(INTDIR)\covmeth.sbr"
	-@erase "$(INTDIR)\ex23_03.obj"
	-@erase "$(INTDIR)\ex23_03.sbr"
	-@erase "$(INTDIR)\filtfunc.obj"
	-@erase "$(INTDIR)\filtfunc.sbr"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\gausrand.sbr"
	-@erase "$(INTDIR)\iir_dsgn.obj"
	-@erase "$(INTDIR)\iir_dsgn.sbr"
	-@erase "$(INTDIR)\laguerre.obj"
	-@erase "$(INTDIR)\laguerre.sbr"
	-@erase "$(INTDIR)\matrix_T.obj"
	-@erase "$(INTDIR)\matrix_T.sbr"
	-@erase "$(INTDIR)\pause.obj"
	-@erase "$(INTDIR)\pause.sbr"
	-@erase "$(INTDIR)\polefunc.obj"
	-@erase "$(INTDIR)\polefunc.sbr"
	-@erase "$(INTDIR)\poly.obj"
	-@erase "$(INTDIR)\poly.sbr"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\uni_rand.sbr"
	-@erase "$(INTDIR)\unq_iir.obj"
	-@erase "$(INTDIR)\unq_iir.sbr"
	-@erase "$(INTDIR)\unwrap.obj"
	-@erase "$(INTDIR)\unwrap.sbr"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\vector_T.obj"
	-@erase "$(INTDIR)\vector_T.sbr"
	-@erase "$(OUTDIR)\ex23_03.bsc"
	-@erase "$(OUTDIR)\ex23_03.exe"
	-@erase "$(OUTDIR)\ex23_03.ilk"
	-@erase "$(OUTDIR)\ex23_03.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\ex23_03.pch" /YX /Fo"$(INTDIR)\\"\
 /Fd"$(INTDIR)\\" /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.\Debug/
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex23_03.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\arsigsrc.sbr" \
	"$(INTDIR)\bilinear.sbr" \
	"$(INTDIR)\cholesky.sbr" \
	"$(INTDIR)\cmpxpoly.sbr" \
	"$(INTDIR)\complex.sbr" \
	"$(INTDIR)\covmeth.sbr" \
	"$(INTDIR)\ex23_03.sbr" \
	"$(INTDIR)\filtfunc.sbr" \
	"$(INTDIR)\gausrand.sbr" \
	"$(INTDIR)\iir_dsgn.sbr" \
	"$(INTDIR)\laguerre.sbr" \
	"$(INTDIR)\matrix_T.sbr" \
	"$(INTDIR)\pause.sbr" \
	"$(INTDIR)\polefunc.sbr" \
	"$(INTDIR)\poly.sbr" \
	"$(INTDIR)\uni_rand.sbr" \
	"$(INTDIR)\unq_iir.sbr" \
	"$(INTDIR)\unwrap.sbr" \
	"$(INTDIR)\vector_T.sbr"

"$(OUTDIR)\ex23_03.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\ex23_03.pdb" /debug /machine:I386 /out:"$(OUTDIR)\ex23_03.exe"\
 /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\arsigsrc.obj" \
	"$(INTDIR)\bilinear.obj" \
	"$(INTDIR)\cholesky.obj" \
	"$(INTDIR)\cmpxpoly.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\covmeth.obj" \
	"$(INTDIR)\ex23_03.obj" \
	"$(INTDIR)\filtfunc.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\iir_dsgn.obj" \
	"$(INTDIR)\laguerre.obj" \
	"$(INTDIR)\matrix_T.obj" \
	"$(INTDIR)\pause.obj" \
	"$(INTDIR)\polefunc.obj" \
	"$(INTDIR)\poly.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\unq_iir.obj" \
	"$(INTDIR)\unwrap.obj" \
	"$(INTDIR)\vector_T.obj"

"$(OUTDIR)\ex23_03.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "ex23_03 - Win32 Release" || "$(CFG)" ==\
 "ex23_03 - Win32 Debug"
SOURCE=..\sources\arsigsrc.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

DEP_CPP_ARSIG=\
	{$(INCLUDE)}"arsigsrc.h"\
	{$(INCLUDE)}"bilinear.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"pause.h"\
	{$(INCLUDE)}"polefunc.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\arsigsrc.obj" : $(SOURCE) $(DEP_CPP_ARSIG) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_ARSIG=\
	{$(INCLUDE)}"arsigsrc.h"\
	{$(INCLUDE)}"bilinear.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"pause.h"\
	{$(INCLUDE)}"polefunc.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

"$(INTDIR)\arsigsrc.obj"	"$(INTDIR)\arsigsrc.sbr" : $(SOURCE) $(DEP_CPP_ARSIG)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\bilinear.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

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


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_BILIN=\
	{$(INCLUDE)}"bilinear.h"\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\bilinear.obj"	"$(INTDIR)\bilinear.sbr" : $(SOURCE) $(DEP_CPP_BILIN)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\cholesky.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

DEP_CPP_CHOLE=\
	{$(INCLUDE)}"cholesky.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\cholesky.obj" : $(SOURCE) $(DEP_CPP_CHOLE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_CHOLE=\
	{$(INCLUDE)}"cholesky.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\cholesky.obj"	"$(INTDIR)\cholesky.sbr" : $(SOURCE) $(DEP_CPP_CHOLE)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\cmpxpoly.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

DEP_CPP_CMPXP=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	{$(INCLUDE)}"pause.h"\
	

"$(INTDIR)\cmpxpoly.obj" : $(SOURCE) $(DEP_CPP_CMPXP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_CMPXP=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	{$(INCLUDE)}"pause.h"\
	

"$(INTDIR)\cmpxpoly.obj"	"$(INTDIR)\cmpxpoly.sbr" : $(SOURCE) $(DEP_CPP_CMPXP)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\complex.cpp
DEP_CPP_COMPL=\
	{$(INCLUDE)}"complex.h"\
	

!IF  "$(CFG)" == "ex23_03 - Win32 Release"


"$(INTDIR)\complex.obj" : $(SOURCE) $(DEP_CPP_COMPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"


"$(INTDIR)\complex.obj"	"$(INTDIR)\complex.sbr" : $(SOURCE) $(DEP_CPP_COMPL)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\covmeth.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

DEP_CPP_COVME=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"covmeth.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\covmeth.obj" : $(SOURCE) $(DEP_CPP_COVME) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_COVME=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"covmeth.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\covmeth.obj"	"$(INTDIR)\covmeth.sbr" : $(SOURCE) $(DEP_CPP_COVME)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ex23_03.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

DEP_CPP_EX23_=\
	{$(INCLUDE)}"arsigsrc.h"\
	{$(INCLUDE)}"cholesky.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"covmeth.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"pause.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\ex23_03.obj" : $(SOURCE) $(DEP_CPP_EX23_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_EX23_=\
	{$(INCLUDE)}"arsigsrc.h"\
	{$(INCLUDE)}"cholesky.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"covmeth.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"pause.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\ex23_03.obj"	"$(INTDIR)\ex23_03.sbr" : $(SOURCE) $(DEP_CPP_EX23_)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\filtfunc.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

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


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_FILTF=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"unwrap.h"\
	

"$(INTDIR)\filtfunc.obj"	"$(INTDIR)\filtfunc.sbr" : $(SOURCE) $(DEP_CPP_FILTF)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gausrand.cpp
DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

!IF  "$(CFG)" == "ex23_03 - Win32 Release"


"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"


"$(INTDIR)\gausrand.obj"	"$(INTDIR)\gausrand.sbr" : $(SOURCE) $(DEP_CPP_GAUSR)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\iir_dsgn.cpp
DEP_CPP_IIR_D=\
	{$(INCLUDE)}"iir_dsgn.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"typedefs.h"\
	

!IF  "$(CFG)" == "ex23_03 - Win32 Release"


"$(INTDIR)\iir_dsgn.obj" : $(SOURCE) $(DEP_CPP_IIR_D) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"


"$(INTDIR)\iir_dsgn.obj"	"$(INTDIR)\iir_dsgn.sbr" : $(SOURCE) $(DEP_CPP_IIR_D)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\laguerre.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

DEP_CPP_LAGUE=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	

"$(INTDIR)\laguerre.obj" : $(SOURCE) $(DEP_CPP_LAGUE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_LAGUE=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"laguerre.h"\
	

"$(INTDIR)\laguerre.obj"	"$(INTDIR)\laguerre.sbr" : $(SOURCE) $(DEP_CPP_LAGUE)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\matrix_T.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

DEP_CPP_MATRI=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\matrix_T.obj" : $(SOURCE) $(DEP_CPP_MATRI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_MATRI=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\matrix_T.obj"	"$(INTDIR)\matrix_T.sbr" : $(SOURCE) $(DEP_CPP_MATRI)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\pause.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"


"$(INTDIR)\pause.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"


"$(INTDIR)\pause.obj"	"$(INTDIR)\pause.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\polefunc.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

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


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_POLEF=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"filtfunc.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"polefunc.h"\
	{$(INCLUDE)}"poly.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\polefunc.obj"	"$(INTDIR)\polefunc.sbr" : $(SOURCE) $(DEP_CPP_POLEF)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\poly.cpp

!IF  "$(CFG)" == "ex23_03 - Win32 Release"

DEP_CPP_POLY_=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\poly.obj" : $(SOURCE) $(DEP_CPP_POLY_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"

DEP_CPP_POLY_=\
	{$(INCLUDE)}"cmpxpoly.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"poly.h"\
	

"$(INTDIR)\poly.obj"	"$(INTDIR)\poly.sbr" : $(SOURCE) $(DEP_CPP_POLY_)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\uni_rand.cpp
DEP_CPP_UNI_R=\
	{$(INCLUDE)}"uni_rand.h"\
	

!IF  "$(CFG)" == "ex23_03 - Win32 Release"


"$(INTDIR)\uni_rand.obj" : $(SOURCE) $(DEP_CPP_UNI_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"


"$(INTDIR)\uni_rand.obj"	"$(INTDIR)\uni_rand.sbr" : $(SOURCE) $(DEP_CPP_UNI_R)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\unq_iir.cpp
DEP_CPP_UNQ_I=\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"unq_iir.h"\
	

!IF  "$(CFG)" == "ex23_03 - Win32 Release"


"$(INTDIR)\unq_iir.obj" : $(SOURCE) $(DEP_CPP_UNQ_I) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"


"$(INTDIR)\unq_iir.obj"	"$(INTDIR)\unq_iir.sbr" : $(SOURCE) $(DEP_CPP_UNQ_I)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\unwrap.cpp
DEP_CPP_UNWRA=\
	{$(INCLUDE)}"unwrap.h"\
	

!IF  "$(CFG)" == "ex23_03 - Win32 Release"


"$(INTDIR)\unwrap.obj" : $(SOURCE) $(DEP_CPP_UNWRA) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"


"$(INTDIR)\unwrap.obj"	"$(INTDIR)\unwrap.sbr" : $(SOURCE) $(DEP_CPP_UNWRA)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\vector_T.cpp
DEP_CPP_VECTO=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

!IF  "$(CFG)" == "ex23_03 - Win32 Release"


"$(INTDIR)\vector_T.obj" : $(SOURCE) $(DEP_CPP_VECTO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex23_03 - Win32 Debug"


"$(INTDIR)\vector_T.obj"	"$(INTDIR)\vector_T.sbr" : $(SOURCE) $(DEP_CPP_VECTO)\
 "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

