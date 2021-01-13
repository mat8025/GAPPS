/* 
 *  @script icall.asl 
 * 
 *  @comment test indirect proc call   
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.8 C-Li-O]                                  
 *  @date Mon Jan 11 09:33:34 2021 
 *  @cdate 1/1/2003 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
///
/// icall --- use variable string value to call proc
///


// bug -- XIC - if proc not found the XIC CALLIP is not inserted
// needs to be be inserted regardless is proc is found/valid

// what about call func -- indirect ??

#include "debug.asl"



debugON();

ask= _clarg[1];

chkIn(_dblevel)

N = 0;


proc Noo()
{

<<"in $_proc \n"

   N = 1;


}


proc Goo()
{

<<"in $_proc \n"

   N = 2;
}


proc Zoo()
{

<<"in $_proc \n"

   N = 3;
}



   Noo();

<<"%V $N\n"


   Goo();

<<"%V $N\n"


 pname = "Noo";

<<"calling $pname\n"
 $pname();

<<"%V $N\n"


 pname = "Goo";

<<"calling $pname\n"

 $pname();

<<"%V $N\n"


 pname = "Zoo";
<<"calling $pname\n"
 $pname();

<<"%V $N\n"
chkN(N,3)
chkOut()
if (!(ask @=""))
{
 while (1) {

 pname = i_read("which proc? or quit:")
 <<"calling $pname\n"
 if (pname @= "quit") {
     break;
 }
 else {
  $pname();
  //<<"$pname sets %V $N\n"
 }
 
 }
}




exit()

