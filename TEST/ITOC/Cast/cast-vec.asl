/* 
 *  @script cast-vec.asl                                                
 * 
 *  @comment Test Cast of vector                                        
 *  @release Boron                                                      
 *  @vers 1.3 Li Lithium [asl 5.92 : B Ur]                              
 *  @date 03/23/2024 14:35:01                                           
 *  @cdate 1/1/2007                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 




#include "debug"



chkIn()

int a = 1.0

float f = 3.1

<<"%V $a $(typeof(a)) \n"

  a += f
  
<<"%V $a $(typeof(a)) \n"


chkN(a,4)


VI = dgen(10,0,1)

<<"$VI \n"
 a= VI[1]


<<"%V $a $(typeof(a)) \n"

 a += VI[2]

<<"%V $a $(typeof(a)) \n"

  for (i = 1; i < 5; i++) {

    a += VI[i]

<<"%V $a $(typeof(a)) \n"

  }

chkN(a,13)


float b = 1.0

int m = 3

<<"%V $b $(typeof(b)) \n"

  b += m
  
<<"%V $b $(typeof(b)) \n"


chkN(b,4.0)

IV = igen(10,0,1)

<<"%V$IV \n"

VI = igen(10,0,1)

<<"%V$VI \n"
 b= VI[1]


<<"%V $a $(typeof(a)) \n"

 b += VI[2]

<<"%V $b $(typeof(b)) \n"

  for (i = 1; i < 5; i++) {

    b += VI[i]

<<"%V $b $(typeof(b)) \n"

  }

   b.pinfo()

<<"%V $b $(typeof(b)) \n"
//chkStage("??")

  chkR(b,13.0)




chkOut()