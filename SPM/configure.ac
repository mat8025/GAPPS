dnl Process this file with autoconf to produce a configure script.
AC_INIT(GAPPS,SPM)
AM_INIT_AUTOMAKE[]
AC_CONFIG_SRCDIR(RMS/rms.cpp)

dnl Arbitrary release number

AM_CONFIG_HEADER(gasp-conf.h)
#AC_CONFIG_COMMANDS_POST ([ls -l /usr/local/GASP/lib])
dnl dont' make this specific
AC_PREFIX_DEFAULT(/usr/local/GASP)
dnl AC_CONFIG_FILES([Makefile]) 
dnl Checks for programs.
AC_PROG_CC
AC_PROG_CXX
AM_PROG_CC_STDC
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PROG_RANLIB

dnl Checks for header files.
AC_PATH_XTRA
AC_HEADER_STDC
AC_HEADER_DIRENT
AC_CHECK_HEADERS(fcntl.h sgtty.h sys/file.h sys/ioctl.h sys/time.h unistd.h termios.h)
AC_CHECK_HEADERS(endian.h machine/endian.h sys/isa_defs.h, break)
AC_CHECK_HEADERS(ncurses.h curses.h, break)

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_C_INLINE
AC_HEADER_TIME
AC_STRUCT_TM

dnl Checks for library functions.
AC_PROG_GCC_TRADITIONAL
AC_TYPE_SIGNAL
AC_FUNC_VFORK
AC_CHECK_FUNCS(select strstr uname mkdir vasprintf vsnprintf)
AC_CHECK_FUNCS(getcwd getwd, break)
AC_CHECK_LIB(ncurses, cbreak,,, -ltermcap)
AC_CHECK_LIB(curses, cbreak,,, -ltermcap)
AC_CHECK_LIB(dl,dlclose,,, -ldl)
dnl CFLAGS="${CFLAGS+$CFLAGS }"

dnl CFLAGS="-pg -O2 -fpermissive"
CFLAGS="-pg -g  -fpermissive"
dnl CXXFLAGS="-pg -O2 -fpermissive"
CXXFLAGS="-pg -g  -fpermissive"
CC="g++"

CXX="g++"


AC_SUBST(gasp_sys, /usr/local/GASP/gasp)

dnl  execute this from a build directory in this directory

echo gasp_sys $gasp_sys


dnl SI then XGS 
AC_OUTPUT([RMS/Makefile  SG/Makefile PITCH/Makefile
                         PITCH/GRPT/Makefile
                         PITCH/QUASI/Makefile			 
			 PITCH/CEPPT/Makefile
			 Makefile ]  )


dnl set up links prior to make
        pwd
        dir=`pwd`
dnl        ln -s build/include include 
        echo $dir

dnl        make extract

dnl  add checks to see if  links are done
         echo "where are we?"
         pwd

dnl check for ceppt, rms, sg ??
dnl AC_CHECK_FILE(rms,[ls -l RMS],[echo "spm not done"])

