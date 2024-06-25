/* 
 *  @script mops.asl                                                    
 * 
 *  @comment test some math SF                                          
 *  @release Carbon                                                     
 *  @vers 1.3 Li Lithium [asl 6.36 : C Kr]                              
 *  @date 06/25/2024 02:40:24                                           
 *  @cdate Sun Apr 12 13:35:08 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


///    Mops -- test some SF mops




#define __CPP__ 0

#define __ASL__ 1

#if __ASL__

<|Use_ =
  Demo  of math ops
|>

/*
#include "debug" 
  if (_dblevel >0) { 
   debugON() 
  } 
*/

<<"$Use_ \n" 

#endif


 


// CPP main statement goes after all procs
#if __CPP__
   int main( int argc, char *argv[] ) {  
#endif       

   allowErrors(-1); // set number of errors allowed -1 keep going 

  chkIn(1) ;

  chkT(1);


   DB_action =0

   PI = 4.0 * atan(1.0)


  a = 14;

  b = 16;

  short xyv[20];

  xyv.pinfo();

  chkN (xyv[0],0);

  xyv.pinfo()

#if __ASL__
  <<"don't translate here\n"
  allowDB("array_,ds_store,spe_exp",1)
#endif

  xyv[{2,4,7,a}] = 36;

  xyv.pinfo()

  <<"$xyv\n";

  chkN(xyv[2],36);

  chkN(xyv[14],36);

  chkN(xyv[0],0);

  xyv[{2,4,7,b}] = 77;

  <<"$xyv\n";

  chkN(xyv[2],77);

  B=vgen(INT_,20,0,1);
//X=vgen(INT_,10,0,1)

  chkN (B[0],0);

  chkN (B[19],19);

  B[{2,4,a}] = 77;

  <<"%V$B\n";

#if __ASL__
  ans=ask(DB_prompt,DB_action)
  if (ans == "q") {
    exit(-1)
  }
#endif

  chkN(B[2],77);

  chkN (B[0],0);


  <<"%V$B\n";


  B[0] =0;

  <<"%V$B\n";

  B[{2, 4,7,a}] = 36;

  B.pinfo()
  <<"%V$B\n";

  chkN (B[0],0);

<<"%V $a\n"

  B[{2,4 ,7,a}] = 37;

  <<"%V$B\n";
  B.pinfo()


  chkN (B[0],0);

  chkN (B[4],37);

  <<"%V$B\n";


#if __ASL__
ans=ask(DB_prompt,DB_action)
  if (ans == "q") {
    exit(-1)
  }
#endif


  xyv[{2,4,7,a}] = 77;

  chkN(xyv[2],77);

  xyv[{2,4,7,a}] = 79;
/*

<<"%v $(Caz(xyv)) \n"

<<" $(typeof(xyv)) \n"

<<"%v $(Caz(xyv)) \n"

 xyv[2] = 99

testargs(" TRY HARDER $xyv[2] ")

 as = xyv[2]

<<"%v  $as \n"


   chkN(xyv[2],99)

   chkN(xyv[2],as)

*/

  int  xyz[20];
// allow auto create ? fill to highest number ?
  xyz[{2,4,7,a}] = 79;

  chkN(xyv[2],79);

  xyz.pinfo()

  sz = Caz(xyv);

<<"%V $sz\n"
  ans=ask("%V $sz",0)
  if (ans == "q") {
    exit(-1)
  }


  chkN(sz,20);

  chkN(Caz(xyv),20);

  short zx[4];

  zx[0] = 1;

  zx[1] = 2;

  zx[2] = 3;

  zx[3] = 4;

  zxs = 50;

  pi = 0;

  xyv[pi++] = 700;

  xyv[pi++] = zx[3]*zxs;

  xyv[pi++] = 699;

  xyv[pi++] = zx[2]*zxs;

  xyv[pi++] = 698;

  xyv[pi++] = zx[1]*zxs;

  xyv[pi++] = 697;

  xyv[pi++] = zx[0]*zxs;

  <<" %v $pi \n";

  <<" $xyv[0] \n";

  <<" $xyv \n";

  <<" $xyv[::] \n";

  <<"%V $xyv[::] \n";

  <<"%v $(Caz(xyv)) \n";
 //  xyv[0,2,4,6] = 77

  xyv[{0,2,4,6}] = 77;

  <<"%V $xyv[::] \n";

  chkN(xyv[2],77);



  chkN(xyv[6],77);

  <<"%v $xyv[::] \n";

  xyv[0,2,4,6] = Igen(4,69,1);

  <<"%v $xyv[::] \n";

  chkN(xyv[2],70);
//<<"%v $xyv[6] \n"

  chkN(xyv[6],72);

  <<" $xyv \n";

  zx[0] =23;

  <<" %v $zx \n";

  <<"%v $xyv[*] \n";

  xyv[1,3,5,7] =  zx;

  <<"%v $xyv[::] \n";

  <<" $xyv[0] \n";

  <<"%V :: $xyv[0] \n";

  zx[3] = 66;

  <<"%v $zx \n";

  for (j = 1; j < 4 ; j++) {

  zx =  zx * 2;

  <<"%v $zx \n";
//   xyv[1,3,5,7] =  zx * zxs * j

  xyv[1,3,5,7] =  zx;

  <<"%V $j :: $xyv[0] \n";

  <<"%V $j :: $xyv \n";

  }

  <<"%v $(Caz(xyv)) \n";

  chkStage("xyassign");

  N = 27;

  a = cbrt(N);

  <<"cube root of $N  is $a\n";

  chkR(a,3.0);

  N = 729;

  a = cbrt(N);

  <<"cube root of $N  is $a\n";

  chkR(a,9.0);

  chkStage("cbrt");
//============= Atof ===========//

  p = PI;

  i = 47;

  <<"%I $i    \n";

  f= 1.2;

  sz = Caz(&f);

  <<"%V $f  $sz  \n";

  f = atof("3.141593");

  sz = Caz(&f);

  <<"%V $f  $sz  \n";

  chkN(sz,0);

  <<"%V $PI \n"

  A= Split("$PI 1634 8208 9473");

  <<"%V $A \n";
  A.pinfo()


 
  sz = Caz(F);

  bd = Cab(F);

  <<"%V $F  $sz $bd\n";

  chkN(sz,4);

  G = Atof(A[1]);

  sz = Caz(&G);

  bd = Cab(&G);

  <<"%V $G $sz $bd \n";

  chkN(sz,0);

  I = Atoi(A[2]);

  sz = Caz(&I);

  bd = Cab(&I);

  <<"%V $I $sz $bd \n";

  chkN(sz,0);

  chkStage("atof");

  hs = dec2hex(47806);

  <<"$hs\n";

  chkStr(hs,"BABE");

  i= hex2dec("babe");

  chkN(i,47806);

  chkStage("dec2hex");

  chkOut();




#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     



//==============\_(^-^)_/==================//
