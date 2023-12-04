///
///  test color print
///

<<"Demo  of line color print  ESC codes\n"
///////////////////////

filterDebugMode(REJECT_)

#include "debug.asl";



if (_dblevel >0) {
   debugON()
}

   
   chkIn(_dblevel); 
   
ignoreErrors()

#define PRED '\033[1;31m'
#define PGREEN '\033[1;32m'
#define PYELLOW '\033[1;33m'
#define PBLUE '\033[1;34m'
#define PBLACK '\033[1;39m'
#define POFF  '\033[0m'

 dbmode =filterDebugMode(REJECT_ALL_)
<<"%V $dbmode\n"

Pred = "\033[1;31m"
Pblue = "\033[1;34m"
Pgreen = "\033[1;32m"
Poff  = "\033[0m"

prompt = "go_on? : [y,n,q]"
action = 0 ;  // 1 ask  and return input 0 don't ask just continue  cntrl D will reurn option to quit program


<<"  \033[1;32m this is GREEN  \033[0m \n"

// TBF 10/21/23  -- expand print of expressions / functions buggy
 fileDB(ALLOW_,"param,ds_getvar")
<<"these expressions should be seen  calc if 5*2 = $(5*2)  cos(5.0/2.3) = $(cos(5.0/2.3)) sin(0.5) = $(sin(0.5)) tan(4.0/2.3) = $(tan(4.0/2.3)) \n"

 ans=ask(prompt,action)

<<"answered $ans\n" ; if (ans == "q") exit(-1);



 ans=ask(prompt,action)
 if (ans == "q") exit(-1);

<<" $(Pred) this is Red $(Poff) \n"

<<" $(Pblue) this is Blue $(Poff) \n"

<<" $(Pgreen) this is Green $(Poff) \n"







ans= ask("colors OK?",action)
<<"answered $ans\n" ; if (ans == "q") exit(-1);

 <<" $(PGREEN_) this is GREEN $(POFF_) \n"

 <<" $(PRED_) this is RED $(POFF_) \n"
 fileDB(ALLOW_,"param,ds_getvar")
 <<" $(PGREEN) this is GREEN $(POFF) \n"

<<" $(PYELLOW) this is YELLOW $(POFF) \n"


ans= ask("color define OK?",action)
<<"answered $ans\n" ; if (ans == "q") exit(-1);


 ans= ask(prompt,action)

<<" $(\"\033[1;31m\") this is RED $(sin(1.0))  $(\"\033[0m\")\n"

 ans= ask(prompt,action)

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

w = "$(PRED_) abc";

w.pinfo()

<<"%V $w\n"

ans=ask(prompt,action)

 <<"$w is this cool $(POFF_)\n"

ans=ask(prompt,action)
gr = "$(PGREEN_)";

 <<"$gr is this cool $(POFF_)\n"

exit()


bl = "$(PGREEN_)";

 <<"$bl is this cool $(POFF)\n"

 <<"$(PRED_) is this cool $(POFF)\n"

 <<"$('PYELLOW_') is this cool $(POFF)\n"

// <<"$('PPURPLE_') is this cool $('POFF_')\n"




<<" done \n"