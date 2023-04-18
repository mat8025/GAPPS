# "$Id: Makefile.am,v 1.3 2001/04/23 01:02:40 mark Exp mark $";

# we have shared libs for window coms and signal processing lib

# asl can open dynamic libs for stat, audio, image, ann and hmm

EXTRA_DIST = update.sh

# how to optionally link with mysqlclient? LD_LIBRARY? - do this in our sql dll
#mysql =   -L/usr/lib/mysql/  -lmysqlclient 

#LDADD = $(gasp_libs) -L../../lib -lspe_asl -ldf_asl -ldsp_asl -lap_asl -lgscom_asl -lwcom_asl -lm -ldl -lpthread 

LFLAGS =  -fPIC -DPIC -Wall  -I../../libs -I$(gasp_sys)/include -I/usr/include  -c

LDADD = -L$(gasp_sys)/lib  -lprep_asl  -lspe_asl -loo_asl -lthreads_asl -lrdp_asl -licode_asl -lopera_asl -lpexpnd_asl -larray_asl -lvec_asl -lmat_asl \
	-lfop_asl -lvsh_asl -lnum_asl -lstr_asl -lrecord_asl \
	-lspil_asl -lvmf_asl -ltest_asl -ldbug_asl -lmath_asl -ldf_asl -lds_asl -lsvar_asl -llist_asl -ldsp_asl -lpan_asl -lgscom_asl -lwcom_asl -lm -ldl -lpthread

LDADDX = -L$(gasp_sys)/lib  -lprep_aslx  -lspe_aslx -loo_aslx -lthreads_aslx -lrdp_aslx -licode_aslx -lopera_aslx -lpexpnd_aslx -larray_asl -lvec_asl -lmat_aslx \
	-lfop_aslx -lvsh_aslx -lnum_aslx -lstr_aslx -lrecord_aslx \
	-lspil_aslx -lvmf_aslx -ltest_aslx -ldbug_aslx -lmath_aslx -ldf_aslx -lds_aslx -lsvar_aslx -llist_aslx -ldsp_aslx -lpan_aslx -lgscom_aslx -lwcom_aslx -lm -ldl -lpthread 


bin_PROGRAMS = asl 


asl_SOURCES = asl.cpp version.cpp bfilter.cpp build_version.cpp build_date.cpp



# if spe is shared -- Fpic -- function symbols resolved

# need -rdynamic if using dynamic libs
AM_CFLAGS = -O -rdynamic  $(LDADD)
AM_CPPFLAGS = -O -rdynamic  -I$(gasp_sys)/include  $(LDADD)


# 
# put exe in the gasp/bin not build/bin

install : $(asl_OBJECTS)
	echo doing install $(gasp_sys)  ldadd $(LDADD)
	$(CC) -o  asl -pg   -I$(gasp_sys)/include  $(asl_OBJECTS) $(LDADD) 
	/usr/bin/install asl $(gasp_sys)/bin

update : $(asl_OBJECTS)
	echo doing update
	./update.sh
	$(CC) -o  asl -pg  -I$(gasp_sys)/include $(asl_OBJECTS) $(LDADD)
	/usr/bin/install asl $(gasp_sys)/bin

installx : $(asl_OBJECTS)
	$(CC) -o  aslx -g  -I$(gasp_sys)/include $(asl_OBJECTS) $(LDADDX)
	/usr/bin/install aslx $(gasp_sys)/bin


mvars :
	echo  top_builddir $(top_builddir) top_srcdir $(top_srcdir) $(gasp_sys)
