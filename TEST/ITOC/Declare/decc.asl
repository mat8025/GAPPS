/* 
 *  @script decc.asl                                                    
 * 
 *  @comment char declare                                               
 *  @release Rhodium                                                    
 *  @vers 1.4 Be Beryllium [asl ]                                       
 *  @date 11/24/2023 09:28:59                                           
 *  @cdate 08/25/2021 10:43:34                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare  -->                                   
 * 
 */ 


<|Use_=
  Demo  of declare char type
  
///////////////////////
|>

#include "debug"

  if (_dblevel >0) {

  debugON();

  <<"$Use_\n";

  }

 ask =0
  chkIn(_dblevel);

  int iv[] = { 0,1,2,3,4,5,6,7,8,9, };

  iv.pinfo();

  <<" $iv \n";

  for (i=0;i<10;i++) {

  chkN(iv[i],i);

  }

  char cv[] = { 'F','G','H','I','J','K','L','M','N','O' };

  <<"$(vinfo(cv))\n";

  <<"$cv \n";

  <<"%c $cv \n";

  chkN(cv[0],'F');

  chkN(cv[4],'J');

  chkN(cv[9],'O');

  char cv2[] = { 'FGHIJKLMNO' };

  cv2.pinfo()

  <<"$cv2 \n";

  <<"%c $cv2 \n";

  <<" $cv2[0] \n"
  <<"%v %c $cv2[0] \n"  
 //   <<"%vc $cv2[1] \n"

fileDB(ALLOW_,"paramexpand,parrayexpand")
 
    <<"%v %c $cv2[2] should be H? \n"
        <<"%v %c $cv2[3] should be I? \n"

ce= cv2[1]
<<"G? %v %c $cv2[1] $ce \n"    

    <<"%V $cv2[2] \n"

  askit(ask)

  chkN(ce,'G');

  chkN(cv2[0],'F');

  chkN(cv2[4],'J');

  chkN(cv2[5],'K');

  chkN(cv2[9],'O');

  char dv[] = { 'F', 71, 72, 73, 'O', '0', 76, 77,78,79, };

  chkN(dv[0],'F');

  chkN(dv[1],71);

  chkN(dv[9],79);

  <<"$(vinfo(dv))\n";

  <<"$dv \n";

  <<"%c $dv \n";

  chkOut();

//==============\_(^-^)_/==================//
