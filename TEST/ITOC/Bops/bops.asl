/* 
 *  @script bops.asl                                                    
 * 
 *  @comment test basic ops                                             
 *  @release Argon                                                      
 *  @vers 1.10 Ne Neon [asl ]                                           
 *  @date 08/28/2023 07:09:12                                           
 *  @cdate 1/1/2002                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare  -->                                   
 * 
 */ 




#define __CPP__ 0

//  use the asl  -T  flag to produce cpp compilable code
//  asl -wT xyz.asl
//  then the script xyz.asl  is converted to xyz.asc
//  and that asc file can be compiled with cpp
//
//  the translation flips the _CPP_ define to 1  in the resulting asc file
//  the makeasc  script  will compile  asc code
//  e.g. makeasc  xyz

//  just using asl  interpreter skips over _CPP_ sections in the asl script
//  and defines _ASL_ to 1 and _TRANS_ to 0
//  during transation _ASL_ is set to 0
//   so that code is left as is
//  _TRANS_ is set  1 so that code is evaluated for translation purposes
//   and will assist in compilation but will not be part  of the compiled
//   asc code
//

#if __CPP__
#include "cpp_head.h" 
#endif



#if __ASL__

// this code section will be interpreted/executed by asl
// but will not be compiled 
#include "debug"


  if (_dblevel >0)    debugON()

 argc = argc();

<<"%V $argc \n"

//ans=query(" argc $argc continue? :[y/n]") ;
//f (ans != "y")    exit(-1) ;
//<<"%V $ans \n"


//ans=ask("?? $argc",1)
 allowErrors(-1)

 chkIn()

 chkT(1) 
  db_allow = 1; // set to 1 for internal debug print;

   db_ask = 0;

   allowDB("opera_,spe_,str_,array_parse,parse,rdp_,pex,ic",db_allow);

#endif

allowDB("opera_,spe_,str_,array_parse,parse,rdp_,pex,ic",db_allow);


int addem (int m, int n)
{

  int p = 0;

  p = m + n
<<"%V $p  $m $n \n"
  return p
}

//  Vec<double> fv(10)
 Svar argv;

#if __CPP__

