//%*********************************************** 
//*  @script svar_procarg.asl 
//* 
//*  @comment test svar as arg
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium [asl 6.2.56 C-He-Ba]                           
//*  @date Mon Jun  8 21:01:14 2020 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
;
hold_dbl = _dblevel;
_dblevel = 0;

<|Use_=
  Demo svar type use
|>


#include "debug"

if (_dblevel >0) {
   debugON()
    <<"$Use_\n"   
}

    allowErrors(-1)

_dblevel = hold_dbl ;

   chkIn();

   svar E[] = { "the first ten elements are:", "H", "He", "Li", "Be" ,"B" ,"C", "N", "O", "F", "Ne"  };
   
   <<"$E\n"; 
   <<"$E[1] \n"; 


chkStr(E[1],"H"); 

  Ntp_id =0;

class Turnpt 
 {

 public:

  str w1;
  str w2;
  str w3;
  int id;

 cmf TPset (svar wval) 
   {

<<"TPset %V $_cmf $wval \n"

      wval<-pinfo()
<<"0: $wval[0] \n 1: $wval[1] \n 2: $wval[2] \n 3: $wval[3] \n 4: $wval[4] \n"

     w1=wval[1]; // wayp 
    
     <<"%V$w1\n"

     chkStr(w1,"H")

w2=wval[2]; // wayp 
    
     <<"%V$w2\n"

     chkStr(w2,"He")
   }

// - default cons works?

 cmf Turnpt()
    {
            Ntp_id++;
	    id = Ntp_id;
      w1 =" ";
    }

}
//==========================//





void sopa (svar wval)
{
<<"$_proc \n"
wval<-pinfo()

str sv;

 sv= wval[1];

 chkStr(sv,"H")

<<": $wval[0] 1: $wval[1] \n 2: $wval[2] \n 3: $wval[3] \n 4: $wval[4] \n"

<<"%V $sv\n"

 sv2= wval[2];

<<"%V $sv2\n"
 chkStr(sv2,"He")
}


 sopa(E)

Turnpt T;


 T->TPset(E)





Turnpt VT[3];


 VT[0]->TPset(E)

 VT[1]->TPset(E)



chkOut()


/*

 cmf Turnpt()
    {
            Ntp_id++;
	    id = Ntp_id;
      w1 =" ";
    }
*/



