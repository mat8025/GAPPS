# Microsoft Developer Studio Generated NMAKE File, Based on ex24_10.dsp
!IF "$(CFG)" == ""
CFG=ex24_10 - Win32 Debug
!MESSAGE No configuration specified. Defaulting to ex24_10 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "ex24_10 - Win32 Release" && "$(CFG)" !=\
 "ex24_10 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ex24_10.mak" CFG="ex24_10 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ex24_10 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ex24_10 - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex24_10.exe"

!ELSE 

ALL : "$(OUTDIR)\ex24_10.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\adap_fir.obj"
	-@erase "$(INTDIR)\ar_proc.obj"
	-@erase "$(INTDIR)\ar_src.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\dirform1.obj"
	-@erase "$(INTDIR)\ex24_10.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\learncur.obj"
	-@erase "$(INTDIR)\matrix_T.obj"
	-@erase "$(INTDIR)\rls_filt.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vector_T.obj"
	-@erase "$(OUTDIR)\ex24_10.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\ex24_10.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c\
 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex24_10.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\ex24_10.pdb" /machine:I386 /out:"$(OUTDIR)\ex24_10.exe" 
LINK32_OBJS= \
	"$(INTDIR)\adap_fir.obj" \
	"$(INTDIR)\ar_proc.obj" \
	"$(INTDIR)\ar_src.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\dirform1.obj" \
	"$(INTDIR)\ex24_10.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\learncur.obj" \
	"$(INTDIR)\matrix_T.obj" \
	"$(INTDIR)\rls_filt.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\vector_T.obj"

"$(OUTDIR)\ex24_10.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex24_10.exe"

!ELSE 

ALL : "$(OUTDIR)\ex24_10.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\adap_fir.obj"
	-@erase "$(INTDIR)\ar_proc.obj"
	-@erase "$(INTDIR)\ar_src.obj"
	-@erase "$(INTDIR)\complex.obj"
	-@erase "$(INTDIR)\dirform1.obj"
	-@erase "$(INTDIR)\ex24_10.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\learncur.obj"
	-@erase "$(INTDIR)\matrix_T.obj"
	-@erase "$(INTDIR)\rls_filt.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\vector_T.obj"
	-@erase "$(OUTDIR)\ex24_10.exe"
	-@erase "$(OUTDIR)\ex24_10.ilk"
	-@erase "$(OUTDIR)\ex24_10.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\ex24_10.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex24_10.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\ex24_10.pdb" /debug /machine:I386 /out:"$(OUTDIR)\ex24_10.exe"\
 /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\adap_fir.obj" \
	"$(INTDIR)\ar_proc.obj" \
	"$(INTDIR)\ar_src.obj" \
	"$(INTDIR)\complex.obj" \
	"$(INTDIR)\dirform1.obj" \
	"$(INTDIR)\ex24_10.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\learncur.obj" \
	"$(INTDIR)\matrix_T.obj" \
	"$(INTDIR)\rls_filt.obj" \
	"$(INTDIR)\uni_rand.obj" \
	"$(INTDIR)\vector_T.obj"

"$(OUTDIR)\ex24_10.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "ex24_10 - Win32 Release" || "$(CFG)" ==\
 "ex24_10 - Win32 Debug"
SOURCE=..\sources\adap_fir.cpp

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

DEP_CPP_ADAP_=\
	{$(INCLUDE)}"adap_fir.h"\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\adap_fir.obj" : $(SOURCE) $(DEP_CPP_ADAP_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

DEP_CPP_ADAP_=\
	{$(INCLUDE)}"adap_fir.h"\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\adap_fir.obj" : $(SOURCE) $(DEP_CPP_ADAP_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ar_proc.cpp

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

DEP_CPP_AR_PR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_proc.obj" : $(SOURCE) $(DEP_CPP_AR_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

DEP_CPP_AR_PR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_proc.obj" : $(SOURCE) $(DEP_CPP_AR_PR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ar_src.cpp
DEP_CPP_AR_SR=\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"ar_src.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"sig_type.h"\
	

"$(INTDIR)\ar_src.obj" : $(SOURCE) $(DEP_CPP_AR_SR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\complex.cpp
DEP_CPP_COMPL=\
	{$(INCLUDE)}"complex.h"\
	

"$(INTDIR)\complex.obj" : $(SOURCE) $(DEP_CPP_COMPL) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\dirform1.cpp

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

DEP_CPP_DIRFO=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\dirform1.obj" : $(SOURCE) $(DEP_CPP_DIRFO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

DEP_CPP_DIRFO=\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\dirform1.obj" : $(SOURCE) $(DEP_CPP_DIRFO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ex24_10.cpp

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

DEP_CPP_EX24_=\
	{$(INCLUDE)}"adap_fir.h"\
	{$(INCLUDE)}"adaptype.h"\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"ar_src.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"learncur.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"rls_filt.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\ex24_10.obj" : $(SOURCE) $(DEP_CPP_EX24_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

DEP_CPP_EX24_=\
	{$(INCLUDE)}"adap_fir.h"\
	{$(INCLUDE)}"adaptype.h"\
	{$(INCLUDE)}"ar_proc.h"\
	{$(INCLUDE)}"ar_src.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"learncur.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"rls_filt.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\ex24_10.obj" : $(SOURCE) $(DEP_CPP_EX24_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gausrand.cpp

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\learncur.cpp
DEP_CPP_LEARN=\
	{$(INCLUDE)}"learncur.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\learncur.obj" : $(SOURCE) $(DEP_CPP_LEARN) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\matrix_T.cpp

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

DEP_CPP_MATRI=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\matrix_T.obj" : $(SOURCE) $(DEP_CPP_MATRI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

DEP_CPP_MATRI=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\matrix_T.obj" : $(SOURCE) $(DEP_CPP_MATRI) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\rls_filt.cpp

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

DEP_CPP_RLS_F=\
	{$(INCLUDE)}"adap_fir.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"rls_filt.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\rls_filt.obj" : $(SOURCE) $(DEP_CPP_RLS_F) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

DEP_CPP_RLS_F=\
	{$(INCLUDE)}"adap_fir.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dirform1.h"\
	{$(INCLUDE)}"filt_imp.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"rls_filt.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\rls_filt.obj" : $(SOURCE) $(DEP_CPP_RLS_F) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\uni_rand.cpp
DEP_CPP_UNI_R=\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\uni_rand.obj" : $(SOURCE) $(DEP_CPP_UNI_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\vector_T.cpp

!IF  "$(CFG)" == "ex24_10 - Win32 Release"

DEP_CPP_VECTO=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\vector_T.obj" : $(SOURCE) $(DEP_CPP_VECTO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_10 - Win32 Debug"

DEP_CPP_VECTO=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"matrix_t.h"\
	{$(INCLUDE)}"vector_t.h"\
	

"$(INTDIR)\vector_T.obj" : $(SOURCE) $(DEP_CPP_VECTO) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

