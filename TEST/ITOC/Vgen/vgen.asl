/* 
 *  @script vgen.asl 
 * 
 *  @comment test vgen 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.28 C-Li-Ni] 
 *  @date 02/28/2021 08:17:21 
 *  @cdate Fri Apr 26 06:56:03 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                           


///

<|Use_=
 demo vgen
|>



#include "debug.asl"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"      
}

 chkIn(_dblevel)


 veca = vgen(INT_,10,0,1)

<<"$veca \n"

  chkN(veca[1],1)
  chkN(veca[9],9)

  for (i= 0; i <3 ; i++) {

        veci= vgen(INT_,10+i,i,1)
  chkN(veci[1],1+i)
veci->info(1)
  }
  
<<" $(typeof(veci))  $(Caz(veci)) \n"
<<"$veci \n"


//pan incr;
incr = 1.5;
//pan starti;



starti = 5;

        vecf= vgen(FLOAT_,10,0,incr)

<<" $vecf \n"

        vecp= vgen(PAN_,10,1.0,incr)

vecp->info(1)

<<"$vecp \n"

<<"$vecp[2]  $vecp[3]\n"
<<"vecp $vecp[0] $vecp[1] $vecp[3] \n"

   vecp2= vgen(PAN_,10,0,1)

<<"%p $vecp2 \n"


  for (i= 0; i <3 ; i++) {

        starti =i+1;
   vecp2= vgen(PAN_,10,starti,incr)
vecp2->info(1)
<<"$i vecp2 $vecp2[i] $vecp2[1+i] $vecp2[3+i] \n"
<<"$i $vecp2   \n"


// chkR(vecp[1],1+i)



  }

<<"$vecp[0:9:]\n"
<<"done Pgen \n"
<<" $(typeof(vecp))  $(Caz(vecp)) \n"



  for (i= 0; i <3 ; i++) {

        vecf= vgen(FLOAT_,10+i,i,1)
  chkR(vecf[1],1+i)
//ans=query("->")
  }
<<" $(typeof(vecf))  $(Caz(vecf)) \n"
<<"$vecf \n"

  for (i= 0; i <3 ; i++) {

        vecd= vgen(DOUBLE_,10+i,i,1)
  chkR(vecd[1],1+i)
vecd->info(1)
  }
<<" $(typeof(vecd))  $(Caz(vecd)) \n"
<<"$vecd \n"

  for (i= 0; i <3 ; i++) {

        vecs= vgen(SHORT_,10+i,i,1)
  chkN(vecs[1],1+i)

  }
<<" $(typeof(vecs))  $(Caz(vecs)) \n"
<<"$vecs \n"

  for (i= 0; i <3 ; i++) {

        vecc= vgen(CHAR_,10+i,i,1)
  chkN(vecc[1],1+i)

  }
<<" $(typeof(vecc))  $(Caz(vecc)) \n"
<<"$vecc \n"


chkOut()


exit()
