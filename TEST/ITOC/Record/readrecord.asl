///
///
///


setdebug(1,"~pline","trace","~stderr");
FilterDebug(0)
FilterFileDebug( 2,"args_e.cpp")


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

A=  ofr("foodtable.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

   RF= readRecord(A,@del,',')
   cf(A);

  Nrecs = Caz(RF);
  Ncols = Caz(RF,1);

<<"num of records $Nrecs  num cols $Ncols\n";



   for (i= 0; i < 3; i++) {
       nc = Caz(RF,i);
<<"<$i> $nc $RF[i] \n";
    }

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

for (j = 1; j<=30;j++) {

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