/* 
 *  @script classbops.asl                                               
 * 
 *  @comment test class basic ops                                       
 *  @release Boron                                                      
 *  @vers 1.3 Li Lithium [asl 5.79 : B Au]                              
 *  @date 01/29/2024 15:23:14                                           
 *  @cdate Tue Mar 12 07:50:33 2019                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


<|Use_= 
Demo  of class ops
/////////////////////// 
|>

   <<"$Use_ \n" 

#include "debug";

if (_dblevel > 0) {
   debugON()
}

allowErrors(-1) ; // keep going

chkIn(_dblevel);


#include "abc.asl"


   DB_action = 0


  double x1;
// wdb=DBaction((DBSTEP_| DBSTRACE_),ON_)
  x1.pinfo();




//////////////////////////////////////////////////////
real goo( real x)
{
  a= x * 2;
<<"$_proc %V $x $a\n";
  return a
}
//==================//

//allowDB("spe_,ds_,oo_")

b=goo(1.2)
<<" goo $b\n"

chkN(b,2.4)

chkStage("proc var")

b=goo(sin(0.7))

<<" goo $b\n"

   b=goo(77.6)
<<"goo $b\n"

  int hoo (int h, int m)
  {
   htmp = h * m
   return htmp

  }

  kr = hoo (4, 3)

  <<"%V $kr\n"

  kr = hoo (8, 2)

  <<"%V $kr\n"

  kr = hoo(kr, kr)

  <<"%V $kr\n"





ans=ask(DB_prompt,DB_action);
/// must have a CONS -- else crash in xic??

class Point
  {

  public:
  
    float x;
    float y;
    double DV[10];
//============================//


     float setx (real m) {
      m.pinfo()
      x = m;
      <<"$_proc $m $x  \n"; 
      return x;
      }


    void setr (real m, real n) 
    {
  <<"IN $_proc set via real %V $m $n  \n";
       x = m;
       y = n;
       y.pinfo()
   <<"%V $m $n \n" 
      }

    void set (float m,float n) {
    
  <<"$_proc set via float %V $m $n  \n";
       x = m;
       y = n;
   <<"%V $m $n \n" 
      }

    void set (double m, double n) {
    
  <<"$_proc set via double %V $m $n  \n";
  
       x = m;
       y = n;
       
   <<"%V $x $y \n" 
      }


    void set (int m, int n) {
    
       x = m;
       y = n;
      <<"set via ints %V $m $n $x $y \n";
      };
 
    float Getx() {

    <<"$_proc getting $x $_cobj \n";

//      v=y.isVector()
//   <<"%v$v\n"
//      dv= DV.isVector()
//   <<"%v$dv\n"
//     dv.pinfo()
//      z = x;
//      z.pinfo()
//     <<"%V $z  $x\n"
       x.pinfo()
      
      return x;
      }
    
    float Gety()
     {
      <<"getting $y  $_cobj  \n"; 
      return y;
      }

    double  mul(real a)
    {
      double tmp;
      x.pinfo()
      tmp = (a * x);
    <<"$_proc %V $a $tmp $x\n";         
      return tmp; 
      }

    float  mul(int mi)
    {
      float tmpf;
      tmpf  = mi * x;
    <<"$_proc %V $mi $x  $tmpf \n";               
      return tmpf; 
      }
    
    //void Print()
    float Print()
      {
//         <<"%V $x , $y %i $x,$y\n";
          <<"%V $x , $y \n";
	  y.pinfo()
	  x.pinfo()
	  return y;
      }

     void info()
     {
      <<"$_proc %V $x,$y\n";
 //      v= y<-isVector()

v= y.isVector()
   <<"%v$v\n"	
      y.pinfo()
      x.pinfo()
      }
      

   void Point()
   {
    // same name as class is the constructor
     y=2;
     x=4;
<<"cons $_proc  %V $x $y \n"
   }

}



////////////////////////////////////////////


// 

//wdb=  DBaction((DBSTEP_),ON_)

  Point A;

  rx  =  Sin(d2r(90)) 

  chkR(rx,1.0)
 



  rx=   A.Getx();

 <<"%V <|$rx|>\n"
  chkN(rx,4.0)

ans=ask(DB_prompt,DB_action);

chkStage("class print OK?")




  A.pinfo()

  A.x = 3.4

  x1= A.x;

<<"$x1\n"

  chkR(x1,3.4)

  rx=   A.Getx();
 <<"%V <|$rx|>\n"
  chkN(rx,3.4)

   A.pinfo()


   
//allowDB("spe_proc,spe_state,spe_vmf,oo_")
   A.setx(77.34)

   A.pinfo()

   rx=   A.Getx();

 <<"%V <|$rx|>\n"



   chkR(rx,77.34,4);


   A.x = 4.0

   rx=   A.Getx();

 <<"%V <|$rx|>\n"



   chkR(rx,4.0);




  Point B;

  Point C;

  Point D;

  rx= D.Getx();

  rx.pinfo()
  
<<"%V $rx\n"

  chkR(rx,4.0);

//ans=ask(DB_prompt,DB_action);

real r1 = 2.3;
real r2 = 4.5;


 <<"%V <|$r1|>\n"

  rx=   A.Getx();
  
 <<"%V <|$rx|>\n"

    chkR(rx,4.0);

//ans=ask(DB_prompt,DB_action);

//wdb=  DBaction((DBSTEP_|DBSTRACE_|DBALLOW_ALL_),ON_)
 //<<"$wdb \n"


  r1.pinfo()

  A.setx(r1);

  rx=   A.Getx();

  chkR(r1,rx)
<<"%V $r1  $rx \n"



  r2.pinfo()


  my = A.mul(r2 );

  ra = rx * r2 
  
  <<"%V $my $A.x $ra \n";

  chkN(my,ra)
  


  my = A.mul( Sin(-0.9) ); 
  
  <<"%V$my $A.x  \n";

  r2 = Sin(0.7)


 my = A.mul(r2 ); 
  
  <<"%V$my $A.x  \n";

  r2 = Sin(-0.9)


 my = A.mul(r2 ); 
  
  <<"%V$my $A.x  \n";

  my = A.mul( Sin(-0.8) ); 
  
  <<"%V$my $A.x  \n";




//allowDB("spe_proc,spe_state,spe_vmf,oo_")
//wdb=  DBaction((DBSTEP_),ON_)
//<<"$wdb \n"

  A.setr(2.2,0.123);

  rx= A.Getx();
<<"%V $rx\n"
  chkR(rx,2.2)

  A.setr(0.15, 0.2);
  rx= A.Getx();
<<"%V $rx\n"
  chkR(rx,0.15)
  
  ok=chkR(A.x,0.15,5);
  chkR(A.x,0.15,5);

//  ans=ask(DB_prompt,DB_action,5);



  B.set(4,2);
  rx=   B.Getx();
  <<"%V $rx\n"

  B.set(2.2,0.123);

  B.Print();

<<"%V $B.x $B.y \n"; 
  
  <<"%V $A.x $A.y \n"; 
  
  <<" A.Print() \n"; 

  A.Print(); 
 
  //ans=ask(DB_prompt,DB_action,5);

  
  
//ax= A[0].x ; // treat  as array ? error if not - do not crash warn
//<<"%V $ax $A[0].x \n"

  ax= A.x

<<"%V $ax $A.x \n"




 // ok=chkR(A[0].y,0.2,5); 

  ok=chkR(A.x,0.15,5);
  
  <<" B.Print() \n"; 
  B.Print(); 
  
  
  <<"%V $B.x $B.y \n"; 
  
  
  ok=chkR(B.x,2.2,5);
  
  ok=chkR(B.y,0.123,5); 
  
  C.set(1.1,0.2); 

  C.Print();
  
  cy = C.Gety()

  <<"%V $C.x $C.y $cy\n"; 

chkR(cy,0.2);


  wx = A.Getx();
  
  ok=chkR(wx,0.15,5); 



  A.set(47, 79);
  
  A.Print(); 
  
  B.set(83, 65);
  A.Print(); 
  B.Print(); 
  
  D.x = B.x;
  
  chkN(D.x,83); 
  
  D.Print(); 
  
  D.y = A.y;
  
  chkN(D.y,79); 
  
  
  D.Print(); 
  
  
  chkN(D.y,A.y); 
  
  
  <<" 1/////////////////\n"; 
  
  <<"%V$ok x  $wx 0.15\n"; 
  
  wy = A.Gety(); 
  <<"%V $wy $A.Gety()\n"; 
  
  
  ok=chkR(wy,79,5); 
  <<"%Vok y $wy 79\n"; 
  
  <<" 2/////////////////\n"; 
  
  
  A.Print();
  B.Print();
  
  ax = A.Getx();
  <<"A %V $ax \n";
  
  chkR(ax,47,5);
  ay = A.Gety();
  <<"A %V $ay \n"; 

  chkR(ay,79,5); 
  
  A.Print();
  
   axy = A.Getx() + A.Gety();

<<"%V $axy $ax $ay\n"

   axy = A.Gety() + A.Getx();
   axy2 = ax + ay;
   axy3 = ax + ay;   
<<"%V $axy $axy2 $axy3 $ax $ay\n"

  chkR(axy,(ax+ay),5);

  bx = B.Getx();

  chkR(bx,83,5); 

  by = B.Gety();
  
  chkR(by,65,5); 

  bxy = B.Getx() + B.Gety();

<<"%V $bxy $bx $by\n"

  axy = A.Getx() + A.Gety();

<<"%V $axy $ax $ay\n"
  
  chkR(axy,(ax+ay),5); 


  bxy = B.Getx() + B.Gety(); 
  chkR(bxy,(bx+by),5);
  
  z2 = A.x + B.y; 
  
  z = A.Getx() + B.Gety(); 
  
  <<"%V $ax $ay $axy $bx $by  $bxy $z2 $z\n"; 
  
  
  chkR(z2,(ax+by),5); 
  
  chkR(z,(ax+by),5); 
  
  <<"%V $z $wx $wy \n"; 
  
  z = A.Getx() * A.Gety(); 
  
  <<"%V $z $wx $wy \n"; 
  
  my = B.y; 
  cy = C.y;
  <<"%V $B.y  $my $cy $C.y\n"; 
  
  my = B.y - C.y;

 <<"%V$ok $B.y - $C.y =  $my \n"; 

  ok=chkR(my,(65-0.2),4); 
 

  my = ((B.y - C.y)/2.0) + C.y; 
  
  <<"%V $B.y $C.y  $my \n"; 
  
  ok=chkR(my,32.6,4); 
  <<"%V$ok $my 1.1\n"; 
  

  
  Point P[3];
  
  chkProgress(" 4"); 
  v  = 1.3; 
  
  
//  ws = nsc(20,'\')   // escaped ' ??
//<<"$ws\n"
  
//  <<"$(nsc(20,'\'))\n"
  
    v= B.y/2.0;
  for (i = 0; i < 4 ; i++) {
    
  
    my = B.y/2.0 ; 
  <<"%V $i $B.y    $my $v \n"; 
    
    ok=chkR(my,v,5); 
    chkProgress(" for $i"); 
    <<"%V$ok $i $my $v\n"; 
    B.y += 0.2; 
    v  =  B.y/2.0;

    }
  
//<<"$(nsc(20,'/'))\n"
  
  
  chkN(i,4); 
  
  chkProgress("$i  i == 4 ");



  v = B.Gety(); 
  <<" $v\n"; 
  v1 = C.y;
  <<" $v1\n"; 
  v -= C.y; 
  
  <<" $v\n"; 
  
  chkProgress();
    
  chkProgress("  v -= C.y ");
  
  
  my = B.Gety() - C.y; 
  <<"%V$ok $my $v\n"; 
  ok=chkR(my,v,5); 

//allowDB("spe_,ds_,oo_,rdp,opera")
//wdb=DBaction((DBSTEP_| DBSTRACE_),ON_)

  v = A.Getx(); 
  v *= 2; 
  my = A.mul(2); 
  
  <<" %V $A.x $my $v \n"; 
  
  chkN(my,v); 



  u = B.Getx(); 
<<"%V $u \n"
  u *= 3; 
<<"%V $u \n"

  my = B.mul(3); 
  
  <<"%V $B.x $my $u \n"; 



  chkR(my,u,6); 
  
  float w = v + u; 
  
  my = A.mul(2) + B.mul(3); 
  
  <<" %V $w $my $v $u \n"; 
  
  chkR(my,w,6); 
  
  
  <<" %V $A.x $B.x \n"; 
//ans=ask(DB_prompt,DB_action,5);

  my = A.mul ( B.x );   // TBF 12/11/23 obj.arg
  
  <<" %V $my $A.x $B.x \n"; 


  val = A.x * B.x;
  <<"%V $val\n"
//ans=ask(DB_prompt,DB_action,5);  
  chkR(my,3901,6); 
  
  my = A.mul(B.y) + B.mul(A.x); 

  mya = A.mul(B.y);
  mya.pinfo()
  
  myb = B.mul(A.x);
  myb.pinfo()
<<"$B.x $B.y $A.x $A.y\n"


  my2 = A.x * B.y   + B.x * A.x;
  
<<"%V $my $mya $myb  $my2 $(mya * myb)\n"
  
  ok=chkR(my,my2,3); 
  <<"%V$ok  $my == 0.6 $A.x $B.x \n"; 
  my = Sin(0.5); 
  
  <<"Sin  %V $my \n"; 
  
  v = my * A.x; 
  
  my = A.mul( Sin(0.5) ); 
  
  
  <<"%V$my $A.x  $v \n"; 
  
  chkR(my,v,5); 
  
  
//FIXME   my = A.mul( Sin(0.5) )
//<<" %V $my $A.x  \n"
  
  
  my = A.mul( Sin(0.7) ); 
  
  
  <<"%V$my $A.x  \n"; 


//ans=ask(DB_prompt,DB_action,5);  

  r1 = B.Getx()

<<"%V$r1\n"; 

  my = A.mul( r1); 





  my2 = A.x    * B.Getx()

<<" %V $my $my2 $A.x $B.x \n";

   b=goo(77.6)
<<"goo $b\n"
//ans=ask(DB_prompt,DB_action,5);

cmf_arg =1
if (cmf_arg) {

// wdb=DBaction((DBSTEP_| DBSTRACE_),ON_)
// <<" %x $wdb\n"
   my3 = B.Getx() ;

   my3 = A.mul( my3 ); 

chkR(my3,my2,3); 

  my3 = A.mul( B.Getx() ); // TBF -- svarg arg bad  after nesting ?



<<" %V $my $my2 $my3 $A.x $B.x \n";   
  
  chkR(my,my2,3);

  chkR(my3,my2,3); 

}



//DBaction((DBSTEP_| DBSTRACE_),ON_)

   b=goo(65.6)

<<"goo $b\n"
//ans=ask(DB_prompt,DB_action,5);

<<"checking out \n":

  chkOut(1); 



/*  
/// TBD ///////////
/// still have to check this  gives correct answer  for
///
//  A.x     - done
//  A.Getx() - done
//  A.mul(z) - done
//  A.Getx() + B.Getx() + ...
//  A.add( B.Gety(), C.Gety())  ...
//  A.x.z ....
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
