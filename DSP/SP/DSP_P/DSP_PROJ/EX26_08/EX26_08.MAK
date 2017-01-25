# Microsoft Developer Studio Generated NMAKE File, Based on ex26_08.dsp
!IF "$(CFG)" == ""
CFG=ex26_08 - Win32 Debug
!MESSAGE No configuration specified. Defaulting to ex26_08 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "ex26_08 - Win32 Release" && "$(CFG)" !=\
 "ex26_08 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ex26_08.mak" CFG="ex26_08 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ex26_08 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ex26_08 - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex26_08.exe"

!ELSE 

ALL : "$(OUTDIR)\ex26_08.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\ar_proc.obj"
	-@erase "$(INTDIR)\ar_src.obj"
	-@erase "$(INTDIR)\arma_est.obj"
	-@erase "$(INTDIR)\armaproc.obj"
	-@erase "$(INTDIR)\armaspec.obj"
	-@erase "$(INTDIR)\autometh.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\ex26_08.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\gen_lev.obj"
	-@erase "$(INTDIR)\levin.obj"
	-@erase "$(INTDIR)\matrix_T.obj"
	-@erase "$(INTDIR)\mod_yuwa.obj"
	-@erase "$(INTDIR)\sinc.obj"
	-@erase "$(INTDIR)\toeplitz.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vector_T.obj"
	-@erase "$(INTDIR)\yulewalk.obj"
	-@erase "$(OUTDIR)\ex26_08.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\ex26_08.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c\
 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex26_08.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\ex26_08.pdb" /machine:I386 /out:"$(OUTDIR)\ex26_08.exe" 
LINK32_OBJS= \
	"$(INTDIR)\ar_proc.obj" \
	"$(INTDIR)\ar_src.obj" \
	"$(INTDIR)\arma_est.obj" \
	"$(INTDIR)\armaproc.obj" \
	"$(INTDIR)\armaspec.obj" \
	"$(INTDIR)\autometh.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\ex26_08.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\gen_lev.obj" \
	"$(INTDIR)\levin.obj" \
	"$(INTDIR)\matrix_T.obj" \
	"$(INTDIR)\mod_yuwa.obj" \
	"$(INTDIR)\sinc.obj" \
	"$(INTDIR)\toeplitz.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\vector_T.obj" \
	"$(INTDIR)\yulewalk.obj"

"$(OUTDIR)\ex26_08.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex26_08.exe"

!ELSE 

ALL : "$(OUTDIR)\ex26_08.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\ar_proc.obj"
	-@erase "$(INTDIR)\ar_src.obj"
	-@erase "$(INTDIR)\arma_est.obj"
	-@erase "$(INTDIR)\armaproc.obj"
	-@erase "$(INTDIR)\armaspec.obj"
	-@erase "$(INTDIR)\autometh.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\ex26_08.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\gen_lev.obj"
	-@erase "$(INTDIR)\levin.obj"
	-@erase "$(INTDIR)\matrix_T.obj"
	-@erase "$(INTDIR)\mod_yuwa.obj"
	-@erase "$(INTDIR)\sinc.obj"
	-@erase "$(INTDIR)\toeplitz.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\vector_T.obj"
	-@erase "$(INTDIR)\yulewalk.obj"
	-@erase "$(OUTDIR)\ex26_08.exe"
	-@erase "$(OUTDIR)\ex26_08.ilk"
	-@erase "$(OUTDIR)\ex26_08.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\ex26_08.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex26_08.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\ex26_08.pdb" /debug /machine:I386 /out:"$(OUTDIR)\ex26_08.exe"\
 /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\ar_proc.obj" \
	"$(INTDIR)\ar_src.obj" \
	"$(INTDIR)\arma_est.obj" \
	"$(INTDIR)\armaproc.obj" \
	"$(INTDIR)\armaspec.obj" \
	"$(INTDIR)\autometh.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\ex26_08.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\gen_lev.obj" \
	"$(INTDIR)\levin.obj" \
	"$(INTDIR)\matrix_T.obj" \
	"$(INTDIR)\mod_yuwa.obj" \
	"$(INTDIR)\sinc.obj" \
	"$(INTDIR)\toeplitz.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\vector_T.obj" \
	"$(INTDIR)\yulewalk.obj"

"$(OUTDIR)\ex26_08.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "ex26_08 - Win32 Release" || "$(CFG)" ==\
 "ex26_08 - Win32 Debug"
