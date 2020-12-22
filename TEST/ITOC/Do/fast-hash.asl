
///



  int pmaj = 1;


<<"%V $pmaj \n"



pmaj->info(1)



int jamp = 2;
jamp->info(1)

<<"%V $jamp \n"


int pmin = 3;
  
pmin->info(1)

<<"%V $pmin \n"

double lamp = 4.0;

lamp->info(1)  

<<"%V $lamp \n"

float paml = 5.0;

paml->info(1)  

<<"%V $lamp \n"

Vec V;


<<"%V $V \n"

V->info(1)



Mat M;


<<"%V $M \n"

M->info(1)

 var = "paml"

<<" $$var\n"

// var = "abc"
// $var = 57;

//char vs[5] = {'a','b','c','d','e'};

//<<"%c $vs \n"

//v=vs[2];
//<<"$vs $v\n"

char A='a';
char B='a';
char C='a';

<<"%c$C\n"
N= 10;
//vn = "%c${C}_%d${i}"
q=0
for (i = 0; i < N; i++) {
  B='a';
  for (j = 0; j < N; j++) {
     C='a';
   for (k = 0; k < N; k++) {
       vn = "%c${A}${B}${C}"
       $vn = q++;
        y = $vn
      <<"$vn $y\n"
      $vn->info(1)
      C++;
   }
 B++;
 }
 A++;
}


deb->info(1)
jeb->info(1)
jib->info(1)

// lets make 5 letter combos of a-e - all permutations
// and check hash of names


//<<" $abs\n"





exit()