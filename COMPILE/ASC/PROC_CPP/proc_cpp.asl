
///
///  proc args ==> cpp ?
///

// chkIn(_dblevel);



  long cmain = -45;
  


 void woo(Str c_dir)
  {

  int la = 1;

  Str the_dir ="W";

  the_dir = c_dir;

<<"%V $the_dir $c_dir\n"
  if (the_dir == "West") {
    <<" $the_dir is Best \n"
  }
  if (the_dir == "East") {
    <<" $the_dir is least \n"
  }

 }


int  addem(int a, int b)
{
  int c;
  c= a+b;
<<"%V $a + $b = $c\n";
  return c;

}



<<" after procs start of main script %v $cmain \n";




  cmain=addem (47,79);

<<" added 47 and 79 and got $cmain\n";


  int i = 0
  int j = 2
  short k = 65; // terbium
  
  float d = 3.142  // ;

<<"%V $i $j $k \n";

  if ( i  && j) {

  <<"fold 0 %V $i $j\n";

  chkTrue(1);

  }

<<" PI is approx %V $d $k\n"
  j.pinfo();
  chkN(j,2);




  <<"Can we see %V $i $j $d\n";

  Str mydir = "West";


<<"%V $mydir \n";

   woo(mydir);

   cmain=addem (47,79);
   j = 0;
   while (1) {

     j++;

    if (j> 3) {
     break;
    }

   }

<<" break out of while $j\n";
   k = -1;
   do {

      k++;
      
   }
   while ( !(k > 5)) 




<<" Do While  $k > 5 \n"

  k = 0
   do {

      k++;
      
   }
   while ( k < 5) 

<<" Do While $k >= 5 \n"


   for (j= 0; j < 5; j++) {

<<"for loop $j\n";
   }

<<" end of for loop %V $j $k \n";
<<"trying forever loop\n";
j = 0;
   for ( ; ;  ) {
     j++;
     k++;
<<"forever loop $j\n";
    if (j>3) {
        break;
	}
   }


<<" end of this script %V $j $k $cmain \n";


 exit(0);