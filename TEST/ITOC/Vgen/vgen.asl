//%*********************************************** 
//*  @script vgen.asl 
//* 
//*  @comment test vgen  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Fri Apr 26 06:56:03 2019 
//*  @cdate Fri Apr 26 06:56:03 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


///




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


pan incr;
incr = 1.5;
pan starti;

  for (i= 0; i <3 ; i++) {

        starti =i+1;
        vecp= vgen(PAN_,10+i,starti,incr)
 // chkR(vecp[1],1+i)
<<"$i vecp $vecp[0] $vecp[1] \n"
vecp->info(1)
  }

<<"$vecp[0:10]\n"
<<"done Pgen \n"
<<" $(typeof(vecp))  $(Caz(vecp)) \n"



chkOut()


exit()


  for (i= 0; i <3 ; i++) {

        vecf= vgen(FLOAT_,10+i,i,1)
  chkR(vecf[1],1+i)

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
  checknum(vecs[1],1+i)

  }
<<" $(typeof(vecs))  $(Caz(vecs)) \n"
<<"$vecs \n"

  for (i= 0; i <3 ; i++) {

        vecc= vgen(CHAR_,10+i,i,1)
  chkN(vecc[1],1+i)

  }
<<" $(typeof(vecc))  $(Caz(vecc)) \n"
<<"$vecc \n"
