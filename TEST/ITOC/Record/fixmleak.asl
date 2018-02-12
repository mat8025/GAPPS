
setdebug(1,"keep");
filterDebug(0,"args")
int last_mu = 0;
str s="xx";
int sum = 0;
i=0;
    //for (i= 0; i < 10; i++) {
  //  while (1) {
j= 0;
float y ;
N= atoi(_clarg[1]);
last_mu = memused();

char nv[20];
float ST[20];
int ok;
       mu= memused();
do {
      mu= memused(); // does not leak
   <<"begin $mu \n"

      y = (i *.2);
      x= y;
      s="$i";
      sz=Caz(nv); // does not leak
      S=testargs(1,y,x,s,nv,sz); // does not leak
      ok=scpy(nv,s);  // does not leak
      <<"$ok  %c $nv\n"
      x= sin(y);   // does not leak
      <<"%V$x $y\n"
     //ST=stats(nv); // still leaks! this function call with arg is using up mem
        x= oof(y);   // does not leak!
      <<"%V$x $y\n"

      x= soof(y);   // does not leak!
      <<"%V$x $y\n"

      t= FineTime(); // does not leak!
      sum += i;

      i++;
      <<"<$i>  $s $sum $y\n"
  //    <<"end $(memused()) \n"
      }
      while (i < N);   
      



      mu= memused();



       s="$i";
       sum += i;

      
    <<"$i\t $s\t $(mu-last_mu)  $mu\n"
      
      last_mu = mu;
      i++;


       mu= memused();
       s="$i";
       sum += i;

      
    <<"$i\t $s\t $(mu-last_mu)  $mu\n"
      
      last_mu = mu;
      i++;


<<"memused $mu\n"