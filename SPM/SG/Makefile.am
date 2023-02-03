AM_CPPFLAGS = -I$(gasp_sys)/include -I../

gasp_libs = $(gasp_sys)/SI/df/libdf_asl.a $(gasp_sys)/SI/dsp/libdsp_asl.a $(gasp_sys)/SI/svar/libsvar_asl.a  $(gasp_sys)/SI/gscom/libgscom_asl.a


LDADD = $(gasp_libs) -lm

$(gasp_sys)/SI/df/libdf.a:
	$(MAKE) -C $(gasp_sys)/SI/df
$(gasp_sys)/SI/gspf/libgspf.a:
	$(MAKE) -C $(gasp_sys)/SI/gspf
$(gasp_sys)/SI/sp_lib/libsp.a:
	$(MAKE) -C $(gasp_sys)/SI/sp_lib

bin_PROGRAMS = sgr

SOURCES = sgr.cpp

EXTRA_DIST = sg_va.c sgt.c


install : $(OBJECTS)
	$(CC) -o  sgr -pg  -I$(gasp_sys)/include $(CFLAGS) $(LFLAGS) sgr.cpp $(LDADD) $(AM_CPPFLAGS)
	/usr/bin/install sgr $(gasp_sys)/bin

