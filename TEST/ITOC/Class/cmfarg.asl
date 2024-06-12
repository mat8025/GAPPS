///
///
///


#include "debug";

if (_dblevel >0) {
   debugON()

}

allowErrors(-1) ; // keep going

chkIn();

float hoo( float ya) {
<<"$_proc getting $ya   \n";
  ya.pinfo()
  z= ya +17;
  z.pinfo()
  return z;
}


float goo( float ya) {

   ya.pinfo();

<<"$_proc    $ya\n"
  return (ya +1);
}



float roo( float ya) {

   ya.pinfo();

<<"$_proc    $ya\n"
  return (ya +2);
}

 

  hy = 33.77
//DBaction((DBSTEP_),ON_)



<<" do we see this ??\n"
//wdb=DBaction((DBSTEP_|DBSTRACE_),ON_)
  hz= hoo ( hy)

 <<"%V $hy $hz \n"
// ans=ask(DB_prompt,DB_action);



  chkR(hz, 50.77)



 roo ( hy )


 hz2 =goo ( hy )


 goo (hz2)
//wdb=DBaction((DBSTEP_),ON_)
 hz= hoo ( hy)

 <<"%V $hy $hz \n"
 

// ans=ask(DB_prompt,DB_action);




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
  
 //  double  Pmul(real a) {
   double  Pmul(float a) {
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

//allowDB("oo_,spe_proc,spe_vmf,tok_func,ic_")
//DBaction((DBSTEP_| DBSTRACE_),ON_)
//DBaction((DBSTEP_),ON_)

 rx=   A.Getx();

 <<"%V $rx \n"

 chkR(rx,3)

//ans=ask("Strace ? [y,n]",DB_action);
//if (ans == "y") {
// DBaction((DBSTEP_| DBSTRACE_),ON_)
//}

allowDB("oo_,spe_proc,spe_args,spe_cmf,tok_func")
DBaction((DBSTEP_),ON_)
  dx = A.Setx( rx );

<<"%V $dx \n"

ans=ask(DB_prompt,DB_action);

  hz = hoo(rx)


DBaction((DBSTEP_| DBSTRACE_),ON_)
  A.Setx( hoo( rx) );

  ry=   A.Getx();

 <<"%V $hz $ry \n"
 
 chkR(ry,hz)

//ans=ask(DB_prompt,DB_action);

   ry = B.Pmul( rx) ;


 <<"%V $ry \n"

   A.Setx( B.x );

   ry=   A.Getx();

 <<"%V $ry \n"

   brx = B.Getx();


//DBaction((DBSTEP_| DBSTRACE_),ON_)
//DBaction((DBSTEP_),ON_)

  A.Setx( B.Pmul( rx) );

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