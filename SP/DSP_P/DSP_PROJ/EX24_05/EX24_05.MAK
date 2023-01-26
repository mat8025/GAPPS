# Microsoft Developer Studio Generated NMAKE File, Based on ex24_05.dsp
!IF "$(CFG)" == ""
CFG=ex24_05 - Win32 Debug
!MESSAGE No configuration specified. Defaulting to ex24_05 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "ex24_05 - Win32 Release" && "$(CFG)" !=\
 "ex24_05 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ex24_05.mak" CFG="ex24_05 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ex24_05 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ex24_05 - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "ex24_05 - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex24_05.exe"

!ELSE 

ALL : "$(OUTDIR)\ex24_05.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\bartpdgm.obj"
	-@erase "$(INTDIR)\cbitrev.obj"
	-@erase "$(INTDIR)\dit_sino.obj"
	-@erase "$(INTDIR)\ex25_04.obj"
	-@erase "$(INTDIR)\fft.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\log2.obj"
	-@erase "$(INTDIR)\psd_est.obj"
	-@erase "$(INTDIR)\sd_theor.obj"
	-@erase "$(INTDIR)\sinawgn.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\ex24_05.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_MBCS" /Fp"$(INTDIR)\ex24_05.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c\
 
CPP_OBJS=.\Release/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex24_05.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\ex24_05.pdb" /machine:I386 /out:"$(OUTDIR)\ex24_05.exe" 
LINK32_OBJS= \
	"$(INTDIR)\bartpdgm.obj" \
	"$(INTDIR)\cbitrev.obj" \
	"$(INTDIR)\dit_sino.obj" \
	"$(INTDIR)\ex25_04.obj" \
	"$(INTDIR)\fft.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\log2.obj" \
	"$(INTDIR)\psd_est.obj" \
	"$(INTDIR)\sd_theor.obj" \
	"$(INTDIR)\sinawgn.obj" \
	"$(INTDIR)\uni_rand.obj"

"$(OUTDIR)\ex24_05.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "ex24_05 - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\ex24_05.exe"

!ELSE 

ALL : "$(OUTDIR)\ex24_05.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\bartpdgm.obj"
	-@erase "$(INTDIR)\cbitrev.obj"
	-@erase "$(INTDIR)\dit_sino.obj"
	-@erase "$(INTDIR)\ex25_04.obj"
	-@erase "$(INTDIR)\fft.obj"
	-@erase "$(INTDIR)\gausrand.obj"
	-@erase "$(INTDIR)\gen_win.obj"
	-@erase "$(INTDIR)\log2.obj"
	-@erase "$(INTDIR)\psd_est.obj"
	-@erase "$(INTDIR)\sd_theor.obj"
	-@erase "$(INTDIR)\sinawgn.obj"
	-@erase "$(INTDIR)\uni_rand.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(OUTDIR)\ex24_05.exe"
	-@erase "$(OUTDIR)\ex24_05.ilk"
	-@erase "$(OUTDIR)\ex24_05.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_MBCS" /Fp"$(INTDIR)\ex24_05.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD\
 /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\ex24_05.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)\ex24_05.pdb" /debug /machine:I386 /out:"$(OUTDIR)\ex24_05.exe"\
 /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\bartpdgm.obj" \
	"$(INTDIR)\cbitrev.obj" \
	"$(INTDIR)\dit_sino.obj" \
	"$(INTDIR)\ex25_04.obj" \
	"$(INTDIR)\fft.obj" \
	"$(INTDIR)\gausrand.obj" \
	"$(INTDIR)\gen_win.obj" \
	"$(INTDIR)\log2.obj" \
	"$(INTDIR)\psd_est.obj" \
	"$(INTDIR)\sd_theor.obj" \
	"$(INTDIR)\sinawgn.obj" \
	"$(INTDIR)\uni_rand.obj"

"$(OUTDIR)\ex24_05.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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


!IF "$(CFG)" == "ex24_05 - Win32 Release" || "$(CFG)" ==\
 "ex24_05 - Win32 Debug"
SOURCE=..\sources\bartpdgm.cpp

!IF  "$(CFG)" == "ex24_05 - Win32 Release"

