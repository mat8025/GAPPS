/* 
 *  @script proc-ret.asl 
 * 
 *  @comment test return type vs proc args 
 *  @release CARBON 
 *  @vers 1.6 C Carbon [asl 6.3.3 C-Li-Li] 
 *  @date Thu Dec 31 13:34:29 2020 
 *  @cdate Sat May 9 10:35:36 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
 
                                                                        
myScript = getScript();


chkIn(_dblevel)

Str say()
  {
   <<"$_proc hey there I exist\n"
   isay="hey hey"
   <<"$isay $(typeof(isay))\n"
   return isay;
  }

ws = say()


<<"$ws $(typeof(ws))\n"

chkStr(ws,"hey hey");


real Foo(real x,real  y)
{

   z = x * y

   return z
}


int Foo(int x,int  y)
{

   z = x * y

   return z
}

Str vers2ele(str vstr)
  {
  //<<"%V $vstr\n"
   pmaj = atoi(spat(vstr,".",-1))
   <<[2]"$pmaj $(typeof(pmaj)) $(ptsym(pmaj)) \n"  
   pmin = atoi(spat(vstr,".",1))

//<<[2]"$pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   elestr = pt(pmin);
   str ele =" ";
   ele = spat(elestr,",")
  <<"$ele $(typeof(ele))\n";
  <<"$ele\n";
   return ele;
  }
  


  a = Foo(2,3)
 chkR(a,6)
a->info(1)

  b = Foo(4.0,3.0)
 chkR(b,12)
b->info(1)

<<"%v $b \n"


int a1 = 2;
int a2 = 4;

  c = Foo(a1,a2)
 chkR(c,8)
c->info(1)

<<"%v $b \n"



   j = 1
   n = 12
   while (j < 4) {

      a = Foo(j,n)


<<" $j * $n  = $a\n"
    j++
   }

int pmaj;
int pmin;

cvers ="1.54"

nele = vers2ele(cvers);


<<"%I $nele\n"

nele->info(1)
chkStr(nele,"Xeon")


//%*********************************************** 
//*  @script procret0.asl 
//* 
//*  @comment test procedure return 
//*  @release CARBON 
//*  @vers 1.23 V Vanadium                                                
//*  @date Sun Jan 27 21:50:27 2019 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



int foo1(real a) 
{
 ret = 0;
<<" $_proc foo $a \n"

  if (a > 1) {
<<" $a > 1 should be returning 1 !\n"
    ret =  1    // FIX?? needs a ; statement terminator
  }

  else if (a < 0) {
<<" $a < 0 should be returning -1 !\n"

    ret =  -1;

  }
  else {
<<" $a <= 1 should be returning 0 !\n"
  }
  return ret;

}

////////////////////////////////////////
int foo1(int a) 
{
 ret = 0;
<<" $_proc foo $a \n"

  if (a > 1) {
<<" $a > 1 should be returning 1 !\n"
    ret =  1;    // FIX?? needs a ; statement terminator
  }

  else if (a < 0) {
<<" $a < 0 should be returning -1 !\n"

    ret =  -1;

  }
  else {
<<" $a <= 1 should be returning 0 !\n"
  }
  return ret;

}




int foo2(int a) 
{
int ret = 0;
<<" $_proc foo2 $a \n"

    if (a > 300) {
<<" $a > 300 foo2 should be returning 30 !\n"
    ret =30
    }

    else if (a > 200) {
<<" $a > 200 foo2 vshould be returning 20 !\n"
    ret = 20
    }

    else if (a > 100) {
<<" $a > 100 foo2 should be returning 10 !\n"
    ret = 10
    }

//////////////////////////////////////////////

  else if (a > 1) {
<<" $a > 1 should be returning 1 !\n"
    ret=  1;
  }

  else if (a < 0) {
<<" $a > 1 should be returning 1 !\n"
    ret=  -1;
  }
  else {
<<" $a <= 1 should be returning 0 !\n"
  }

   return ret;
}
//////////////////////////////////

int foo3(real a) 
{
int ret = 0;
<<" $_proc foo3 $a \n"
  a->info(1)
    if (a > 300) {
<<" $a > 300 foo3 should be returning 30 !\n"
    ret = 30;
    }

    else if (a > 200) {
<<" $a > 200 foo3 vshould be returning 20 !\n"
    ret = 20
    }

    else  if (a > 100) {
<<" $a > 100 foo3 should be returning 10 !\n"
    ret = 10;
    }

    return ret;
}
//========================
void goo(ptr a)
//proc goo(int a)
{
<<"$_proc $a\n"
  a->info(1)
  $a += 1;
  a->info(1)
// does,nt really return anything
// return on own crash TBF crash
   return;
}
//==================================//

void hoo(real a)
{
<<"$_proc $a\n"
  a->info(1)
  a += 1;

// does'nt really return anything
     return;  // TBD crash
 //   return ; // OK
}
//==================================//

int moo(double a)
{
<<"$_proc $a\n"
  a += 1;
<<"%V $a\n"


 a->info(1)
 
 if (a >1) a += 1;

// if (a >10)  return; // TBF needs {}

  int mb = a;
  mb += 2;
  
<<"%V $a\n"

  mb->info(1);
  
  return mb;  // TBD crash
}
//==================================//


int roo(ptr a)
{
<<"$_proc $($a)\n"
  $a += 1;
<<"%V $a\n"


 a->info(1)
 
 if ($a >1) $a += 1;

// if (a >10)  return; // TBF needs {}

  int mb = $a;

<<"%V $mb \n"
  mb += 2;
  
<<"%V $a\n"

  mb->info(1);
  
  return mb;  // TBD crash
}
//==================================//

   in = 2

   c = foo1(in)

<<" $in $c \n"

   chkN(c,1)


   c = foo1(in) * 2

   <<" $in $c \n"

   chkN(c,2)


in = 1

   c = foo1(in)

<<" $in $c \n"

   chkN(c,0)

 in = 3

 c = foo1(in)

<<" $in out $c \n"

   chkN(c,1)

 c = foo1(in) * 6

<<" $in $c \n"

   chkN(c,6)

  in = -4

 c = foo1(in) * 6

<<" $in $c \n"

   chkN(c,-6)

   fin = 110.0

   d = foo3(fin) 

<<"ret will be  $d\n"


   in = 210

   d = foo2(in) 

<<"ret will be  $d\n"
!iin
real rin = in
!irin
   e = foo3(rin) 

<<"ret will be  $e\n"


   e = foo3(in) 

<<"ret will be  $e\n"


   //c = foo2(in) * 6
   c = 6 * foo2(in) 

  <<" $in $c \n"

   chkN(c,120)


  in = 310

   d = foo2(in) 

<<"ret will be $d\n"

   e = foo3(fin) 

<<"ret will be  $e\n"


   c = foo2(in) * 7

<<"%V $in $c \n"
    
  chkN(c,210)


  for (j = 0 ; j < 3; j++) {

      in = 3

      c = foo1(in) * (j + 1)

      <<" $in  returned * 3  $c \n"

      chkN(c,(j+1))

  }

   x =1;
   xp = &x;
   goo(xp)

<<"goo $x\n"

   chkN(x,2);

   hoo(x)

   chkN(x,2);


   double xm=14.0

   mr= moo(xm)
   
<<"%V $xm $mr\n"

   chkN(mr,18);

   int ixm = 14;
   
 //  mr= roo(&ixm)

//<<"%V $ixm $mr\n"




chkOut();




