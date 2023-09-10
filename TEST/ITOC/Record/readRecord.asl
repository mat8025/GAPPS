/* 
 *  @script readRecord.asl 
 * 
 *  @comment test recA=rec5 use 
 *  @release CARBON 
 *  @vers 1.39 Y 6.3.77 C-Li-Ir 
 *  @date 01/29/2022 09:17:56          
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
#define  ASL_SCRIPT 1   // first statement of main script
//----------------<v_&_v>-------------------------//;   






#include "debug"

if (_dblevel >0) {
   debugON()
}


Str myName_ =" readRecord.asl - test record class"

chkIn(_dblevel);



<<"$myName_ \n"

setdebug(-1) ; // -1 to turn off

Record RX;

int B=ofr("wex2023.tsv");

<<"%V $B\n"


   A=ofr("wex2023.tsv");

<<"%V $A\n"

//ans=query(" file Open proceed?");


  if (A == -1) {

  printf("FILE not found \n");

  exit_si();

  }
// check


//RX.pinfo()
setdebug(1)

 k = 5

   while ( k) {

<<"%V $k \n"
    k--
   }
   

 Wex_Nrecs= RX.readRecord(A,_RDEL,-1,_RLAST);  


<<"%V $Wex_Nrecs\n"

//ans=query(" readRecord proceed?");

Svar rx;   // autodeclare

exit(0)

/*
  for (i = 0; i < Wex_Nrecs ; i++) {

   rx= RX[i];

<<"$i  $rx[0] $rx[1] $rx[2]\n"

  }
*/



exit(0);


