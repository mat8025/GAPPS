//%*********************************************** 
//*  @script try.asl 
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

Str Use_= " [num]   numbers 7,14,>=30 are caught - any other number is not"

   if (_dblevel >0) {

        debugON();
        <<" $Use_ \n"
   }

   allowErrors(-1) ; // keep going;

   chkIn();

   int tval = 7;

 

   na = argc();

   wn= NULL_ ;

   <<"wn <|$wn|> \n";

   if (_clarg[1] == NULL_) {

        <<" null  arg1\n";

   }

   if (_clarg[1] != NULL_) {

        tval = atoi(_clarg[1]);

        <<"not null  $tval\n";

   }

   if (_clarg[1] != "") {

        tval = atoi(_clarg[1]);

   }

   <<"%V $tval $na $_clarg[0] $_clarg[1]  \n";



   no_throws =0;

   caught = 0;

   tval.pinfo();

   try {

        <<" estoy intentando  \n";

        <<"in try %V $tval\n";

        if (tval == 7) {

             <<" preparing to throw $tval\n";

             throw 7;

        }

        if (tval == 14) {

             <<" preparing to throw $tval\n";

             throw 14;

        }

        if (tval > 30) {

             <<" $tval > 30 preparing to throw $tval\n";

             tval.pinfo();

             throw tval;

        }

        no_throws = 1;

        <<" %V $no_throws in try block \n";

   }

   catch(int ball) {

        ball.pinfo();

        <<" caught $ball\n";

        chkN(ball,tval);

        no_throws = 0;

        caught = 1;

   }

   if (caught) {

        chkN(no_throws,0);

   }

   else {

        <<" %V there were no throws $no_throws $tval was not caught \n";

        chkN(no_throws,1);

   }

   if (tval == 7 && caught)

   chkT(1);

   chkOut();
/////////////////////////////////////

//==============\_(^-^)_/==================//
