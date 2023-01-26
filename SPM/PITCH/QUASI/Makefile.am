INCLUDES = -I$(top_srcdir)/include

gasp_libs = $(top_builddir)/SI/df/libdf.a $(top_builddir)/SI/gspf/libgspf.a \
	$(top_builddir)/SI/sp_lib/libsp.a

LDADD = $(gasp_libs) -lm

$(top_builddir)/SI/df/libdf.a:
	$(MAKE) -C $(top_builddir)/SI/df
$(top_builddir)/SI/gspf/libgspf.a:
	$(MAKE) -C $(top_builddir)/SI/gspf
$(top_builddir)/SI/sp_lib/libsp.a:
	$(MAKE) -C $(top_builddir)/SI/sp_lib

bin_PROGRAMS = quasi pcon

pcon_SOURCES = q_con.c q_rule.c pcon.c

quasi_SOURCES = quasi.c q_cpt.c q_con.c q_rule.c q_lib.c

EXTRA_DIST = quasi.h
