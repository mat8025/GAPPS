
<|Use_=
 view and select turnpts
 create read tasks   
///////////////////////
|>

                                                                        
#include "debug"

if (_dblevel >0) {
  debugON()
    <<"$Use_\n"   
}


 svar Wval;


    tp_file = "CUP/bbrief.cup"
   
A=  ofr(tp_file);

 if (A == -1) {
  <<" can't open file   \n";
    exit();
 }
Ntp =0;
while (1) {


           nwr = Wval<-ReadWords(A,0,',')
	   //nwr = Wval<-ReadWords(A,0)


          if (nwr <= 0) {
	  <<"EOF $nwr\n"
	      break
            }
	  if (nwr > 6) {
Ntp++;
<<"$Ntp $nwr <|$Wval[0]|>  $Wval\n"

}


}


<<" Read $Ntp turnpts \n"