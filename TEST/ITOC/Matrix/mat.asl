/* 
 *  @script mat.asl 
 * 
 *  @comment matrix ops 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.57 C-Li-La]                               
 *  @date 10/27/2021 13:03:14 
 *  @cdate 10/27/2021 13:03:14 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//----------------------//;
Str Use_= "Demo  of Mat,Vec proc args and matrix ops"; 
/////////////////////// 


#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 


chkIn()

allowErrors(-1) ; // keep going


void showStr(Str&  s)
{

<<"$_proc $s\n"

s.pinfo();

}


void showArray(int R[])
{

 R.pinfo();

 sz= Caz(R);

<<"%V $sz \n"
 
 cmb = Cab(R);
 
 <<"%V $cmb\n"

 int nc = cmb[0] ;

<<"array R $R[::] \n"


}
//======================



void showVec(Vec& R)
{
<<" $_proc   $R\n"

 R.pinfo();
 int cmb[0];
 int sz= Caz(R);
 
 cmb = Cab(R)
 


 int nc = cmb[0] ;

 <<"%V $sz $cmb  $nc\n"

int val = R[3];
int val4 = R[4];

<<"vec R $R[::] \n"

<<"vec R[2] $R[2] $val $val4\n"
 
 

}
//==============================

void showMat(Mat& R)
{
 int cmb[0];
 int hexw;
 int sz= Caz(R);
 int i = 1;
 cmb = Cab(R);
 
 <<"%V $sz $cmb\n"

 int nc = cmb[0] ;

// fix first pass asl wrong set i as 0
   hexw= R[i][2];

<<"$i $R[i][1] $hexw \n"
i++;
   hexw= R[i][1];
<<"$i $R[i][1] $hexw \n"
i++;

   //hexw= R.getEle(1,1);
hexw= R[i][1];
<<"$i $R[i][1] $hexw \n"

//hexw= LCM[i][1];
//<<"$i $LCM[i][1] $hexw \n"





<<"mat R $R[::][::] \n"
int val = R[1][1];
<<"$val  $R[1][::] \n"

}
//==============================




Str S ="learn the pentatonic scale positions "

<<" @ Str $S\n"

showStr(S);





int A[] = {7,3,4,-6,3,1};

<<" $(Cab(A)) $(Caz(A)) \n"

<<"%V$A \n"

showArray(A);



////////////////////////////////


Vec V(INT_,10,0,1);
<<"calling showVec\n"
showVec(V);






Mat M(INT_,5,4);

M.pinfo();

//Mat T(M);

       M = 78;
       
       M[2][3] = -47;
       M[1][1] = 66;
       M[1][2] = 66;
       M[2][1] = 37;
       M[3][1] = 82;              
       
!i M

 showMat(M);


chkT(1)

 chkOut();

exit();

      T= Mtrp(M);

      //M<-Transpose();

!i T

    X= M * T;

!i X



Siv v;

!i v



testargs(v);

 chkOut();


///////////////////////////////TODO////////////////////////////
/*

  need getEle vmf for Vec,Mat,Mda   plus the cpp equivalent    M.getEle(3,4)   Mda.getEle(3,4,2)

  fix for R[2][3]   - R is proc_arg_ref for Mat





*/
