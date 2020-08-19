///  List VMF functions and descriptions


 S = vfunctions()
 S->sort()
 <<"%(1,   , ,\n)$S\n"

 sz= Caz(S)

<<" we have $sz functions\n"

  int md = 0;


 for (i = 0; i < sz; i++) {
    C= split(S[i],",")
    csz= Caz(C)
    missd = 0;
    if (C[1] @= " ") {
     missd =1;
     md++;
    }
// <<"$csz $missd <$C[0]> <$C[1]>\n"
 }

<<"%V$md missing descriptions \n" 