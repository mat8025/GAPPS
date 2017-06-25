///
///  test color print
///
setdebug(1)

#define PRED '\033[1;31m'
#define PGREEN '\033[1;32m'
#define PYELLOW '\033[1;33m'
#define PBLUE '\033[1;34m'
#define PBLACK '\033[1;39m'
#define POFF  '\033[0m'


 <<" $(PGREEN) this is GREEN $(POFF) \n"
<<" this is default color \n"
<<" $(PBLUE) this is BLUE $(POFF) \n"
<<" $(PYELLOW) this is YELLOW $(POFF) \n"
<<" $(PRED) this is RED $(POFF) \n"

<<" \033[1;36m this is 36 $(POFF)\n"

for (i = 25 ; i<50 ; i++ ) {

 <<" \033[1;$(i)m this is $i $(POFF)\n"

}

 a= RED_;
 <<"$a\n"

 a= BLUE_;
 <<"$a\n"

svar w = "";

// w= "$(AND_)";
// <<"%V$w\n"

w = "$('PRED_')";

 <<"$w is this cool $(POFF)\n"

gr = "$('PGREEN_')";

 <<"$gr is this cool $(POFF)\n"

bl = "$('PGREEN_')";

 <<"$bl is this cool $(POFF)\n"

 <<"$('PRED_') is this cool $(POFF)\n"

 <<"$('PYELLOW_') is this cool $(POFF)\n"

 <<"$('PPURPLE_') is this cool $('POFF_')\n"




<<" done \n"