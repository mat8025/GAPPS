//%*********************************************** 
//*  @script class2.asl 
//* 
//*  @comment test class member set/access 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sun Mar  3 12:41:16 2019 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  


chkIn(_dblevel)

/// simple class test

class Rec {

public:
    svar srec;
}
//===========================//

Rec FI[10];

 svar loc;

loc = Split("how did we get here")

<<"$loc[1]\n"

<<"$loc[::]\n"


 FI[0]->srec = Split("how did we get here")

<<"$FI[0]->srec[::] \n"


 r00 = FI[0]->srec[0];

 r01 = FI[0]->srec[1];

 r02 = FI[0]->srec[2];

<<"$(typeof(r00)) \n"

<<"%V $r00 $r01 $r02\n"

 FI[1]->srec = Split("just evolved with many trials")


 r00 = FI[0]->srec[0];

 r01 = FI[0]->srec[1];

 r02 = FI[0]->srec[2];

<<"$(typeof(r00)) \n"

<<"%V $r00 $r01 $r02\n"

 r10 = FI[1]->srec[0];

 r11 = FI[1]->srec[1];

 r12 = FI[1]->srec[2];


<<"%V $r10 $r11 $r12\n"
 chkStr(r00,"how");
 
 chkStr(r02,"we");

 r10 = FI[1]->srec[0];

 r11 = FI[1]->srec[1];

 r12 = FI[1]->srec[2];


<<"%V $FI[1]->srec[2]\n"

<<"%V $r10 $r11 $r12\n"

chkStr(r10,"just");

chkStr(r11,"evolved");

chkStr(r12,"with");



////////////////////////
int Obid = 0;

class Add
 {
  public:

   float x ;
   float y;
   int id;
   
 cmf Add()
  {
    id = Obid++;
    <<"CONS $_cobj %V $id\n"
    x = 0;
    y = 0;

  }


  cmf sum (real a,real b)
  {
   t = a +b;
   return t;
  }

  cmf sum (int a,int b)
  {
   t = a +b;
   return t;
  }

  cmf diff (int a,int b)
  {
//  int t;
   t = a -b;
   return t;
  }

  cmf say()
  {
   <<"$_proc hey there I exist\n"
   isay="hey hey"
   return ("hey hey");
   //return isay;
  }

  cmf isay()
  {
   <<"$_proc hey there I exist\n"
   isay="Do what I say"
   return isay;
  }
  
}

//int s;

Add  tc;   //FIX

    s= tc->sum(4,5);

chkN(s,9)
<<"%V $s $(typeof(s)) \n"



    r= tc->sum(4.2,5.6);

<<"%V $r $(typeof(r)) \n"

chkN(r,9.8)




Add  mc;


    s= mc->sum(4,5);

<<"%V $s \n"


Add  nc[2];


    s= nc[0]->sum(4,5);

<<"%V $s $(typeof(s))\n"


    s= nc[1]->sum(47,79);

<<"%V $s \n"

chkN(s,126)



    s= nc[0]->diff(47,79);

chkN(s,-32);

<<"%V $s $(typeof(s))\n"




   s= mc->diff(47,79);

<<"%V $s $(typeof(s))\n"

chkN(s,-32);


    what = mc->say();
<<"%V$what $(typeof(what))\n"
chkStr(what,"hey hey");

    what=nc[0]->say()
<<"%V$what $(typeof(what))\n"
chkStr(what,"hey hey");

    what = mc->isay();
<<"%V$what $(typeof(what))\n"
chkStr(what,"Do what I say");




chkOut()

