

 float W[2] = {2,3};

<<"W= $W\n"


 int IV[] = {2,3,4,5,6,7};


<<"%V$IV\n"
<<"vecsz = $(Caz(IV))\n"

 cmplx C[] = {(2,3),(4,5),(6,7)};


<<"$C\n"


exit()
/{
   V = W * {2,3}

<<"V= $V\n"


cmplx C[2] = {{2,3},{4,5}};

<<"C= $C\n"

// cmplx a = {2,3}; // crash


cmplx a;

      a->set(2,3)
      

<<"%V$a\n"

      b = a * {2,3};

<<"%V$b\n"
/}