///
///

include "debug.asl"
debugON()

Svar  fruits;
Svar  fish;


 A=  ofr("foods-fish.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

  R_fish= readRecord(A,@del,',')
  cf(A)

  R_fish->info(1)

  Nrecs = Caz(R_fish);
  Ncols = Caz(R_fish,0);

 A=  ofr("foods-fruits.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

  R_fruits= readRecord(A,@del,',')
  cf(A)
  
  Nfruits = Caz(R_fruits);
  Ncols = Caz(R_fruits,0);


  y = "fish"
  
  z= "R_$y"
  <<"z $z  $(typeof(z))\n"  
  rfd = $z ;

<<"rfd $(typeof(rfd))\n"
 <<"%V $rfd[0]\n"
 <<"%V $rfd[1]\n"
 <<"%V $rfd[2]\n"

  for (i= 3; i < 7; i++) {

<<"$i $rfd[i][0]\n"

  }

  for (i= 3; i < 7; i++) {

<<"$i $rfd[i][3]\n"

  }


  y = "fruits"
  
  z= "R_$y"
  rfd2 = $z ;

 <<"rfd2 $(typeof(rfd2))\n"
 <<"%V $rfd2[0]\n"
 <<"%V $rfd2[1]\n"
 <<"%V $rfd2[2]\n"

  for (i= 3; i < 7; i++) {

<<"$i $rfd2[i][0]\n"

  }

  for (i= 3; i < 7; i++) {

<<"$i $rfd2[i][3]\n"

  }




 y = "spices"

 A=  ofr("foods-${y}.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

  w= "R_$y"
  <<"<|$w|> \n"

  $w= readRecord(A,@del,',')
  <<"$w $(typeof(w))\n"
  cf(A)

//sdb(1,@trace);
//   rfd3 = $w
  w->info(1)
  //$w->info(1)
 // rdf3->info(1)
  R_spices->info(1)
  
int  c[] = { 0,1,2,3,4,5,6,7,8,9,77 };

<<"$c\n"

    ptr pc;

    wc = "c"

    pc = &$wc;

    pc->info(1)

svar S;

  S[0] = "C'est";
  S[1] = "va";
  S[2] = "tres";
  S[3] = "bien";  


S->info(1)

svar val;

<<"$S[2] \n"

    ws = "S";

  ptr p ;

  p = &S;

  p->info(1)


   val = p[2];


  <<"[2] $val\n"



    W= S;

<<"W $W\n"
W->info(1)
S->info(1)


   //

    p = &$ws;

    p->info(1)


    sz=Caz($ws);

   S->info(1)

<<"size of $ws is $sz\n"
  i = 2;
  val = p[i];
  <<"$i $val\n"

  p->info(1)

    for (i= 0; i < sz; i++) {

     val = p[i];
     val->info(1)
     S->info(1)
     <<"$i $val\n"

    }



       p = &$w;


    sz=Caz($w);

<<"size of $w is $sz\n"
    

    p->info(1)

     val = p[2];
     val->info(1)
     <<"record 2? $val[0]\n"

//e 

svar sval

    for (i= 0; i < sz; i++) {

     sval = R_spices[i];
   //  val->info(1)
   //  R_spices->info(1)
  //   p->info(1)
      sval->info(1)
     <<"$i $sval\n"

    }

svar fval;


     p->info(1)

<<"////\n"
    for (i= 0; i < sz; i++) {
     fval[0] ="xx"
     fval[1] ="yy"
     fval = p[i];    // should be pushrecele -- since p --> record var
   //  val->info(1)
     R_spices->info(1)
     p->info(1)
     <<"$i $fval\n"

    }


exit()

// val = $w;
 val = rfd;
<<"%V $val[1]\n"




// svar T= { "hey", $w,}

Record T;
      //      T= $w;
      
        T= R_spices;
	
    for (i= 0; i < Nspices; i++) {

        <<"$i $T[i][0]\n"

    }
    
S=Variables()
<<"%(1,,,\n)$S\n"



//rdf3->info(1)

//===========================//
/{
  y = "fish"
  
  z= "R_$y"
    <<"z $z  $(typeof(z))\n"  
  rfd4 = $z ;

<<"rfd4 $rfd4[0] $(typeof(rfd4))\n"
 <<"%V $rfd4[1]\n"
 <<"%V $rfd4[2]\n"

    y = "fish"
    z= "R_$y"
    <<"z $z  $(typeof(z))\n"
    rfd3 = $z ;
    <<"rfd3 $rfd3 $(typeof(rfd3))\n"
    Nrows = Caz(rfd3);
   <<"%V $Nrows\n"
    for (i= 0; i < Nrows; i++) {
      <<"$i $rfd3[i][0]\n"
    }
/}


exit()

 fruits[0] = "apple"
 fruits[1] = "pear"


 fish[0] = "salmon"
 fish[1] = "trout"

 <<"$fish[0] \n"

<<"$fruits[1] \n"

fd = fish[0];

<<"%V $fd\n"

 y = "fish"
 
fd = ${y}[0];

<<"%V $fd\n"

 z = "fruits"
 
ffd = $z;

<<"%V $ffd\n"
<<"%V $ffd[1]\n"
<<"%V $ffd[0]\n"


//        food_wrd = "$RF[i][0]";