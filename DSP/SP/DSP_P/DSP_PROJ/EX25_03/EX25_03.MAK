# Microsoft Developer Studio Generated NMAKE File, Based on ex25_03.dsp
!IF "$(CFG)" == ""
CFG=ex25_03 - Win32 Debug
!MESSAGE No configuration specified. Defaulting to ex25_03 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "ex25_03 - Win32 Release" && "$(CFG)" !=\
 "ex25_03 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ex25_03.mak" CFG="ex25_03 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ex25_03 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ex25_03 - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "ex25_03 - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex25_03.exe"

!ELSE 

ALL : "$(OUTDIR)\ex25_03.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\cbitrev.obj"
	-@erase "$(INTDIR)\cpfsk.obj"
	-@erase "$(INTDIR)\dan_pdgm.obj"
	-@erase "$(INTDIR)\dit_sino.obj"
	-@erase "$(INTDIR)\ex25_03.obj"
	-@erase "$(INTDIR)\fft.obj"
	-@erase "$(INTDIR)\fsk_spec.obj"
	-@erase "$(INTDIR)\log2.obj"
	-@erase "$(INTDIR)\psd_est.obj"
	-@erase "$(INTDIR)\sam_spec.obj"
	-@erase "$(INTDIR)\sinc.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\ex25_03.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\ex25_03.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c\
 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex25_03.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\ex25_03.pdb" /machine:I386 /out:"$(OUTDIR)\ex25_03.exe" 
LINK32_OBJS= \
	"$(INTDIR)\cbitrev.obj" \
	"$(INTDIR)\cpfsk.obj" \
	"$(INTDIR)\dan_pdgm.obj" \
	"$(INTDIR)\dit_sino.obj" \
	"$(INTDIR)\ex25_03.obj" \
	"$(INTDIR)\fft.obj" \
	"$(INTDIR)\fsk_spec.obj" \
	"$(INTDIR)\log2.obj" \
	"$(INTDIR)\psd_est.obj" \
	"$(INTDIR)\sam_spec.obj" \
	"$(INTDIR)\sinc.obj" \
	"$(INTDIR)\uni_rand.obj"

"$(OUTDIR)\ex25_03.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "ex25_03 - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex25_03.exe"

!ELSE 

ALL : "$(OUTDIR)\ex25_03.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\cbitrev.obj"
	-@erase "$(INTDIR)\cpfsk.obj"
	-@erase "$(INTDIR)\dan_pdgm.obj"
	-@erase "$(INTDIR)\dit_sino.obj"
	-@erase "$(INTDIR)\ex25_03.obj"
	-@erase "$(INTDIR)\fft.obj"
	-@erase "$(INTDIR)\fsk_spec.obj"
	-@erase "$(INTDIR)\log2.obj"
	-@erase "$(INTDIR)\psd_est.obj"
	-@erase "$(INTDIR)\sam_spec.obj"
	-@erase "$(INTDIR)\sinc.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\ex25_03.exe"
	-@erase "$(OUTDIR)\ex25_03.ilk"
	-@erase "$(OUTDIR)\ex25_03.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\ex25_03.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex25_03.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\ex25_03.pdb" /debug /machine:I386 /out:"$(OUTDIR)\ex25_03.exe"\
 /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\cbitrev.obj" \
	"$(INTDIR)\cpfsk.obj" \
	"$(INTDIR)\dan_pdgm.obj" \
	"$(INTDIR)\dit_sino.obj" \
	"$(INTDIR)\ex25_03.obj" \
	"$(INTDIR)\fft.obj" \
	"$(INTDIR)\fsk_spec.obj" \
	"$(INTDIR)\log2.obj" \
	"$(INTDIR)\psd_est.obj" \
	"$(INTDIR)\sam_spec.obj" \
	"$(INTDIR)\sinc.obj" \
	"$(INTDIR)\uni_rand.obj"

"$(OUTDIR)\ex25_03.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "ex25_03 - Win32 Release" || "$(CFG)" ==\
 "ex25_03 - Win32 Debug"
SOURCE=..\sources\cbitrev.cpp
DEP_CPP_CBITR=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	

