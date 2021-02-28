//%*********************************************** 
//*  @script vsp.asl 
//* 
//*  @comment test vector use 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.68 C-He-Er]                                
//*  @date Sun Aug 30 08:50:56 2020 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
//
//
// test vsp


#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)

checkMemory(1,1)

initmem=memused()

float Vsp[>1024];
float Tsp[>1024];

//<<"memused $(memused()) \n";
//<<"memused $(memused()) \n";
<<"memused $initmem $(typeof(initmem))\n";

//<<"memused $(memused()) \n";




fftsz = 2^10;
<<"%V $fftsz\n"
fftsz2 = fftsz/2;
//ans=query()
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


   

  Tsp[0:2:] = 0.100
  <<"%V$Tsp\n";

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



finalmem=memused()
<<"memused $(memused()) \n";



chkOut();