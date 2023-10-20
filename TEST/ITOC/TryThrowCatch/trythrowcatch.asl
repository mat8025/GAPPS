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



if (_dblevel >0) {
   debugON()
}

 allowErrors(-1) ; // keep going

 chkIn(_dblevel); 

int tval = 7;

na = argc();



  wn= NULL_ ;

<<"wn <|$wn|> \n"



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

  askit(0)

no_throws =0;
caught = 0;

 //tval.pinfo()






//////////////////////////////////////////////////



int test_try_throw_catch(int val)
{

  int cball = -1;

  <<"in $_proc $val  $(pt(val))  $cball\n";
    just_one_try = 0;
    no_throws =0;
    
    try     {
      

   

        if (val == 47)  {
	
           throw 47;
        }

       if (val == 77) {
       
       <<"should be throwing $val\n"
           throw 77;
       }
      
        if (val == 79)
	{
       <<"should be throwing 79 $val\n"	
           throw 79;
        }
	
	if (val == 80)
	{
       <<"should be throwing 80 $val\n"	
           throw 80;
        }
	

	<<"try no throw of $val $cball\n";

        just_one_try++;
	
      <<" continue in try block $just_one_try\n"
      
   //     throw 0; // TBF
	no_throws = 1;
	
    } // try block end
//
// nothing allowed here
//
//    val = 47;   // TBF  does not  cause a  syntax error

   catch ( int ball)
    {

       cball = ball;
<<"caught $ball   $cball\n";       

//ans=query("next\n")
    }
    
  <<"Out $_proc $no_throws $val  $(pt(val))  $cball\n";

    return cball;
}

//===========================//

int just_one_try = 0;

val = 47;


rball=test_try_throw_catch(tval)

<<" after first try - throw in proc $rball\n"

!a

chkN(rball,tval);


rball=test_try_throw_catch(76)

<<" after second try in proc $rball\n"
//ans=query("next\n")

chkN(rball,-1);



rball=test_try_throw_catch(79)


//ans=query("next\n")
<<" after third try in proc $rball\n"
chkN(rball,79);

rball=test_try_throw_catch(77)
<<" proc returns $rball\n"
<<" after fourth try in proc $rball\n"
chkN(rball,77)


rball= test_try_throw_catch(47)
<<" proc returns $rball\n"
<<" after fifth try in proc $rball\n"
chkN(rball,47)


rball= test_try_throw_catch(50)
<<" proc returns $rball\n"
chkN(rball,-1)



chkOut()

exit()
