///
///
///


setdebug(1,@~pline,@trace);
filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");


proc ask()
{
   ok=checkStage();
   <<"%6.2f$ok\n"
  if (ok[0] < 100.0) {
  ans=iread();
  }

}

//#define  ASK ask();
#define  ASK ;
checkIn()

A=  ofr("foods1.csv");

   RF= readRecord(A,@del,',');

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }



cf(A);


recinfo = info(RF);
<<"$recinfo \n"


  Nrecs = Caz(RF);
  Ncols = Caz(RF,1);

<<"num of records $Nrecs  num cols $Ncols\n";

<<" $RF[::] \n"



   for (i= 0; i < 3; i++) {
       nc = Caz(RF,i);
<<"<$i> $nc $RF[i] \n";
    }

<<" $RF[6] \n"
<<" $RF[7] \n"
<<" $RF[Nrecs-1] \n"

<<" $RF[Nrecs-2] \n"


   for (i= 2; i < 10; i++) {
    rval = RF[i];
<<"$rval \n  $RF[i] \n";
    }


<<" $RF[::] \n"

<<"before delete \n"
recinfo = info(RF);
<<"$recinfo \n"
<<" $(info(RF)) \n"
  Nrecs = Caz(RF);
<<"num of records $Nrecs \n";  
  Ncols = Caz(RF,1);
<<"num of cols $Ncols\n";

  deleteRows(RF,1,-1)
<<"after delete \n"
<<" $(info(RF)) \n"
  Nrecs = Caz(RF);
<<"new num of records $Nrecs \n";  
  Ncols = Caz(RF,1);

<<"new num of cols $Ncols\n";


<<" $(info(RF)) \n"

yes=iread("next?")

<<" $RF[::] \n"


A=  ofr("foods2.csv");

 if (A == -1) {
  <<" can't open food table  \n";
    exit();
 }

   //delete(RF)  ; // realloc of RF does not work for xic

   RF= readRecord(A,@del,',')
   cf(A);

  Nrecs = Caz(RF);
<<"new num of records $Nrecs \n";

  Ncols = Caz(RF,1);

<<"new num of cols $Ncols\n";



   for (i= 0; i < 3; i++) {
       nc = Caz(RF,i);
<<"<$i> $nc $RF[i] \n";
    }


<<" $RF[::] \n"






checkTrue((nc >0))

int Testpick[5][2];


     testargs(1,Testpick);


//ans=iread()


A=  ofr("foodtable.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

   RF2= readRecord(A,@del,',')
   cf(A);

  Nrecs = Caz(RF2);
  Ncols = Caz(RF2,1);

<<"num of records $Nrecs  num cols $Ncols\n";



   for (i= 0; i < 3; i++) {
       nc = Caz(RF2,i);
<<"<$i> $nc $RF2[i] \n";
    }

checkTrue((nc >0))


<<"///////////"

for (j = 1; j<=10;j++) {

vname = "RT$j";

$vname = RF;

   for (i= 0; i < 3; i++) {
       nc = Caz($vname,i);
       s = $vname[i]
<<"<$i> $nc $s[i] \n";
    }

}


/{
Record RT[2][10];

RT[0][0] = RF[0];
RT[1][0] = RF[1];

<<"RT[0][0] $RT[0][0]\n"
<<"RT[1][0] $RT[1][0]\n"
/}


ASK
checkOut()
exit()