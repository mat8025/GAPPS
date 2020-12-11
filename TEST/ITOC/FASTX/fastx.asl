//%*********************************************** 
//*  @script fastx.asl 
//* 
//*  @comment test mods to speedup XIC 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.95 C-He-Am]                               
//*  @date Thu Dec 10 13:08:09 2020 
//*  @cdate Thu Dec 10 13:08:09 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///
///#include "debug"
//debugON()

/// need some mods to speed up XIC

//sdb(1,@pline,@trace)

    int a;
    short b;
    long d;

      a= 61;
      b = 75;
      d = 26;
      
    c = a +b - d ;

<<"%V $c = $a +$b - $d \n"

     for (i = 0; i < 3; i++) {

    c = a +b - d + 7;

<<"%V $c = $a +$b - $d \n"
      a++;
     }






    float x;
    double y;

      x= 61.2;
      y = 75.456;

    z = x +y;

<<"%V $z = $x +$y\n"


      short m = 14567;
      ulong l = 123456789;

<<"$(typeof(m))  $(typeof(l))\n"

      n = m + l;

<<"$(typeof(n))  $(typeof(m))  $(typeof(l))\n"

<<"%V $n = $m +$l\n"

<<"Nes $(getNes())\n"
<<"Ndbs $(getNdbs())\n"
<<"Nfastx $(getNfastx())\n"

