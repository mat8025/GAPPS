///
///
///



#include "debug";

if (_dblevel >0) {
   debugON()

}

allowErrors(-1) ; // keep going

chkIn(_dblevel);



float hoo( float ya) {
  z= ya +17;
 <<"$_proc getting $y $ya $z $_cobj \n";
  z.pinfo()
  ya.pinfo()
return z;
}


float goo( float ya) {

   ya.pinfo();

<<"$_proc    $ya\n"
  return (ya +1);
}

allowDB("ic_,oo_,spe_proc,spe_state,spe_args,spe_cmf,spe_scope,tok_func")

float roo( float ya) {

   ya.pinfo();

<<"$_proc    $ya\n"
  return (ya +2);
}

/*
float hoo( float ya) {
  z= ya +17;
 <<"$_proc getting $y $ya $z $_cobj \n";
  z.pinfo()
  ya.pinfo()
return z;
}
*/

 

  hy = 33.77
//DBaction((DBSTEP_),ON_)



<<" do we see this ??\n"

  hz= hoo ( hy)

 <<"%V $hy $hz \n"

//wdb=DBaction((DBSTEP_|DBSTRACE_),ON_)
wdb=DBaction((DBSTEP_),ON_)

  chkR(hz, 50.77)



 roo ( hy )


 hz2 =goo ( hy )


 goo (hz2)

 ans=ask(DB_prompt,DB_action);




class Point
  {

  public:
  
    float x;
    float y;


     float Setx(float m) {
     
      x = m;
      <<"$_proc $m setting $x  \n"; 
      return x;
      }


  float Getx() {
      <<"$_proc getting $x $_cobj \n";

        x.pinfo()
       
       return x;
  }
  
   double  mul(real a) {
      double tmp;
      tmp = (a * x);
    <<"$_proc %V $a $x $tmp $x\n";         
      return tmp; 
   }


void Point()
   {
    // same name as class is the constructor

     y=2;
     x=3;
<<"cons $_proc  %V $x $y \n"
   }

}




 
  Point A;
  Point B;

allowDB("oo_,spe_proc,spe_vmf,tok_func,ic_")
//DBaction((DBSTEP_| DBSTRACE_),ON_)
DBaction((DBSTEP_),ON_)
 rx=   A.Getx();


 <<"%V $rx \n"


 chkR(rx,3)

ans=ask(DB_prompt,DB_action);

  A.Setx( hoo( rx) );

  ry=   A.Getx();


 <<"%V $ry \n"
 chkR(ry,20)

ans=ask(DB_prompt,DB_action);

   ry = B.mul( rx) ;


 <<"%V $ry \n"

   A.Setx( B.x );

   ry=   A.Getx();

 <<"%V $ry \n"

   brx = B.Getx();


//DBaction((DBSTEP_| DBSTRACE_),ON_)
//DBaction((DBSTEP_),ON_)

  A.Setx( B.mul( rx) );

   rxy = rx * brx

   ry=   A.Getx();

 <<"%V $rx $brx $ry $rxy\n"

  if (ry == rxy) {

 <<"%V $ry == $rxy\n"
  }

  chkR(ry,rxy)

  chkOut(); 

  exit(-1)

//////////////////////////