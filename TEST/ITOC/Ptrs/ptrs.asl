/* 
 *  @script ptrs.asl 
 * 
 *  @comment test ptr ops 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.30 C-Li-Zn] 
 *  @date 03/13/2021 09:40:47 
 *  @cdate Mon Aug 10 10:50:42 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                              

<|Use_=
Demo  of ptr type

///////////////////////
|>




#include "debug"

if (_dblevel >0) {
   debugON()
     <<"$Use_\n"   
}

allowErrors(-1)
 
chkIn(_dblevel);


  KI = vgen(INT_,10,0,1)

<<"$KI\n"
  chkN(KI[1],1)

  ptr vp;

!i KI

  vp = &KI;


!i vp
  
  <<" %V $vp \n"

void goo(ptr a)
  {

<<"$_proc  $a  ptr\n"
 
!i a
  b = $a;
!i b

  $a = $a +1;
      
 <<"%V $a $b\n"
!z
 }
//===================
  int m = 0;
  int k = 4;

  n= 0
  
  kp = &k;   // kp ptr to k
  
!i  kp
  
  $kp = 8;

!i k

!i  kp

!z

  goo (kp)

  chkN(k,9)

<<"%V $k\n"

   $kp = $kp +1

  chkN(k,10)

<<"%V $_scope\n"

  goo(&k)

<<"%V $_scope\n"

  chkN(k,11)
  
  n = k;
   
  m= $kp
  
!i  k
!i  kp
  
  
!i m
  
   <<" %V $$kp \n"
    
   <<" %V $k $m $n\n"
  
  
  tok=chkN(m,k)
  
  <<"%V $tok\n"
   $kp = 58
  
  <<"%V $kp \n"
  
  
!i k
  
  <<"%V $k \n"
  
  tok=chkN(k, 58)
  
  <<"%V $tok\n"
  
   au = 79

!i au
  
!i k
  
   $kp = au
  
!i k
  <<"%V $k\n"
  
!i au
  
  
  tok= chkN (k, 79)
  <<"%V $tok\n"
  tok= chkN(k, au)
  <<"%V $tok\n"
  silv = 47
  
  <<"%V$silv\n"
  
  sp = &silv;
  
!i sp

   $kp = $sp
  
!i kp
  
  tok=chkN(k, 47)
  <<"%V $tok\n"

<<"%V $_scope\n"

  ptr vp2;

!i KI

  vp2 = &KI;


!i vp2
  
  <<" %V $vp2 \n"

  
  
  <<" %V $vp2[1] \n"

  vp2[3] = 47; // correct
  
  
  <<"$KI\n"  
  
   n = 2 * $kp 
  
  <<" %V $k $m $n\n"

  
  <<" %V $kp \n"
  
  
  
  <<" %V $$kp \n"
  

    

  
  $vp = 89;  // wrong -- want this to only update current element

    <<"$KI\n"
  
  

  
  
  
  
  int add(int a, int b )
  {
   c= a +b
  <<"%V$c $a $b\n"
   a++
   b--
  c= a +b
  <<"%V$c $a $b\n"
  }
  
  int N = 30
  
  <<" $(typeof(N)) $(sizeof(N)) \n"
  
  intsz = sizeof(N)
  
  
  n = 79
  a=3.14159
  
  <<"%I $n\n"
  <<"%V $n\n"
  
  // copy of first arg -- siv ptr to second
  dv=testargs(n,&n)
  
  <<"%(1,,,\n)$dv \n"
  
  dv=testargs(1,2,3,n,&n,&a)
  
  <<"%(1,,,\n)$dv \n"
  
   add (5,6)
  
   x = 2;
   y = 3;
  <<"%V $x $y \n"
   add (x,y)
  
  
  
  <<"%V $x $y \n"
  
  add (&x,&y)
  
  <<"%V $x $y \n"
  
  
  
  int a_3 = 66
  
  vn = "a_3"
  
  k = $vn
  
  $vn = 77
  
  <<"%V$vn $k $a_3 \n"
  // output is :-
  
  //vn a_3 k 66 a_3 77 
  
  
  
  
  
  
//  ptr z = &x;    //    TBF 9/4/21


  ptr z;
  
  z = &x;
  
  z = 6;
     
  <<"%V $x\n"
  
!i  z
  

  int I[N]
  
  
   for(i = 0; i< N; i++) {
     I[i] = i
   } 
  
   I[0] = 0xcafebabe
   I[1] = 0xbabeface
   I[2] = 0xdeadbeef
  
   testargs(I, &I)
  
   testargs(I[3], &I[3])
  
   // get the mem address for the memory of a siv variable (number type )
   ma = memaddr(&n)
  
  <<"ma %u $ma \n"
  
   memfill(ma,INT_,80)
  
  <<"%V $n  $(periodicName(n))\n"
  
   memfill(ma,INT_,50)
  
  <<"%V $n  $(periodicName(n))\n"
  
  
   memfill(ma,INT_,80)
  
  <<"%V $n  $(periodicName(n))\n"
  
  
   memfill(ma,INT_,79)
  
  <<"%V $n  $(periodicName(n))\n"
  
  
  
   memfill(ma,INT_,47)
  
  <<"%V $n  $(periodicName(n))\n"
  
  
   memfill(ma,INT_,28)
  
  <<"%V $n  $(periodicName(n))\n"
  
   ima = memaddr(&I[0])
  <<"ima %u $ima \n"
  
   ma = memaddr(&I[1])
  <<"ma %u $ma \n"
   ma = memaddr(&I[2])
  <<"ma %u $ma \n"
   ma = memaddr(&I[3])
  <<"ma %u $ma \n"
   memfill(ma,INT_,0xa600ddeed)
   ma = memaddr(&I[4])
  <<"ma %u $ma \n"
  
  
   memfill(ma,INT_,0xace2face)
  
  <<"%X $I[0] $I[1] $I[2] $I[3] $I[4] \n"
  <<"\n OCTDUMP \n"
  <<"%(4,, ,\n)%o$I[0:N-1] \n"
  
  
  uchar C[4096]
  
   mad = memaddr(&C)
   mas = memaddr(&I[0])
  
   memcopy(mad,mas, (N * 4))
  
   ec = N * intsz -1
   <<"\n HEXDUMP \n"
   <<"%(8,, ,\n)%hx$C[0:ec] \n"
  
  // <<"\n OCTDUMP \n"
  // <<"%(4,, ,\n)%o$C[0:ec] \n"
  
  
  
  ////////////////////////
  
  int AV[>10]
  int b[>2]
  
  //ptr d
  
  // AV[0:20:2] = 3
  
  
   AV[0:20:2].Set(3)
  
  <<" $AV \n"
  
   b[0:20:2].Set(2,4)
  
  <<"%v $b \n"
  
  <<"%v $AV \n"
  
  <<" $(typeof(AV)) \n"
  
     d = &AV
  
!i d
  
  <<" ptr %v $d \n"
  
   AV[0:20:2].Set(4,3)
  
  <<" reset %v $AV \n"
  
  <<" ptr update %v $d \n"
  
   c = d 
  
  <<" $c \n"
  
  <<"%v $c \n"
  
    d[0:20:2].Set(5,3)
  
  
  <<"%v $AV \n"
  
  <<"%v $d \n"
  
    <<"%v $AV \n"
  
  <<"%v $d \n"
  
      d = &b
  
  <<"%v $d \n"
  
  
  
  
  
chkOut()
