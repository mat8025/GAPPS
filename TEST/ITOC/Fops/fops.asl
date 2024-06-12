/* 
 *  @script fops.asl                                                    
 * 
 *  @comment test readfile function                                     
 *  @release Rhodium                                                    
 *  @vers 1.5 B Boron [asl ]                                            
 *  @date 11/25/2023 07:59:27                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare  -->                                   
 * 
 */ 

#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     }

   showUsage(" test readfile function ");

   chkIn();
//sdb(1,@step)

   A = ofr("fops.asl");

   S=readfile(A);

   <<"$S\n";

   cf(A);

   sz = Caz(S);

   <<"%V$sz \n";

   A = ofr("fops.asl");

   k = 0;

   while (1) {

     res =readline(A);

     err = f_error(A);

     if (f_error(A) == EOF_ERROR_) {

       <<"\n@ EOF\n";

       break;

       }

     len = slen(res);

     <<"$k $len :: $res";

     k++;

     if (k > (sz+10))

     break;

     }

   chkT((err>0));

   <<"%V$k\n";

   chkT((k<(sz+10)));

   chkN(err,6);

   chkOut();
/*

TBD - needs more file IO tests

*/

//==============\_(^-^)_/==================//