SOURCE=..\sources\ar_proc.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_AR_PR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_proc.obj" : $(SOURCE) $(DEP_CPP_AR_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_AR_PR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_proc.obj" : $(SOURCE) $(DEP_CPP_AR_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ar_src.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_AR_SR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"ar_src.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_src.obj" : $(SOURCE) $(DEP_CPP_AR_SR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_AR_SR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"ar_src.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_src.obj" : $(SOURCE) $(DEP_CPP_AR_SR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\arma_est.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_ARMA_=\
	{$(INCLUDE)}"arma_est.h"\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"mod_yuwa.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\arma_est.obj" : $(SOURCE) $(DEP_CPP_ARMA_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_ARMA_=\
	{$(INCLUDE)}"arma_est.h"\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"mod_yuwa.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\arma_est.obj" : $(SOURCE) $(DEP_CPP_ARMA_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\armaproc.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_ARMAP=\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"mod_yuwa.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\armaproc.obj" : $(SOURCE) $(DEP_CPP_ARMAP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_ARMAP=\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"mod_yuwa.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\armaproc.obj" : $(SOURCE) $(DEP_CPP_ARMAP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\armaspec.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_ARMAS=\
	{$(INCLUDE)}"armaspec.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"thy_spec.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\armaspec.obj" : $(SOURCE) $(DEP_CPP_ARMAS) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_ARMAS=\
	{$(INCLUDE)}"armaspec.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"thy_spec.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\armaspec.obj" : $(SOURCE) $(DEP_CPP_ARMAS) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\autometh.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_AUTOM=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"overload.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\autometh.obj" : $(SOURCE) $(DEP_CPP_AUTOM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

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

SOURCE=..\sources\complex.cpp
DEP_CPP_COMPL=\
	{$(INCLUDE)}"complex.h"\
	

"$(INTDIR)\complex.obj" : $(SOURCE) $(DEP_CPP_COMPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\ex26_08.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_EX26_=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"ar_src.h"\
	{$(INCLUDE)}"arma_est.h"\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"armaspec.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"thy_spec.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\ex26_08.obj" : $(SOURCE) $(DEP_CPP_EX26_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_EX26_=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"ar_src.h"\
	{$(INCLUDE)}"arma_est.h"\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"armaspec.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"thy_spec.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\ex26_08.obj" : $(SOURCE) $(DEP_CPP_EX26_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gausrand.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gen_lev.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_GEN_L=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gen_lev.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"overload.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\gen_lev.obj" : $(SOURCE) $(DEP_CPP_GEN_L) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_GEN_L=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gen_lev.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"overload.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\gen_lev.obj" : $(SOURCE) $(DEP_CPP_GEN_L) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\levin.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_LEVIN=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"overload.h"\
	

"$(INTDIR)\levin.obj" : $(SOURCE) $(DEP_CPP_LEVIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_LEVIN=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"overload.h"\
	

"$(INTDIR)\levin.obj" : $(SOURCE) $(DEP_CPP_LEVIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\matrix_T.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_MATRI=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\matrix_T.obj" : $(SOURCE) $(DEP_CPP_MATRI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_MATRI=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\matrix_T.obj" : $(SOURCE) $(DEP_CPP_MATRI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\mod_yuwa.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_MOD_Y=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gen_lev.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"mod_yuwa.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\mod_yuwa.obj" : $(SOURCE) $(DEP_CPP_MOD_Y) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_MOD_Y=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gen_lev.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"mod_yuwa.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\mod_yuwa.obj" : $(SOURCE) $(DEP_CPP_MOD_Y) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\sinc.cpp
DEP_CPP_SINC_=\
	{$(INCLUDE)}"sinc.h"\
	

"$(INTDIR)\sinc.obj" : $(SOURCE) $(DEP_CPP_SINC_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\toeplitz.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_TOEPL=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"toeplitz.h"\
	

"$(INTDIR)\toeplitz.obj" : $(SOURCE) $(DEP_CPP_TOEPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

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


SOURCE=..\sources\vector_T.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

DEP_CPP_VECTO=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\vector_T.obj" : $(SOURCE) $(DEP_CPP_VECTO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

DEP_CPP_VECTO=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\vector_T.obj" : $(SOURCE) $(DEP_CPP_VECTO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\yulewalk.cpp

!IF  "$(CFG)" == "ex26_08 - Win32 Release"

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


!ELSEIF  "$(CFG)" == "ex26_08 - Win32 Debug"

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