"$(INTDIR)\cbitrev.obj" : $(SOURCE) $(DEP_CPP_CBITR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\cpfsk.cpp

!IF  "$(CFG)" == "ex25_03 - Win32 Release"

DEP_CPP_CPFSK=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"cpfsk.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\cpfsk.obj" : $(SOURCE) $(DEP_CPP_CPFSK) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex25_03 - Win32 Debug"

DEP_CPP_CPFSK=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"cpfsk.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"typedefs.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\cpfsk.obj" : $(SOURCE) $(DEP_CPP_CPFSK) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\dan_pdgm.cpp

!IF  "$(CFG)" == "ex25_03 - Win32 Release"

DEP_CPP_DAN_P=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dan_pdgm.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\dan_pdgm.obj" : $(SOURCE) $(DEP_CPP_DAN_P) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex25_03 - Win32 Debug"

DEP_CPP_DAN_P=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dan_pdgm.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\dan_pdgm.obj" : $(SOURCE) $(DEP_CPP_DAN_P) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\dit_sino.cpp

!IF  "$(CFG)" == "ex25_03 - Win32 Release"

DEP_CPP_DIT_S=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"log2.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\dit_sino.obj" : $(SOURCE) $(DEP_CPP_DIT_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex25_03 - Win32 Debug"

DEP_CPP_DIT_S=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"log2.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\dit_sino.obj" : $(SOURCE) $(DEP_CPP_DIT_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ex25_03.cpp

!IF  "$(CFG)" == "ex25_03 - Win32 Release"

DEP_CPP_EX25_=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"cpfsk.h"\
	{$(INCLUDE)}"dan_pdgm.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"sam_spec.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"thy_spec.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\ex25_03.obj" : $(SOURCE) $(DEP_CPP_EX25_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex25_03 - Win32 Debug"

DEP_CPP_EX25_=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"cpfsk.h"\
	{$(INCLUDE)}"dan_pdgm.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"sam_spec.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"thy_spec.h"\
	{$(INCLUDE)}"typedefs.h"\
	

"$(INTDIR)\ex25_03.obj" : $(SOURCE) $(DEP_CPP_EX25_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fft.cpp
DEP_CPP_FFT_C=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"fft.h"\
	

"$(INTDIR)\fft.obj" : $(SOURCE) $(DEP_CPP_FFT_C) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\fsk_spec.cpp

!IF  "$(CFG)" == "ex25_03 - Win32 Release"

DEP_CPP_FSK_S=\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sinc.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\fsk_spec.obj" : $(SOURCE) $(DEP_CPP_FSK_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex25_03 - Win32 Debug"

DEP_CPP_FSK_S=\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sinc.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\fsk_spec.obj" : $(SOURCE) $(DEP_CPP_FSK_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\log2.cpp
DEP_CPP_LOG2_=\
	{$(INCLUDE)}"log2.h"\
	

"$(INTDIR)\log2.obj" : $(SOURCE) $(DEP_CPP_LOG2_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\psd_est.cpp

!IF  "$(CFG)" == "ex25_03 - Win32 Release"

DEP_CPP_PSD_E=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\psd_est.obj" : $(SOURCE) $(DEP_CPP_PSD_E) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex25_03 - Win32 Debug"

DEP_CPP_PSD_E=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\psd_est.obj" : $(SOURCE) $(DEP_CPP_PSD_E) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\sam_spec.cpp

!IF  "$(CFG)" == "ex25_03 - Win32 Release"

DEP_CPP_SAM_S=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"sam_spec.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\sam_spec.obj" : $(SOURCE) $(DEP_CPP_SAM_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex25_03 - Win32 Debug"

DEP_CPP_SAM_S=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"sam_spec.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\sam_spec.obj" : $(SOURCE) $(DEP_CPP_SAM_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\sinc.cpp
DEP_CPP_SINC_=\
	{$(INCLUDE)}"sinc.h"\
	

"$(INTDIR)\sinc.obj" : $(SOURCE) $(DEP_CPP_SINC_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\uni_rand.cpp
DEP_CPP_UNI_R=\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\uni_rand.obj" : $(SOURCE) $(DEP_CPP_UNI_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

