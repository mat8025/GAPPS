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
//----------------<v_&_v>-------------------------//;   




#include "debug"

if (_dblevel >0) {
   debugON()
}




chkIn(_dblevel);


Record RX;

int B=ofr("wex2023.tsv");

<<"%V $B\n"


   A=ofr("wex2023.tsv");

<<"%V $A\n"

ans=query(" file Open proceed?");


  if (A == -1) {

  printf("FILE not found \n");

  exit_si();

  }
// chec


 Wex_Nrecs=RX.readRecord(A,_RDEL,-1,_RLAST);  // no back ptr to Siv?


<<"%V $Wex_Nrecs\n"

Svar rx;   // autodeclare

 int irx = Wex_Nrecs -20;

  for (i = 0; i < 10; i++) {
       rx= RX[i];
<<"$i  $rx \n"
  }

ans=query(" readRecord proceed?");


exit(0);


