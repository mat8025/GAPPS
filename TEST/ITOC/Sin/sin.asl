
//
// test Sin function
//

chkIn()
 double a = 1.0;

 a = Sin(0.5)

chkR(a,0.479426)

<<"%V $a = Sin(0.5) \n"

<<"%V $a = $(Sin(0.5)) \n"

 a = Cos(0.5)

chkR(a,0.877583)

<<" $a = $(Cos(0.5)) \n"

 a = Tan(0.5)
<<"Tan $a = $(Tan(0.5)) \n"

 a = Log(0.5)
<<"Log(0.5) $a = $(Log(0.5)) \n"
 a = 4*atan(1.0)
<<"atan(1.0) $a = $(atan(1.0)) $(4*a)\n"
chkR(a,3.141593)

 c = Cos(a);
 b = Sin( Cos(a));
 d = Sin(c);
<<"Sin( Cos(a))  $a $b $d\n"

 e = Sin ( Cos(a,b))

<<"%V $e\n";

 float V[5];

 V[0] = a;
 V[1] = b;
 V[2] = c;
 openDll("plot");
 rsz = wbox(1,2,3,4);
 rsz.pinfo();

 printargs(1,a,b,Sin(c), V, wbox(1,2,3,4,5));

<<"wbox int \n"


  printargs(1,a,b,Sin(c), V, wbox(a,2,3,4,5));

<<"wbox did float a, \n"

  printargs(1,a,b,Sin(c), V, wbox(a,b,c,4,5.3));

<<"wbox did float a, 5.3\n"

  printargs(1,a,b,Sin(c), V, wbox(a,b,c,4.0,5.3));

<<"wbox did float a, 4.0,5.3\n"

  printargs(1,a,b,Sin(c), V, wbox(0.4,0.92,0.35,4.4,5.0));

<<"wbox float2 \n"

  printargs(1,a,b,Sin(c), V, wbox(0.4));

<<"wbox float3 \n"

  printargs(1,a,b,Sin(c), V, wbox(0.4,0.5));

<<"wbox float4 \n"

  printargs(1,a,b,Sin(c), V, wbox(a));

<<"wbox float5 \n"

chkOut()
