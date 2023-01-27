AM_CPPFLAGS = -I$(gasp_sys)/include 

gasp_libs = $(gasp_sys)/SI/df/libdf.a $(gasp_sys)/SI/gspf/libgspf.a \
	$(gasp_sys)/SI/sp_lib/libsp.a



LDADD = $(gasp_libs) -lm

$(gasp_sys)/SI/df/libdf.a:
	$(MAKE) -C $(gasp_sys)/SI/df
$(gasp_sys)/SI/gspf/libgspf.a:
	$(MAKE) -C $(gasp_sys)/SI/gspf
$(gasp_sys)/SI/sp_lib/libsp.a:
	$(MAKE) -C $(gasp_sys)/SI/sp_lib

bin_PROGRAMS = rms_zx
noinst_PROGRAMS = rms

vars :
	echo gasp_sys $(gasp_sys) 
