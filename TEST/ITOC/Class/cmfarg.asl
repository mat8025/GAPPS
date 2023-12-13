///
///
///


#include "debug";

if (_dblevel >0) {
   debugON()
   <<"$Use_ \n" 
}

allowErrors(-1) ; // keep going

chkIn(_dblevel);


float hoo( float ya) {
  z= ya +17;
 <<"$_proc getting $y $ya $z $_cobj \n";
return z;
}



class Point
  {

  public:
  
    float x;
    float y;


     float Setx(float m) {
     
      x = m;
      <<"$_proc $m $x  \n"; 
      return x;
      }


  float Getx() {
      <<"$_proc getting $x $_cobj \n";
       return x;
  }
  
   double  mul(real a) {
      double tmp;
      tmp = (a * x);
    <<"$_proc %V $a $tmp $x\n";         
      return tmp; 
   }


void Point()
   {
    // same name as class is the constructor

     y=2;
     x=4;
<<"cons $_proc  %V $x $y \n"
   }

}



// ans=ask(DB_prompt,DB_action);
 
  Point A;
  Point B;

 rx=   A.Getx();


 <<"%V $rx \n"
 chkR(rx,4)

  A.Setx( hoo( rx) );

  ry=   A.Getx();


 <<"%V $ry \n"
 chkR(ry,21)

   ry = B.mul( rx) ;


 <<"%V $ry \n"

   A.Setx( B.x );

   ry=   A.Getx();

 <<"%V $ry \n"
allowDB("ic_,oo_,spe_proc,spe_state,spe_cmf,spe_scope")
DBaction(DBSTEP_,ON_)
  A.Setx( B.mul( rx) );


   ry=   A.Getx();

 <<"%V $ry \n"

  chkOut(); 

 
