
 S = functions()
 S->sort()
 <<"%(1,   , ,\n)$S\n"

 sz= Caz(S)

<<" we have $sz functions\n"

 int a = 6;
 float b = 2.718281828459045;
 double d = 40.0;
// cmplx c = {1,2};
   cmplx c;
   c->set(1,2);

<<"%V$c\n"

 V=variables()

 <<"%(1,   , ,\n)$V\n"


<<"$S[0]\n"
<<"$S[1]\n"
<<"$S[2]\n"
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