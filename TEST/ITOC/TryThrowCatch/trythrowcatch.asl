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



int test_try_throw_catch(int val)
{
  int cball = -1;

  <<"in $_proc $val  $(pt(val))  $cball\n";
    just_one_try = 0;
   
    try
    {
       <<"try $val\n";

        throw 0; // TBF

        if (val == 47)
	{
           throw 47;
        }

       if (val == 77)
       {
           throw 77;
       }
      
        if (val == 79)
	{
           throw 79;
        }
	<<"try no throw of $val $cball\n";
	just_one_try++;
      <<" continue in try block $just_one_try\n"
      
        throw 0; // TBF
	
    } // try block end
    
//
// nothing allowed here
//
//    val = 47;   // correct causes syntax error
    catch ( int ball)
    {

       cball = ball;
<<"caught $(pt(ball))  $cball\n";       
<<" do something here - log error?\n"
//ans=query("next\n")
    }

<<"out of try $_proc return val $cball\n"


    return cball;
}

//===========================//

int just_one_try = 0;
  val = 47;
chkIn(_dblevel)
rball=test_try_throw_catch(val)

<<" after first try in proc $rball\n"

rball=test_try_throw_catch(76)

<<" after first try in proc $rball\n"
//ans=query("next\n")


rball=test_try_throw_catch(79)

<<" after second try in proc $rball\n"
//ans=query("next\n")


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
exit()
