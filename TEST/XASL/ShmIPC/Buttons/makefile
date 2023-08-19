
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


buttons: buttons.asc
	g++ -x c++ -fpermissive  -rdynamic -o buttons buttons.asc  -I$(gasp_sys)/include -ldl  $(LDADD) -lplot_asl



