/* 
 *  @script classbops.asl 
 * 
 *  @comment test class basic ops 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.29 C-Li-Cu] 
 *  @date 03/08/2021 11:24:33 
 *  @cdate Tue Mar 12 07:50:33 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                         

#include "debug";



if (_dblevel >0) {
   debugON()
}
  
chkIn(_dblevel);


#include "abc"




//////////////////////////////////////////////////////
proc goo( real x)
{
  a= x;
<<"$_proc %V $x $a\n";
}
//==================//

goo(1.2)

goo(sin(0.7))

/// must have a CONS -- else crash in xic??

class Point
  {

  public:
  
    float x;
    float y;

//============================//


   cmf setx(real m) 
     {
      x = m;
      <<"$_proc $m $x  \n"; 
      return x;
      };


    cmf set (real m,real n) 
    {
  <<"$_proc set via real %V $m $n  \n";
       x = m;
       y = n;
   <<"%V $m $n \n" 
      };

    cmf set (float m,float n) 
    {
  <<"$_proc set via float %V $m $n  \n";
       x = m;
       y = n;
   <<"%V $m $n \n" 
      };

    cmf set (double m, double n) 
    {
  <<"$_proc set via double %V $m $n  \n";
       x = m;
       y = n;
   <<"%V $m $n \n" 
      };


    cmf set (int m, int n) 
    {
       x = m;
       y = n;
      <<"set via ints %V $m $n $x $y \n";
      };
 
    cmf getx() 
     {
      <<"$_proc getting $x $_cobj \n"; 
      return x;
      };
    
    cmf gety()
     {
      <<"getting $y  $_cobj  \n"; 
      return y;
      };

    cmf  mul(real a) {
      double tmp;
      tmp = (a * x);
    <<"$_proc %V $a $tmp $x\n";         
      return tmp; 
      };

    cmf  mul(int mi) {
      float tmp;
      tmp = (mi * x); 
      return tmp; 
      };
    
    cmf Print() {
      <<"%V $x,$y %i $x,$y\n"; 
      }

   cmf Point()
   {
    // same name as class is the constructor

     y=2;
     x=4;
<<"constructor $_proc  %V $x $y \n"


   };

}



////////////////////////////////////////////
  
  Point A;


  A->x = 3.4

  x1= A->x;


<<"$x1\n"

  chkR(x1,3.4)




 A->x = 4.0
 
  Point B;

  Point C;

  Point D;

  rx= D->getx();

<<"%V $rx\n"

real r1 = 2.3;
real r2 = 4.5;


  rx=   A->getx();
  <<"%V $rx\n"

  chkR(rx,4.0);


  A->setx(r1);
  rx=   A->getx();
  <<"%V $rx\n"

  chkR(r1,rx)



 my = A->mul(r2 ); 
  
  <<"%V$my $A->x  \n";



  my = A->mul( Sin(-0.9) ); 
  
  <<"%V$my $A->x  \n";

  r2 = Sin(0.7)


 my = A->mul(r2 ); 
  
  <<"%V$my $A->x  \n";




  r2 = Sin(-0.9)


 my = A->mul(r2 ); 
  
  <<"%V$my $A->x  \n";

  my = A->mul( Sin(-0.8) ); 
  
  <<"%V$my $A->x  \n";







  A->set(2.2,0.123);
  rx=   A->getx();
  <<"%V $rx\n"

  B->set(4,2);
  rx=   B->getx();
  <<"%V $rx\n"



  B->set(2.2,0.123);

  B->Print();

<<"%V $B->x $B->y \n"; 




  
  
  <<"%V $A->x $A->y \n"; 
  
  <<" A->Print() \n"; 

  A->Print(); 

  A->set(0.15, 0.2);

  //ax= A[0]->x ; // treat  as array ? error if not - do not crash warn
  

//<<"%V $ax $A[0]->x \n"

  ax= A->x

<<"%V $ax $A->x \n"

  ok=chkR(A->x,0.15,5);





 // ok=chkR(A[0]->y,0.2,5); 

  ok=chkR(A->x,0.15,5);
  
  <<" B->Print() \n"; 
  B->Print(); 
  
  
  <<"%V $B->x $B->y \n"; 
  
  
  ok=chkR(B->x,2.2,5);
  
  ok=chkR(B->y,0.123,5); 
  
  C->set(1.1,0.2); 
  
  <<"%V $C->x $C->y \n"; 
  
  
  wx = A->getx();
  
  ok=chkR(wx,0.15,5); 
  
  A->set(47, 79);
  
  A->Print(); 
  
  B->set(83, 65);
  A->Print(); 
  B->Print(); 
  
  D->x = B->x;
  
  chkN(D->x,83); 
  
  D->Print(); 
  
  D->y = A->y;
  
  chkN(D->y,79); 
  
  
  D->Print(); 
  
  
  chkN(D->y,A->y); 
  
  
  <<" 1/////////////////\n"; 
  
  <<"%V$ok x  $wx 0.15\n"; 
  
  wy = A->gety(); 
  <<"%V $wy $A->gety()\n"; 
  
  
  ok=chkR(wy,79,5); 
  <<"%Vok y $wy 79\n"; 
  
  <<" 2/////////////////\n"; 
  
  
  A->Print();
  B->Print();
  
  ax = A->getx();
  <<"A %V $ax \n";
  
  chkR(ax,47,5);
  ay = A->gety();
  <<"A %V $ay \n"; 

  chkR(ay,79,5); 
  
  A->Print();
  
   axy = A->getx() + A->gety();

<<"%V $axy $ax $ay\n"

   axy = A->gety() + A->getx();
   axy2 = ax + ay;
   axy3 = ax + ay;   
<<"%V $axy $axy2 $axy3 $ax $ay\n"

  chkR(axy,(ax+ay),5);
chkOut()  
  bx = B->getx();

  chkR(bx,83,5); 

  by = B->gety();
  
  chkR(by,65,5); 

  bxy = B->getx() + B->gety();

<<"%V $bxy $bx $by\n"

  axy = A->getx() + A->gety();

<<"%V $axy $ax $ay\n"
  
  chkR(axy,(ax+ay),5); 
  chkOut()

  bxy = B->getx() + B->gety(); 
  chkR(bxy,(bx+by),5);
  
  z2 = A->x + B->y; 
  
  z = A->getx() + B->gety(); 
  
  <<"%V $ax $ay $axy $bx $by  $bxy $z2 $z\n"; 
  
  
  chkR(z2,(ax+by),5); 
  
  chkR(z,(ax+by),5); 
  
  <<"%V $z $wx $wy \n"; 
  
  z = A->getx() * A->gety(); 
  
  <<"%V $z $wx $wy \n"; 
  
  my = B->y; 
  
  <<"%V $B->y  $my \n"; 
  
  my = B->y - C->y;
  
  ok=chkR(my,(65-0.2),4); 
  <<"%V$ok $B->y - $C->y =  $my \n"; 
  
  
  my = ((B->y - C->y)/2.0) + C->y; 
  
  <<"%V $B->y $C->y  $my \n"; 
  
  ok=chkR(my,32.6,4); 
  <<"%V$ok $my 1.1\n"; 
  
 //setdebug(1,"step")
  
  Point P[3];
  
  chkProgress(" 4"); 
  v  = 1.3; 
  
  
//  ws = nsc(20,'\')   // escaped ' ??
//<<"$ws\n"
  
//  <<"$(nsc(20,'\'))\n"
  
    v= B->y/2.0;
  for (i = 0; i < 4 ; i++) {
    
  
    my = B->y/2.0 ; 
  <<"%V $i $B->y    $my $v \n"; 
    
    ok=chkR(my,v,5); 
    chkProgress(" for $i"); 
    <<"%V$ok $i $my $v\n"; 
    B->y += 0.2; 
    v  =  B->y/2.0;

    }
  
//<<"$(nsc(20,'/'))\n"
  
  
  chkN(i,4); 
  
  chkProgress("$i  i == 4 ");



  v = B->gety(); 
  <<" $v\n"; 
  v1 = C->y;
  <<" $v1\n"; 
  v -= C->y; 
  
  <<" $v\n"; 
  
  chkProgress();
    
  chkProgress("  v -= C->y ");
  
  
  my = B->gety() - C->y; 
  <<"%V$ok $my $v\n"; 
  ok=chkR(my,v,5); 
  
  v = A->getx(); 
  v *= 2; 
  my = A->mul(2); 
  
  <<" %V $A->x $my $v \n"; 
  
  chkN(my,v); 
  
  u = B->getx(); 
  u *= 3; 
  my = B->mul(3); 
  
  <<" %V $B->x $my $u \n"; 
  
  chkR(my,u,6); 
  
  float w = v + u; 
  
  my = A->mul(2) + B->mul(3); 
  
  <<" %V $w $my $v $u \n"; 
  
  chkR(my,w,6); 
  
  
  <<" %V $A->x $B->x \n"; 
  
  my = A->mul(B->x); 
  
  <<" %V $my $A->x $B->x \n"; 


  val = A->x * B->x;
  <<"%V $val\n"

  chkR(my,3901,6); 
  
  my = A->mul(B->y) + B->mul(A->x); 

  mya = A->mul(B->y);
  myb = B->mul(A->x);
<<"$B->x $B->y $A->x $A->y\n"
  my2 = A->x * B->y   + B->x * A->x;
  
<<"%V $my $mya $myb  $my2 $(mya * myb)\n"
  
  ok=chkR(my,my2,3); 
  <<"%V$ok  $my == 0.6 $A->x $B->x \n"; 
  my = Sin(0.5); 
  
  <<"Sin  %V $my \n"; 
  
  v = my * A->x; 
  
  my = A->mul( Sin(0.5) ); 
  
  
  <<"%V$my $A->x  $v \n"; 
  
  chkR(my,v,5); 
  
  
//FIXME   my = A->mul( Sin(0.5) )
//<<" %V $my $A->x  \n"
  
  
  my = A->mul( Sin(0.7) ); 
  
  
  <<"%V$my $A->x  \n"; 

  chkOut(); 


  r1 = B->getx()

<<"%V$r1\n"; 

  my = A->mul( r1); 

  my3 = A->mul( B->getx() ); 

<<" %V $my $my3 $A->x $B->x \n"; 



  my2 = A->x    * B->getx()

<<" %V $my $my2 $A->x $B->x \n"; 

  
  
  chkR(my,my2,3); 
  
  chkOut(); 

  
/*  
/// TBD ///////////
/// still have to chk this  gives correct answer  for
///
//  A->x     - done
//  A->getx() - done
//  A->mul(z) - done
//  A->getx() + B->getx() + ...
//  A->add( B->gety(), C->gety())  ...
//  A->x->z ....
//  ...
*/  
  
      
/*
    cmf  mul( a) {
      float tmp;
      tmp = (a * x); 
      return tmp; 
      }


    cmf  mul(float a) {
      float tmp;
      
      tmp = (a * x);
    <<"$_proc %V $a $tmp $x\n";   
      return tmp; 
      }
*/
