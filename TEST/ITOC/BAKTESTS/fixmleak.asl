checkMemory(1);

setdebug(1,"keep","trace","showresults")

filterDebug(0,"args")


proc addf(a,b)
{
   c= a+b;
   return c;
}


str s="xx";
int sum = 0;
i=0;
    //for (i= 0; i < 10; i++) {
  //  while (1) {
j= 0;
float y ;
float z;
float x ;
float w;
N= atoi(_clarg[1]);

        Mu = memused();
        last_Mu = Mu;

char nv[20];
float ST[20];
int ok;





int nmem_changes =0;


do {

      Mu= memused(); // does not leak
//  <<"begin $mu \n"

      y = (i *.2);
      z = (i*.3);
      s="$i";
      sz=Caz(nv); // does not leak
  //    S=testargs(0,y,x,s,nv,sz); // does not leak
  //    ok=scpy(nv,s);  // does not leak
       x= sin(y);   // does not leak
       w= cos(z);   // does not leak
 
   //   ST=stats(nv); // still leaks! this function call with arg is using up mem
      //   x= soof(y);   // does not leak!
     // <<"%V$x $y\n"

     t= FineTime(); // does not leak!
      sum += i;

      r=addf(x,y);
      //<<"%V$r\n"
  //    <<"end $(memused()) \n"
       if ( (i % 1) == 0) {
    //   <<"<$i> Mu $Mu\n"
       //    <<"<$i> $s $sum $x $y  \n"
//	   <<"%V6.2f$ST\n"
          
	   <<"<$i>  %V   $Mu\n"
           if (Mu[1] > last_Mu[1]) {
               <<"msize change  \n"
	       last_Mu = Mu;
	       nmem_changes++;       
           }
	   if (Mu[0] > last_Mu[0]) {
  <<"mu change $(mu - last_mu) \n"
	       last_Mu = Mu;
	       nmem_changes++;       
           }
           }

      }
      while (i++ < N);   


<<"%V $nmem_changes  \n"

       //ans = iread();
     //  dumpmemtable();

      Mu= memused(); // does not leak
      <<"$Mu\n"
