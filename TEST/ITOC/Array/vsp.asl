//
//
// test vsp


setdebug(1,"pline","trace")

#define ASK ;
//#define ASK ans=iread("->");

initmem=memused()
chkIn()

float Vsp[];
float Tsp[];


fftsz = 2^^6;
fftsz2 = fftsz/2;

float Sf = 20480.0

  // float Sf = 20000.0

 Nyq = Sf/2.0;

 Df = Nyq/ fftsz2;

<<"%V$fftsz $Nyq $Df   $fftsz2 \n"



proc setupVsp()
{

  Vsp[0] = 0.10000000
  Vsp[1] = 0.10000000
  Vsp[2] = 0.10000000

  for (i = 3; i < fftsz2; i++) {
       Vsp[i] = 615 / (i * Df)           //   3690 * acc / Frq_CPM   ---> 
  }

}
//-------------------------------------------------------------

setupVsp()

<<"$Vsp\n"

chkR(Vsp[1],0.1)




proc setupTsp1()
{

  //Tsp = fgen(fftsz2,615/Df,0)
 // Tsp /= fgen(fftsz2,0,1)

  Tsp = fgen(fftsz2,615/Df,0) / fgen(fftsz2,0,1)


 // Tsp[0] = 0.000000001
//  Tsp[1] = 0.000000001
 // Tsp[2] = 0.000000001


  //mv = fgen(fftsz2,0,1)
  //Tsp = Tsp / mv
//  Tsp = Tsp / fgen(fftsz2,0,1)



}

//-------------------------------------------------------------

proc setupTsp()
{
<<" $fftsz2 \n"

  //Tsp = fgen(fftsz2,615/Df,0) / fgen(fftsz2,0,1);

    Tsp = fgen(fftsz2,615/Df,0)
    Tsp /= fgen(fftsz2,0,1);


<<"$(Caz(Tsp)) $(Cab(Tsp))\n"
  <<"$Tsp\n";

   ASK

  Tsp[0:2] = 0.10000000
}


    setupTsp()

<<"$Tsp\n"

float Dif[]
  // compare Tsp Vsp
int bad = 0
  for (i = 0; i < fftsz2; i++) {

      Dif[i] = Vsp[i] - Tsp[i]

      if (Dif[i] != 0.0) {
<<"bad $i $Dif[i] \n"
      bad++
      }

  }

chkN(bad,0)

<<"%V$Dif\n"

 float Vcmp[]

 Vcmp = Vsp - Tsp

<<"$Vcmp \n"

 Rcmp = Cmp(Vsp,Tsp,"==",1)

<<"$Rcmp \n"

chkN(Rcmp[1],1)

Checkout();

finalmem=memused()
<<"memused $(memused()) \n";  