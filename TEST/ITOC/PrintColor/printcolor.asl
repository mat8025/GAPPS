///
///  test color print
///
<|Use_=
Demo  of line color print  ESC codes
///////////////////////
|>


#include "debug.asl";



if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}

   
   chkIn(_dblevel); 
   
ignoreErrors()
/*
#define PRED \033[1;31m
#define PGREEN \033[1;32m
#define PYELLOW '\033[1;33m'
#define PBLUE '\033[1;34m'
#define PBLACK '\033[1;39m'
#define POFF  \033[0m
*/

Pblue = "\033[1;34m"
Pgreen = "\033[1;32m"
Poff  = "\033[0m"


<<"  \033[1;32m this is GREEN  \033[0m \n"

 <<" $(PGREEN) this is GREEN $(POFF) \n"

 <<" $(Pgreen) this is Green $(Poff) \n"

 <<" $(5*2) this is RED $(sin(1.0)) \n"

<<" $(\"\033[1;31m\") this is RED $(sin(1.0))  $(\"\033[0m\")\n"
 
 <<" $(PRED_) this is RED $(POFF_) \n"

<<" $(PGREEN_) this is GREEN $(POFF_) \n"

<<" $(PYELLOW_) this is YELLOW $(POFF_) \n"



 <<" $(Pblue) this is Blue $(Poff) \n"

 <<" $(Pblue) this is Blue $(Poff) \n"



<<"Black ?\n"




<<" this is default color \n"
<<" $(PBLUE_) this is BLUE $(POFF_) \n"
<<" $(PYELLOW_) this is YELLOW $(POFF_) \n"
<<" $(PRED_) this is RED $(POFF_) \n"

<<" \033[1;36m this is 36 $(POFF)\n"

for (i = 25 ; i<50 ; i++ ) {

 <<" \033[1;$(i)m this is $i $(POFF_)\n"

}

 a= RED_;
 <<"$a\n"

 a= BLUE_;
 <<"$a\n"

svar w = "";

// w= "$(AND_)";
// <<"%V$w\n"

w = "$(PRED_)";

 <<"$w is this cool $(POFF_)\n"


gr = "$(PGREEN_)";

 <<"$gr is this cool $(POFF_)\n"

exit()


bl = "$(PGREEN_)";

 <<"$bl is this cool $(POFF)\n"

 <<"$(PRED_) is this cool $(POFF)\n"

 <<"$('PYELLOW_') is this cool $(POFF)\n"

// <<"$('PPURPLE_') is this cool $('POFF_')\n"




<<" done \n"