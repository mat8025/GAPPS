//%*********************************************** 
//*  @script trythrowcatch.asl 
//* 
//*  @comment test try-throw-catch 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.79 C-He-Au]                               
//*  @date Thu Oct 29 09:23:32 2020 
//*  @cdate Thu Oct 29 09:23:32 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///
///
///

#include "debug"

<|Use_=
  demo trythrowcatch
|>




if (_dblevel >0) {
   debugON()
   <<"$Use_\n"    
}

allowErrors(-1) ; // keep going

 chkIn(_dblevel); 

int tval = 7;

na = argc();



  wn= NULL_ ;

<<"wn <|$wn|> \n"

!i wn

if (_clarg[1] == NULL_) {
 <<" null  arg1\n"
}


if (_clarg[1] != NULL_) {
 tval = atoi(_clarg[1]);
 <<"not null  $tval\n"
}


if (_clarg[1] != "") {




   tval = atoi(_clarg[1]);
}

<<"%V $tval $na $_clarg[0] $_clarg[1]  \n"
no_throws =0;
caught = 0;
 try {

  <<" estoy intentando  \n"
  <<"in try %V $tval\n"
  
  if (tval == 7) {
<<" preparing to throw $tval\n"
     throw 7;
  }

  if (tval == 14) {
  <<" preparing to throw $tval\n"
     throw 14;
   }

  if (tval > 30) {
  <<" preparing to throw $tval\n"
     throw tval;
   }

    no_throws = 1;
      
<<" %V $no_throws in try block \n"
  
 }

 catch(int ball)
  {

<<" caught $ball\n"

    chkN(ball,tval);
    no_throws = 0;
    caught = 1;
  }



 if (caught) {
   chkN(no_throws,0)
   
 }
 else {
<<" %V there were no throws$no_throws  \n"
  chkN(no_throws,1)
 }







//////////////////////////////////////////////////



int test_try_throw_catch(int val)
{

  int cball = -1;

  <<"in $_proc $val  $(pt(val))  $cball\n";
    just_one_try = 0;
   
    try
    {
       <<"in proc try $val\n";
!a
   

        if (val == 47)
	{
           throw 47;
        }

       if (val == 77)
       {
       <<"should be throwing $val\n"
           throw 77;
       }
      
        if (val == 79)
	{
       <<"should be throwing $val\n"	
           throw 79;
        }
	
	<<"try no throw of $val $cball\n";

        just_one_try++;
      <<" continue in try block $just_one_try\n"
      
   //     throw 0; // TBF
	
    } // try block end
    
//
// nothing allowed here
//
//    val = 47;   // correct causes syntax error
    catch ( int ball)
    {

       cball = ball;
<<"caught $(pt(ball))  $cball\n";       

//ans=query("next\n")
    }



  <<"Out $_proc $val  $(pt(val))  $cball\n";

    return cball;
}

//===========================//

int just_one_try = 0;

val = 47;


rball=test_try_throw_catch(val)

<<" after first try in proc $rball\n"
chkN(rball,val);


rball=test_try_throw_catch(76)

<<" after first try in proc $rball\n"
//ans=query("next\n")

chkN(rball,-1);

rball=test_try_throw_catch(79)

<<" after second try in proc $rball\n"
//ans=query("next\n")

chkN(rball,79);

rball=test_try_throw_catch(77)


chkN(rball,77)
<<" after third try in proc $rball\n"

rball= test_try_throw_catch(47)

chkN(rball,47)
<<" after forth try in proc $rball\n"

rball= test_try_throw_catch(50)
<<" tin returns $rball\n"
chkN(rball,-1)

<<" after fifth try in proc $rball\n"

chkOut()

