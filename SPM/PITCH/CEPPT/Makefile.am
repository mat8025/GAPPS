
AM_CPPFLAGS = -I$(gasp_sys)/include -I../../

gasp_libs = $(gasp_sys)/SI/df/libdf_asl.a $(gasp_sys)/SI/dsp/libdsp_asl.a $(gasp_sys)/SI/svar/libsvar_asl.a  $(gasp_sys)/SI/gscom/libgscom_asl.a

LDADD = $(gasp_libs) -lm



bin_PROGRAMS = ceppt

SOURCES = ceppt.cpp q_cpt.cpp quasi.h


install : $(OBJECTS)
	$(CC) -o  ceppt -pg  -I$(gasp_sys)/include $(CFLAGS) $(LFLAGS) ceppt.cpp q_cpt.cpp $(LDADD) $(AM_CPPFLAGS)
	/usr/bin/install ceppt $(gasp_sys)/bin
