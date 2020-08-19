///
///
///


A=ofr("ASLMAN");
int match = 0;
int kfix =0;
while (1) {

  C=readline(A);
  if (feof(A))
      break;

   S= split(C);
<<"$C\n"
  if (S[0] @= ".(x") {
   C=readline(A);
   spat(C,"_",0,1,&match);
//
 
   if (match) {
    kfix++;
    fname = ssub(C,"_","",0)
   // <<"$kfix $C $fname\n"
   }
   else {
     fname = C;
   }
<<"$fname\n"
  
  }

}


<<"%V $kfix\n"