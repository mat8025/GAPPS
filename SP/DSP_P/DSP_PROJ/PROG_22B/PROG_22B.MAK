# Microsoft Developer Studio Generated NMAKE File, Based on prog_22b.dsp
!IF "$(CFG)" == ""
CFG=prog_22b - Win32 Debug
!MESSAGE No configuration specified. Defaulting to prog_22b - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "prog_22b - Win32 Release" && "$(CFG)" !=\
 "prog_22b - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "prog_22b.mak" CFG="prog_22b - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "prog_22b - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "prog_22b - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "prog_22b - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_22b.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_22b.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\autometh.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\levin.obj"
	-@erase "$(INTDIR)\ma_est.obj"
	-@erase "$(INTDIR)\ma_proc.obj"
	-@erase "$(INTDIR)\ma_src.obj"
	-@erase "$(INTDIR)\prog_22b.obj"
	-@erase "$(INTDIR)\toeplitz.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\yulewalk.obj"
	-@erase "$(OUTDIR)\prog_22b.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\prog_22b.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_22b.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\prog_22b.pdb" /machine:I386 /out:"$(OUTDIR)\prog_22b.exe" 
LINK32_OBJS= \
	"$(INTDIR)\autometh.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\levin.obj" \
	"$(INTDIR)\ma_est.obj" \
	"$(INTDIR)\ma_proc.obj" \
	"$(INTDIR)\ma_src.obj" \
	"$(INTDIR)\prog_22b.obj" \
	"$(INTDIR)\toeplitz.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\yulewalk.obj"

"$(OUTDIR)\prog_22b.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\prog_22b.exe"

!ELSE 

ALL : "$(OUTDIR)\prog_22b.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\autometh.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\levin.obj"
	-@erase "$(INTDIR)\ma_est.obj"
	-@erase "$(INTDIR)\ma_proc.obj"
	-@erase "$(INTDIR)\ma_src.obj"
	-@erase "$(INTDIR)\prog_22b.obj"
	-@erase "$(INTDIR)\toeplitz.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\yulewalk.obj"
	-@erase "$(OUTDIR)\prog_22b.exe"
	-@erase "$(OUTDIR)\prog_22b.ilk"
	-@erase "$(OUTDIR)\prog_22b.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\prog_22b.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\prog_22b.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\prog_22b.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\prog_22b.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\autometh.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\levin.obj" \
	"$(INTDIR)\ma_est.obj" \
	"$(INTDIR)\ma_proc.obj" \
	"$(INTDIR)\ma_src.obj" \
	"$(INTDIR)\prog_22b.obj" \
	"$(INTDIR)\toeplitz.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\yulewalk.obj"

"$(OUTDIR)\prog_22b.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "prog_22b - Win32 Release" || "$(CFG)" ==\
 "prog_22b - Win32 Debug"
SOURCE=..\sources\autometh.cpp

!IF  "$(CFG)" == "prog_22b - Win32 Release"

DEP_CPP_AUTOM=\
	{$(INCLUDE)}"autometh.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"overload.h"\
	{$(INCLUDE)}"toeplitz.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\autometh.obj" : $(SOURCE) $(DEP_CPP_AUTOM) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

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


SOURCE=..\sources\levin.cpp

!IF  "$(CFG)" == "prog_22b - Win32 Release"

DEP_CPP_LEVIN=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"overload.h"\
	

"$(INTDIR)\levin.obj" : $(SOURCE) $(DEP_CPP_LEVIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

DEP_CPP_LEVIN=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"levin.h"\
	{$(INCLUDE)}"overload.h"\
	

"$(INTDIR)\levin.obj" : $(SOURCE) $(DEP_CPP_LEVIN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ma_est.cpp

!IF  "$(CFG)" == "prog_22b - Win32 Release"

DEP_CPP_MA_ES=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"ma_est.h"\
	{$(INCLUDE)}"ma_proc.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\ma_est.obj" : $(SOURCE) $(DEP_CPP_MA_ES) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

DEP_CPP_MA_ES=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"ma_est.h"\
	{$(INCLUDE)}"ma_proc.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\ma_est.obj" : $(SOURCE) $(DEP_CPP_MA_ES) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ma_proc.cpp

!IF  "$(CFG)" == "prog_22b - Win32 Release"

DEP_CPP_MA_PR=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"ma_proc.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\ma_proc.obj" : $(SOURCE) $(DEP_CPP_MA_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

DEP_CPP_MA_PR=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"ma_proc.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\ma_proc.obj" : $(SOURCE) $(DEP_CPP_MA_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ma_src.cpp

!IF  "$(CFG)" == "prog_22b - Win32 Release"

DEP_CPP_MA_SR=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"ma_proc.h"\
	{$(INCLUDE)}"ma_src.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ma_src.obj" : $(SOURCE) $(DEP_CPP_MA_SR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

DEP_CPP_MA_SR=\
	{$(INCLUDE)}"ma_proc.h"\
	{$(INCLUDE)}"ma_src.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ma_src.obj" : $(SOURCE) $(DEP_CPP_MA_SR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\prog_22b.cpp

!IF  "$(CFG)" == "prog_22b - Win32 Release"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"ma_est.h"\
	{$(INCLUDE)}"ma_proc.h"\
	{$(INCLUDE)}"ma_src.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\prog_22b.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

DEP_CPP_PROG_=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"ma_est.h"\
	{$(INCLUDE)}"ma_proc.h"\
	{$(INCLUDE)}"ma_src.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sig_type.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"yulewalk.h"\
	

"$(INTDIR)\prog_22b.obj" : $(SOURCE) $(DEP_CPP_PROG_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\toeplitz.cpp

!IF  "$(CFG)" == "prog_22b - Win32 Release"

DEP_CPP_TOEPL=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix.h"\
	{$(INCLUDE)}"toeplitz.h"\
	

"$(INTDIR)\toeplitz.obj" : $(SOURCE) $(DEP_CPP_TOEPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

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


SOURCE=..\sources\yulewalk.cpp

!IF  "$(CFG)" == "prog_22b - Win32 Release"

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


!ELSEIF  "$(CFG)" == "prog_22b - Win32 Debug"

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

