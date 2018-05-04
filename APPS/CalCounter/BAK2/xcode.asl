

proc addem( a,b)
{

  c= a+b;
  return c;
}
//==============================


<<" after proc def addem\n"     

proc subem( a,b)
{

  c= a-b;
  return c;
}
//==============================
<<" after proc def subem\n"

proc mulem( a,b)
{

  c= a*b;
  return c;
}

<<" after proc def mulem\n"


//////////////////////////

x= 2;
y= 2;


  z= addem(x,y)

<<"$z = $x + $y \n"


  z= subem(x,y)

<<"$z = $x - $y \n"


  z= mulem(x,y)

<<"$z = $x * $y \n"
