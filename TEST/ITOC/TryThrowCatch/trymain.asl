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
myScript = getScript();
///
///
///
#include "debug"

debugON()
sdb(1,@pline)


//////////////////////////////////////////////////////
//val = 79;
val=  47;

 val= atoi(_clarg[1])
 <<"$val \n"
int just_one_try = 0;

 i= 0
 k = 0;
 N = 3


while (1) {

  try
    {
     <<"try $val  $(pt(val))\n";
      
    if (val == 67)
       {
        <<"in try test 67\n";
           throw 67;
       }


      if (val == 70)
	{
	<<"trying to throw $val to catch\n"
           throw val;
        }

      if (val == 75)
	{
	<<"trying to throw 75 $val to catch\n"
           throw val;
        }


      if ((val >= 77 && (val <=79)) 
        {
	<<"trying to throw $val to catch\n"
           throw val;
        }
	  


        if ((val >= 80) && (val <=83))
	{
//	ans=query("trying to throw 80 to catch\n");
	<<"trying to throw $val to catch\n";
	  
           throw val;
        }
	       
<<"try no throw of $val \n";


	just_one_try++;
      <<" continue in try block $just_one_try\n"
    } // try block end
    
//
// nothing allowed here
//
//    val = 47;   // correct causes syntax error
    catch ( int ball)
    {
<<"%V $val \n";
      int cball = -1;
       cball = ball;
<<"caught $(pt(ball))  $cball\n";       
<<" do something here - log error?\n"
    }


ans=query("after main try-catch block $val\n")
val++
  if (val > 85) {
    break;
  }
  
}

<<"break out of while @ $val\n"

exit()