DEP_CPP_BARTP=\
	{$(INCLUDE)}"bartpdgm.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\bartpdgm.obj" : $(SOURCE) $(DEP_CPP_BARTP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_05 - Win32 Debug"

DEP_CPP_BARTP=\
	{$(INCLUDE)}"bartpdgm.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\bartpdgm.obj" : $(SOURCE) $(DEP_CPP_BARTP) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\cbitrev.cpp
DEP_CPP_CBITR=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	

"$(INTDIR)\cbitrev.obj" : $(SOURCE) $(DEP_CPP_CBITR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\dit_sino.cpp

!IF  "$(CFG)" == "ex24_05 - Win32 Release"

DEP_CPP_DIT_S=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"log2.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\dit_sino.obj" : $(SOURCE) $(DEP_CPP_DIT_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_05 - Win32 Debug"

DEP_CPP_DIT_S=\
	{$(INCLUDE)}"cbitrev.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"log2.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\dit_sino.obj" : $(SOURCE) $(DEP_CPP_DIT_S) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\ex25_04.cpp

!IF  "$(CFG)" == "ex24_05 - Win32 Release"

DEP_CPP_EX25_=\
	{$(INCLUDE)}"bartpdgm.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"sinawgn.h"\
	{$(INCLUDE)}"thy_spec.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\ex25_04.obj" : $(SOURCE) $(DEP_CPP_EX25_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_05 - Win32 Debug"

DEP_CPP_EX25_=\
	{$(INCLUDE)}"bartpdgm.h"\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fft.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"sinawgn.h"\
	{$(INCLUDE)}"thy_spec.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\ex25_04.obj" : $(SOURCE) $(DEP_CPP_EX25_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\fft.cpp

!IF  "$(CFG)" == "ex24_05 - Win32 Release"

DEP_CPP_FFT_C=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"fft.h"\
	

"$(INTDIR)\fft.obj" : $(SOURCE) $(DEP_CPP_FFT_C) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_05 - Win32 Debug"

DEP_CPP_FFT_C=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"dit_sino.h"\
	{$(INCLUDE)}"fft.h"\
	

"$(INTDIR)\fft.obj" : $(SOURCE) $(DEP_CPP_FFT_C) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\gausrand.cpp
DEP_CPP_GAUSR=\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\gausrand.obj" : $(SOURCE) $(DEP_CPP_GAUSR) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\gen_win.cpp
DEP_CPP_GEN_W=\
	{$(INCLUDE)}"gen_win.h"\
	{$(INCLUDE)}"misdefs.h"\
	

"$(INTDIR)\gen_win.obj" : $(SOURCE) $(DEP_CPP_GEN_W) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\log2.cpp
DEP_CPP_LOG2_=\
	{$(INCLUDE)}"log2.h"\
	

"$(INTDIR)\log2.obj" : $(SOURCE) $(DEP_CPP_LOG2_) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\sources\psd_est.cpp

!IF  "$(CFG)" == "ex24_05 - Win32 Release"

DEP_CPP_PSD_E=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\psd_est.obj" : $(SOURCE) $(DEP_CPP_PSD_E) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_05 - Win32 Debug"

DEP_CPP_PSD_E=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"fsk_spec.h"\
	{$(INCLUDE)}"psd_est.h"\
	{$(INCLUDE)}"thy_spec.h"\
	

"$(INTDIR)\psd_est.obj" : $(SOURCE) $(DEP_CPP_PSD_E) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\sd_theor.cpp

!IF  "$(CFG)" == "ex24_05 - Win32 Release"

DEP_CPP_SD_TH=\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sd_theor.h"\
	

"$(INTDIR)\sd_theor.obj" : $(SOURCE) $(DEP_CPP_SD_TH) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_05 - Win32 Debug"

DEP_CPP_SD_TH=\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sd_theor.h"\
	

"$(INTDIR)\sd_theor.obj" : $(SOURCE) $(DEP_CPP_SD_TH) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\sinawgn.cpp

!IF  "$(CFG)" == "ex24_05 - Win32 Release"

DEP_CPP_SINAW=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"sinawgn.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\sinawgn.obj" : $(SOURCE) $(DEP_CPP_SINAW) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "ex24_05 - Win32 Debug"

DEP_CPP_SINAW=\
	{$(INCLUDE)}"complex.h"\
	{$(INCLUDE)}"gausrand.h"\
	{$(INCLUDE)}"misdefs.h"\
	{$(INCLUDE)}"sig_src.h"\
	{$(INCLUDE)}"sinawgn.h"\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\sinawgn.obj" : $(SOURCE) $(DEP_CPP_SINAW) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\sources\uni_rand.cpp
DEP_CPP_UNI_R=\
	{$(INCLUDE)}"uni_rand.h"\
	

"$(INTDIR)\uni_rand.obj" : $(SOURCE) $(DEP_CPP_UNI_R) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

