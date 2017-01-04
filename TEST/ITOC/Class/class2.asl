
setdebug(1);

checkIn()
// simple class test



class Rec {

 public:
    svar srec;

}


Rec FI[10];


 FI[0]->srec = Split("how did we get here")

 FI[1]->srec = Split("just evolved with many trials")



 r00 = FI[0]->srec[0];

 r01 = FI[0]->srec[1];

 r02 = FI[0]->srec[2];

//<<"$(typeof(r00)) \n"

<<"%V $r00 $r01 $r02\n"

 checkStr(r00,"how");
 
 checkStr(r02,"we");

 r10 = FI[1]->srec[0];

 r11 = FI[1]->srec[1];

 r12 = FI[1]->srec[2];


<<"%V $r10 $r11 $r12\n"

checkStr(r12,"with");

////////////////////////

Class Add
 {
  public:

   float x ;
   float y;

 CMF Add()
  {
    x = 0;
    y = 0;
  }


  CMF sum (a,b)
  {
   t = a +b;
   return t;
  }

  CMF diff (a,b)
  {
//  int t;
   t = a -b;
   return t;
  }

  CMF say()
  {
<<"$_proc hey there I exist\n"
   return "hey hey";
  }
}


//int s;


Add  tc;   //FIX

    s= tc->sum(4,5);

checkNum(s,9)
<<"%V $s $(typeof(s)) \n"

    r= tc->sum(4.2,5.6);

<<"%V $r $(typeof(r)) \n"

checkNum(r,9.8)

Add  mc;


    s= mc->sum(4,5);

<<"%V $s \n"


Add  nc[2];


    s= nc[0]->sum(4,5);

<<"%V $s \n"


    s= nc[1]->sum(47,79);

<<"%V $s \n"

checkNum(s,126)

    s= nc[0]->diff(47,79);

checkNum(s,-32);

<<"%V $s \n"

   s= mc->diff(47,79);

<<"%V $s \n"

checkNum(s,-32);

    what = mc->say();

checkStr(what,"hey hey");

    what=nc[0]->say()

checkStr(what,"hey hey");

checkOut()

