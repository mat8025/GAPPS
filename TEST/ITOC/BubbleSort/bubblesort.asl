/* 
 *  @script bubblesort.asl                                              
 * 
 *  @comment test bubblesort                                            
 *  @release Carbon                                                     
 *  @vers 1.4 Be Beryllium [asl 6.29 : C Cu]                            
 *  @date 06/13/2024 18:12:47                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

///
/// BubbleSort
///

   /{/*;

   bubblesort(Vec);

   performs bubble sort on a vector returns sorted vector.;

   Should work on all types.;

   If used as Vec->BubbleSort() the vector itself is sorted.

   /}*/

   chkIn();

   I=vgen(INT_,10,10,-1);

   <<"$I\n";

   T=BubbleSort(I);

   chkN(T[0],1);

   <<"$I\n";

   <<"$T\n";

   chkN(I[0],1);

   ok=I.BubbleSort();

   <<"ret $ok\n";

   <<"$I\n";

   chkN(I[0],1);

   F=vgen(FLOAT_,10,10,-2);

   chkN(F[0],10);

   <<"$F\n";

   F.BubbleSort();

   <<"$F\n";

   chkN(F[0],-8);

   chkOut();

//==============\_(^-^)_/==================//
