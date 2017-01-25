# Microsoft Developer Studio Project File - Name="ex23_02" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=ex23_02 - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "ex23_02.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ex23_02.mak" CFG="ex23_02 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ex23_02 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ex23_02 - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "ex23_02 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "ex23_02 - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "ex23_02 - Win32 Release"
# Name "ex23_02 - Win32 Debug"
# Begin Source File

SOURCE=..\sources\anlgfilt.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\ar_est.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\ar_proc.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\autometh.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\bilinear.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\cmpxpoly.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\complex.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\dir1_iir.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\ex23_02.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\filtfunc.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\gausrand.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\iir_dsgn.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\laguerre.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\levin.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\numinteg.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\pause.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\polefilt.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\polefunc.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\poly.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\polydiv.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\toeplitz.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\uni_rand.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\unq_iir.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\unwrap.cpp
# End Source File
# Begin Source File

SOURCE=..\sources\yulewalk.cpp
# End Source File
# End Target
# End Project
