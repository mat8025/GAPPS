#include "debug.asl"



if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}


chkIn()
chkT(1)



ulong J1 = 77;

double dow = 5;


<<"%V $J1 $dow \n"

<<"$(typeof(J1)) \n"

J1 = J1 - dow;

<<"$(typeof(J1)) \n"

// now types should remain as declared
// not demoted/promoted


J1 *= dow;


<<"$J1 $(typeof(J1)) \n"

tul = typeof(J1);

<<"$tul\n"

chkStr(tul,"ULONG")
J1 -= dow;


<<"$J1 $(typeof(J1)) \n"

tul = typeof(J1);

<<"$tul\n"

chkStr(tul,"ULONG")



int Htog[10];

int mwc = 1;

    for (mwc = 0; mwc < 5; mwc++) {
               Htog[mwc] = !Htog[mwc];
	       k= Htog[mwc];
	       <<"toggle operate on entire column? <|$Htog[mwc]|> $mwc $k \n";
           Htog[mwc] = !Htog[mwc];
	       k= Htog[mwc];
	       <<"toggle operate on entire column? <|$Htog[mwc]|> $mwc $k \n";
	       k= Htog[2];
	       <<"toggle operate on entire column? <|$Htog[2]|> $mwc $k \n";	       	       

   }


chkOut();
exit();