

///
///
///
  srcfile = "arrayele.asl";
  
  A=ofile(srcfile,"r+")

 <<[2]"opened for read/write? $A\n"

  found_vers =0;

long where;
Str T;
Svar L;
Str cvers;
  fseek(A,0,0);
Str w1;
for (i = 0; i < 20;i++) {
   
   T = readline(A);
   
<<"$i line is $T \n"

   where = ftell(A)
   L = Split(T);
   sz = Caz(L);
//   <<"sz $(caz(L)) $L\n"

if (sz >2) {
     w0= L[0];
     w1= L[1];
<<[2]"$where $i w0 <|$w0|>   w1 <|$w1|> $sz $L[0] $L[1] \n"

    if (scmp(L[1],"@vers")) {
    //if (scmp(w1,"@vers")) {
     found_vers =1;
     cvers = w1;
     break;
   }
   }
   found_where = where;
  }



<<"%V $found_vers $i $cvers \n"