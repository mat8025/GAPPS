/* 
 *  @script mat-det.asl 
 * 
 *  @comment test mdet function 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.22 C-Li-Ti]                               
 *  @date Tue Feb 16 13:54:54 2021 
 *  @cdate Tue Feb 16 13:54:54 2021 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


int A[] = {4,6,3,8}


  A->Redimn(2,2)

<<"A= \n $A\n"

  mprt(A)

  C= mdet(A)


<<"det is $C\n"


exit()




int B[] = {16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(Cab(B)) $(typeof(B)) \n"
<<"%V$B \n"

  B->Redimn(4,4)


  C= mdet(B)


<<"$C \n"