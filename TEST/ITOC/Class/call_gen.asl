//%*********************************************** 
//*  @script call_gen.asl 
//* 
//*  @comment test generic args 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr 16 11:32:54 2020 
//*  @cdate Thu Apr 16 11:32:54 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");

setdebug(1,@pline,@~trace)

////


proc goo (str a, str b)
{
<<"$_proc  str vers  $a  $b\n";

 str a1 = a;
 str b1 = b;

<<"%V $a1 $b1 \n"

   return;
}

<<"goo str defined\n"
 str sA = "77"

 str sB = "61"

<<"%V $sA $sB \n"

  goo(sA,sB);

proc goo (str a)
{
<<"$_proc  str 1 vers  $a  \n";

 str a1 = a;


<<"%V $a1  \n"

   return;
}

<<"goo str 1 defined\n"

  goo(sA);


proc goo (gen a, gen b)
{
<<"$_proc  gen vers $a  $b\n";

 str a1 = a;
 str b1 = b;

<<"%V $a1 $b1 \n"

   return;
}

<<"goo gen defined\n"


  goo(sA,sB);


 int k = 4
 int m = 7;

<<"%V $k $m \n"

  goo(k,m);



exit()
