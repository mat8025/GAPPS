AM_CPPFLAGS = -I$(gasp_sys)/include -I../

gasp_libs = $(gasp_sys)/SI/df/libdf_asl.a 	$(gasp_sys)/SI/dsp/libdsp_asl.a $(gasp_sys)/SI/svar/libsvar_asl.a  $(gasp_sys)/SI/gscom/libgscom_asl.a



LDADD = $(gasp_libs) -lm


bin_PROGRAMS = rms_zx 

SOURCES = rms_zx.cpp

#AM_CFLAGS = -O -rdynamic

#echo $(OBJECTS)
# 
# put exe in the gasp/bin not build/bin
install : $(OBJECTS)
#	$(CC) -o  rms_zx -pg $(CFLAGS) $(LFLAGS) $(OBJECTS) $(LDADD)
	$(CC) -o  rms_zx -pg  -I$(gasp_sys)/include $(CFLAGS) $(LFLAGS) rms_zx.cpp $(LDADD) $(AM_CPPFLAGS)
	/usr/bin/install rms_zx $(gasp_sys)/bin
