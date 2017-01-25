# Microsoft Developer Studio Generated NMAKE File, Based on prog_22c.dsp
!IF "$(CFG)" == ""
CFG=prog_22c - Win32 Debug
!MESSAGE No configuration specified. Defaulting to prog_22c - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "prog_22c - Win32 Release" && "$(CFG)" !=\
 "prog_22c - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "prog_22c.mak" CFG="prog_22c - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "prog_22c - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "prog_22c - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "prog_22c - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_22c.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_22c.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\ar_proc.obj"
	-@erase "$(INTDIR)\arma_est.obj"
	-@erase "$(INTDIR)\arma_src.obj"
	-@erase "$(INTDIR)\armaproc.obj"
	-@erase "$(INTDIR)\autometh.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\gen_lev.obj"
	-@erase "$(INTDIR)\levin.obj"
	-@erase "$(INTDIR)\matrix_T.obj"
	-@erase "$(INTDIR)\mod_yuwa.obj"
	-@erase "$(INTDIR)\prog_22c.obj"
	-@erase "$(INTDIR)\toeplitz.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vector_T.obj"
	-@erase "$(INTDIR)\yulewalk.obj"
	-@erase "$(OUTDIR)\prog_22c.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\prog_22c.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_22c.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\prog_22c.pdb" /machine:I386 /out:"$(OUTDIR)\prog_22c.exe" 
LINK32_OBJS= \
	"$(INTDIR)\ar_proc.obj" \
	"$(INTDIR)\arma_est.obj" \
	"$(INTDIR)\arma_src.obj" \
	"$(INTDIR)\armaproc.obj" \
	"$(INTDIR)\autometh.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\gen_lev.obj" \
	"$(INTDIR)\levin.obj" \
	"$(INTDIR)\matrix_T.obj" \
	"$(INTDIR)\mod_yuwa.obj" \
	"$(INTDIR)\prog_22c.obj" \
	"$(INTDIR)\toeplitz.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\vector_T.obj" \
	"$(INTDIR)\yulewalk.obj"

"$(OUTDIR)\prog_22c.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_22c.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_22c.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\ar_proc.obj"
	-@erase "$(INTDIR)\arma_est.obj"
	-@erase "$(INTDIR)\arma_src.obj"
	-@erase "$(INTDIR)\armaproc.obj"
	-@erase "$(INTDIR)\autometh.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\gen_lev.obj"
	-@erase "$(INTDIR)\levin.obj"
	-@erase "$(INTDIR)\matrix_T.obj"
	-@erase "$(INTDIR)\mod_yuwa.obj"
	-@erase "$(INTDIR)\prog_22c.obj"
	-@erase "$(INTDIR)\toeplitz.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\vector_T.obj"
	-@erase "$(INTDIR)\yulewalk.obj"
	-@erase "$(OUTDIR)\prog_22c.exe"
	-@erase "$(OUTDIR)\prog_22c.ilk"
	-@erase "$(OUTDIR)\prog_22c.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\prog_22c.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_22c.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\prog_22c.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\prog_22c.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\ar_proc.obj" \
	"$(INTDIR)\arma_est.obj" \
	"$(INTDIR)\arma_src.obj" \
	"$(INTDIR)\armaproc.obj" \
	"$(INTDIR)\autometh.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\gen_lev.obj" \
	"$(INTDIR)\levin.obj" \
	"$(INTDIR)\matrix_T.obj" \
	"$(INTDIR)\mod_yuwa.obj" \
	"$(INTDIR)\prog_22c.obj" \
	"$(INTDIR)\toeplitz.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\vector_T.obj" \
	"$(INTDIR)\yulewalk.obj"

"$(OUTDIR)\prog_22c.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "prog_22c - Win32 Release" || "$(CFG)" ==\
 "prog_22c - Win32 Debug"
SOURCE=..\sources\ar_proc.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_AR_PR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_proc.obj" : $(SOURCE) $(DEP_CPP_AR_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

DEP_CPP_AR_PR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_proc.obj" : $(SOURCE) $(DEP_CPP_AR_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\arma_est.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

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

SOURCE=..\sources\arma_src.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_ARMA_S=\
	{$(INCLUDE)}"arma_src.h"\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"mod_yuwa.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\arma_src.obj" : $(SOURCE) $(DEP_CPP_ARMA_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

DEP_CPP_ARMA_S=\
	{$(INCLUDE)}"arma_src.h"\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"mod_yuwa.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\arma_src.obj" : $(SOURCE) $(DEP_CPP_ARMA_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\armaproc.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

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

SOURCE=..\sources\autometh.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_AUTOM=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"overload.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\autometh.obj" : $(SOURCE) $(DEP_CPP_AUTOM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

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


SOURCE=..\sources\gausrand.cpp
DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\gen_lev.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_GEN_L=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gen_lev.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"overload.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\gen_lev.obj" : $(SOURCE) $(DEP_CPP_GEN_L) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

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

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_LEVIN=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"overload.h"\
	

"$(INTDIR)\levin.obj" : $(SOURCE) $(DEP_CPP_LEVIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

DEP_CPP_LEVIN=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"overload.h"\
	

"$(INTDIR)\levin.obj" : $(SOURCE) $(DEP_CPP_LEVIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\matrix_T.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_MATRI=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\matrix_T.obj" : $(SOURCE) $(DEP_CPP_MATRI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

DEP_CPP_MATRI=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\matrix_T.obj" : $(SOURCE) $(DEP_CPP_MATRI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\mod_yuwa.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

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

SOURCE=..\sources\prog_22c.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"arma_est.h"\
	{$(INCLUDE)}"arma_src.h"\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\prog_22c.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"arma_est.h"\
	{$(INCLUDE)}"arma_src.h"\
	{$(INCLUDE)}"armaproc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\prog_22c.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\toeplitz.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_TOEPL=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"toeplitz.h"\
	

"$(INTDIR)\toeplitz.obj" : $(SOURCE) $(DEP_CPP_TOEPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

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

!IF  "$(CFG)" == "prog_22c - Win32 Release"

DEP_CPP_VECTO=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\vector_T.obj" : $(SOURCE) $(DEP_CPP_VECTO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

DEP_CPP_VECTO=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\vector_T.obj" : $(SOURCE) $(DEP_CPP_VECTO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\yulewalk.cpp

!IF  "$(CFG)" == "prog_22c - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_22c - Win32 Debug"

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

