///
///
///


//sdb(2,@pline,@trace)

  Pan p = 3.2;

<<"p = $p \n"

chkIn();

double e = 1.2345;

<<"$e \n"
float F[10]



F->info(1)

F[2] = 67;
<<"$F\n"

//sdb(2,@pline,@trace)
Vec V;

V->info(1)


  Vec V2(INT_,10,0,1);

  V2->info(1);

  <<"$V2\n"



  V2[3]= 77;
  
<<"$V2\n"


   V= V2;

V->info(1)
 V2->info(1);
 
<<"$V2\n"

<<"$V\n"


//sdb(2,@pline,@trace);


Vec V3;
V3->info(1);


   V[0:4:1] = V2[5:9:1]

<<"$V\n"
chkN(V[0],5)

 V3= V2[5:9:1]
<<"$V3\n"

 rng = Range(4,8,2)

<<"rng: %lx $rng  %ld $rng\n"
ds= dec2bin(rng);
<<"rng $(slen(ds)) $ds\n"

 rng = Range(5,9,4)

<<"rng: %lx $rng  %ld $rng\n"
ds= dec2bin(rng);
<<"rng $(slen(ds)) $ds\n"

chkN(V3[1],6)

chkOut();

exit()





 Siv D(INT_, 2, 2, 3);

 

 D->info(1);


  Str S("elle rentre");


  S->info(1);





<<"$S \n"

 S = "Je suis rentré"
 S->info(1);

<<"$S \n"


Mat M(INT_,5,4);

   M->info(1)


<<"$M \n"



