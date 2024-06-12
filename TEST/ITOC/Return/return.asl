//%*********************************************** 
//*  @script return.asl 
//* 
//*  @comment test of proc return - simple vers 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.3.2 C-Li-He]                                
//*  @date Mon Dec 28 17:37:54 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


chkIn()

int  add_it(int a,int b)
{
  c= a +b
<<"INT %V $a  $(typeof(a)) $b $(typeof(b)) $c   $(typeof(c))\n"
  return c;
}

float add_it(float a, float b)
{

  c= a +b
<<"FLOAT %V $a  $(typeof(a)) $b $(typeof(b)) $c   $(typeof(c))\n"
  return c;
}

double add_it(double a, double b)
{

  c= a +b
<<"DOUBLE %V $a  $(typeof(a)) $b $(typeof(b)) $c   $(typeof(c))\n"
  return c;
}


short add_it(short a, short b)
{

  c= a +b
<<"SHORT %V $a  $(typeof(a)) $b $(typeof(b)) $c   $(typeof(c))\n"
  return c;
}




int  j = 7
int  k = 5


 m = add_it(k,j)
 chkN(m,12)
<<"$k + $j = $m   $(typeof(m))\n"

  float x = 12.6
  float y = 13.5

  z = add_it(x,y)

chkR(z,26.1)

<<"$x + $y = $z $(typeof(z))\n"

 double dx = 12.6
 double dy = 13.5

  dz = add_it(dx,dy)

chkR(dz,26.1)

<<"$dx + $dy = $dz $(typeof(dz))\n"


short r = 128
short s = -14


 t = add_it(r,s)

chkN(t,114)
<<"$r + $s = $t $(typeof(t))\n"

chkOut()