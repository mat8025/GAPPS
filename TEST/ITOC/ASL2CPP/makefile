
gasp_sys = /home/mark/gasp-CARBON

LFLAGS =  -fPIC -DPIC -Wall  -I../../libs -I$(gasp_sys)/include -I/usr/include  -c

# how many libs need to be loaded for cpp  produced via asl

LDADD = -L$(gasp_sys)/lib  \
	-lvec_asl \
	-lmat_asl \
	-lfop_asl \
	-lnum_asl \
	-lstr_asl \
	-lrecord_asl \
	-lspil_asl \
	-ltest_asl \
	-lmath_asl \
	-ldf_asl \
	-lds_asl \
	-lsvar_asl \
	-llist_asl \
	-lgslists_asl \
	-ldsp_asl \
	-lpan_asl \
	-lgscom_asl \
	-lwcom_asl \
	-lm -ldl -lpthread


asl2cpp: asl2cpp.asc
	g++ -x c++ -fpermissive  -rdynamic -o asl2cpp asl2cpp.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

proc_cpp: proc_cpp.asc
	g++ -x c++ -fpermissive  -rdynamic -o proc_cpp proc_cpp.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

if_cpp: if_cpp.asc
	g++ -x c++ -fpermissive  -rdynamic -o if_cpp if_cpp.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

scut: scut.asc
	g++ -x c++ -fpermissive  -rdynamic -o scut scut.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

scmp: scmp.asc
	g++ -x c++ -fpermissive  -rdynamic -o scmp scmp.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

scmp2: scmp2.asl
	g++ -x c++ -fpermissive  -rdynamic -o scmp2 scmp2.asl  -I$(gasp_sys)/include -ldl  $(LDADD) 

tleg: tleg.asc
	g++ -x c++ -fpermissive  -rdynamic -o tleg tleg.asc  -I$(gasp_sys)/include -ldl  $(LDADD)


navi: navi.asc
	g++ -x c++ -fpermissive  -rdynamic -o navi navi.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

cprintf: cprintf.asc
	g++ -x c++ -fpermissive  -rdynamic -o cprintf cprintf.asc  -I$(gasp_sys)/include -ldl  $(LDADD)


str: str.asc
	g++ -g -x c++ -fpermissive  -rdynamic -o str str.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

svar: svar.asc
	g++ -g -x c++ -fpermissive  -rdynamic -o svar svar.asc  -I$(gasp_sys)/include -ldl  $(LDADD)


svar2: svar2.asc
	g++ -g -x c++ -fpermissive  -rdynamic -o svar2 svar2.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

sivvec: sivvec.asc
	g++ -g -x c++   -fpermissive  -rdynamic -o sivvec sivvec.asc  -I$(gasp_sys)/include -ldl  $(LDADD)

#	-ldbug_asl \
#	-lspe_asl \
#       -lopera_asl \
#	-lprep_asl \
#	-lspe_asl \
#	-licode_asl \
#	-loo_asl \
#	-lopera_asl \
#	-lpexpnd_asl \
#	-lvmf_asl \
#	-lvsh_asl \
#	-larray_asl \