int main( int argc, char *argv[] ) { // main start

   for (int i= 0; i <argc; i++) {
     sargs.cpy(argv[i],i);
   }
   init_cpp();

///
#endif      

#if __ASL__

  na = _clargc
  argv = _clarg

#endif

  <<"%V $argc\n" 

  i = 0 

//ans = ask(" $i [yes,no]",1);

  if (argc >= 1) {

  for (i = 0 ;  i < argc ;   i++) {

   <<"arg [${i}] $argv[i] \n" 

   if (i == 10) {

     <<"i == 5 %V $i\n" 

     break 

     }
  <<"%V $i\n"
//  ans = ask(" $i [yes,no]",1);

   }

  }

  <<"args listed  try query \n" 
Str ans = " weird "

<<"%V $ans \n"

//  ans = query(" argc $argc continue? :[y/n]") ;
//printf("ans %s\n",ans.cptr());
  if (ans != "y")   {

<<"%V $ans != y\n"
 // exit(-1) ;

}
<<"%V $ans \n"

  dv = cos(0.4)

  ds = sin(0.1)

  dt = tan (0.7)

  adt = atan(dt)

<<"%V $dv $ds $dt $adt \n"
  
//  ans = query(" cos/sin/tan   continue? :[y/n]") ;

  allowDB("spe,rdp,ic,opera,ds,svar",1)



int ab = 2 + 3 

  <<"%V$ab\n" 

  chkN(ab,5) 

   int c = 74;

   d = 7 + 8

  chkN(d,15)
  m1 = 7;
  n1 = 9;
  q1 = 3;
  p1 = m1 + n1
<<"%V $p1  $m1 $n1 \n"


  chkN(p1,16) 


  p1 = m1 + n1 * q1;

<<"%V $p1  $m1 $n1 $q1 \n"
 
   chkN(p1,34)



   c =    addem (7, 9)


<<"%V $c\n"



  chkN(c,16) 

  chkOut(1)


   d =    addem (17, 19)

  chkN(d,36) 

//  chkOut(1)
  
  int n1 = 1 

  <<"%V $n1 \n" 

  chkN(n1,1) 

  n1++ 

  <<"%V $n1 \n" 

  chkN(n1,2) 

  ++n1 

  <<"%V $n1 \n" 

  chkN(n1,3) 

  n1 += 2 

  chkN(n1,5) 

  n1 -= 2 

  chkN(n1,3) 

  n1 *= 2 

  chkN(n1,6) 

  n1 /= 2 

  chkN(n1,3) 

  float fn=2.71828 

  <<"%V$fn\n" 

  chkN(fn,2.71828) 

  d= 7 

  int e = -6 

  int u = 47 

  int w = -79 

  <<"%V$d $e\n" 

  <<"%V$u $w\n" 

  chkN(d,7) 

  chkN(e,-6) 

  int b = 79 

  <<"%V $b\n" 

  chkN(b,79) 

  <<"%V$d $e\n" 

  b = d * e 

  <<"%V$b\n" 

  chkN(b,-42) 

  b++ 

  <<"%V$b\n" 

  chkN(b,-41) 






  int a = 2 + 3 

  <<"%V$a\n" 

  chkN(a,5) 

  b = 7 * 6 

  <<"%V$b\n" 

  chkN(b,42) 

  c= a * b 

  chkN(c,(5*42)) 

  <<"$c $a $b \n" 

  z = sin(0.9) 

  <<" %v $z \n" 

  x = cos(0.9) 

  <<" %v $z $x \n" 
//   test some basics -- before using testsuite  

  int k=4 

  <<"%V $k \n" 

  chkN(k,4) 

  int k1 = 47 

  <<"%V $k1 \n" 

  chkN(k1,47) 

  float y = 3.2 

  <<"%V $y \n" 

  chkF(y,3.2,6) 

  a = 2 + 2 

  <<"%v $a \n" 
//     chkN(a,4)

  sal = 40 * 75 * 4 

  <<"%v $sal \n" 

  chkN(sal,12000) 

  int n = 1 

  <<"%V $n \n" 
      //  chkN(n,1)

  n++ 

  <<"%V $n \n" 
    //   chkN(n,2)

  ++n 

  <<"%V $n \n" 

  chkN(n,3) 

  <<"%V $n \n" 

  z = n++ + 1 

  <<"%V $z \n" 

  chkN(n,4) 

  chkN(z,4) 

  <<"%v $n \n" 

  z = ++n + 1 

  <<"%V $z \n" 

  chkN(z,6) 

  <<"%V $n \n" 

//  cpp versio
//  ++n++ 

    ++n ; n++
  <<"%V $n \n" 

  chkN(n,7) 

  N = 24 

  k = 2 

  ok =0 

  if (k <= N) {

  <<" $k  <= $N \n" 

  ok = 1 

  <<" <= op  working!\n" 

  }

  else {

  <<" <= op not working! %V $k <= $N\n" 

  }

  chkN(1,ok) 

  ok = 0 

  k = 25 

  if (k >= N) {

  <<" $k  >= $N \n" 

  ok = 1 

  <<" >= op  working!\n" 

  }

  else {

  <<" >= op not working! %V$k\n" 

  }

  chkN(1,ok) 

  ok = 0 

  if (k != N) {

  <<" $k  != $N \n" 

  ok = 1 

  <<" != op  working!\n" 

  }

  else {

  <<" != op not working! %V$k\n" 

  }

  chkN(1,ok) 

  float fa = sin(0.5)

<<"%V $fa \n"


  float fb = 2.3 

  float fc = 4.8 

  chkN(fb,2.3) 

  <<"%V$fa $fb $fc\n" 

  fb++ 

  chkN(fb,3.3) 

  <<"%V$fa $fb $fc\n" 

  int h = -4 

  <<"%V$h\n" 

  chkN(h,-4) 

  float q=-7 ; <<"$q\n" 

  chkN(q,-7) 

  int sum = 0 

  double mi = 1 

  N = 10 

  k1 = 0 

  <<"%V $k1 $sum $mi \n" 

  for (k1 = 2 ; k1 < N;  k1++) {



  sum += k1 

  mi *= k1 

ans=ask("%V $k1 $sum $mi ",db_ask) 

  }

//  <<" $sum  $k1  $(k1*N/2) $mi\n"
//  TBF $(k1*N/2) translates to %d , k115
// not to the value k1*N2

<<" $sum  $k1   $mi\n" 

//  fv = vgen(FLOAT_,10,0,1) 

//  Vec<float> fv(10,0,1);

//  Vec<double> fv(10)

//allowDB("spe,rdp")
//DBaction((DBSTEP_),ON_)
  float fv[10]

  for (i=0;i<10;i++) {
     fv[i] = i
<<"$i $fv[i] \n"
  //  ans = ask(" $fv[i] [yes,no]",1);
  }
//  fv.pinfo() 
//DBaction((DBSTEP_),OFF_)
  <<"$fv \n" 

  fv[0] = -32 

  <<"%V$fv \n" 

  fv[2] = 77 

  <<"%V$fv \n" 



  fv[3] = 80 

  <<"%V$fv \n" 

  chkN(fv[3],80) 
  chkN(fv[2],77) 
  chkN(fv[0],-32) 
  
  chkOut()
  
#if __CPP__              
  //////////////////////////////////
  exit(0);       // want to report code errors exit status
 }  /// end of C++ main   
#endif               

//==============\_(^-^)_/==================//

/*
   TBD

08/27/23 
   Vec<float> fv(10,0.0,1.0);
   asl works 
   cpp load ld error   - but works in tsk_glide  - why ?


*/


