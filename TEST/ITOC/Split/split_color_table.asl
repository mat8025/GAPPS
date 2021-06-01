///
///
///

<|Use_=
Demo  of sscan;
///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");


chkIn(_dblevel)




T="abcXXdefXXefgXXhijXklm"
S=split(T,"XX")

<<"$S\n"



A=ofr("color_table.txt")

n = 0
pass  = 0
fail = 0

svar col
str f_field
int nc = 0;

  while (1) {

   S= readline(A)

   if (check_eof(A) ) {
      <<"EOF found\n";
     break;
   }
   
<<" $S \n";

    col = split(S,",");
    
//<<" $S \n"

    f_field = col[0];

//<<" $f_field $(typeof(f_field)) \n"
<<" <$col[0]> <$col[1]> <$col[2]> <$col[3]> <$col[4]>\n"

   nc++;
   
   fv4 =S[0]->gfv(4,",");

   fv2 =S->gfv(2,",");
   
   fv1 =S->gfv(1,",");

   
 <<"%V |$fv1| |$fv2| [${fv4}]\n"

  }

cf(A)


  CT=getHTMLcolors();

<<"$CT[0] \n $CT[47] \n"

  nc = Caz(CT)
<<"$nc \n"

int mat = 0;
  for (i= 0; i <nc ; i++) {
    wi = spat(CT[i],"Red",0,1,&mat);
    //<<"$i $wi \n"
    if (mat) {
<<"$CT[i] \n";
    }
    else {
//<<"NOT BLUE $CT[i]\n"
    }
  }


chkT(1)
chkOut()