/* 
 *  @script svarele.asl                                                 
 * 
 *  @comment test svar dec/assign reassign                              
 *  @release Carbon                                                     
 *  @vers 1.6 C Carbon [asl 6.16 : C S]                                 
 *  @date 05/27/2024 11:35:09                                           
 *  @cdate 1/1/2010                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

                                                                     
Str Use_= "Demo svar field use";


#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   allowErrors(-1);	

   chkIn();
   
  chkT(1)

  db_allow = 0

  Svar SV;

allowDB("spe,array",db_allow)

   SV[1].cpy("como estas")


<<"$SV \n"


  se1 = SV[1]

  chkStr(se1,"como estas")

  SV[2].cpy("correcto")


  se2= SV[2]


<<"%V $se1 $se2 \n"

 SV[0].cpy("hola")

 se0 = SV[0]

chkStr(se0,"hola")

 SV[8].cpy("Tuve la gripe")

 se8 = SV[8]

//  TBF -- does range SUBS happen
  SV[5:8].cpy("all_in_range")

<<"$SV \n"

int IV[20]


  IV[4:8] = 77;

<<"$IV\n"


 chkOut()
