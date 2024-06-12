/* 
 *  @script list_ele.asl 
 * 
 *  @comment test list ele access 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.63 C-Li-Eu] 
 *  @date 11/27/2021 23:51:45          
 *  @cdate 1/1/2008 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn();
   
//FIXME --- have to have a declare statement afore LIST DECLARE ??

   m = 2;

   ws = getScript();

   <<" $ws \n";

   L = ( "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" );

   <<"$L\n";

   m = Caz(L);

   <<"list size is $m \n";
 //chkN(m,11)

   <<" should be unreversed !\n";

   <<"L= $L\n";

   str le = "astring";

   <<" $(typeof(le)) $le\n";

   le = L[1];

   <<"%V$le \n";

   <<"le type is $(typeof(le)) \n";

   li = L[2];

   <<"%V$li $(typeof(li))\n";
// FIX li shouldn be string !\n";

   <<"li type is $(typeof(li)) \n";

   m = Caz(li);

   <<"list size is $m \n";

   <<"\n";

   lib = L[2:6];

   m = Caz(lib);

   <<"list size is $m \n";

   <<"%V contains $lib \n";

   <<"lib type is $(typeof(lib)) \n";

   <<" $L[1] $L[10] \n";

   <<"%V$le %V$L[1]\n";

   aw="what";

   tt=chkStr(aw,"what");

   <<"%V$tt\n";

   aw=L[1];

   <<" $(typeof(aw)) $aw \n";

   tt=chkStr(le,"what");

   <<"%V$tt\n";

   L.reverse();

   <<"Reversed: $L \n";

   <<" $L[1] $L[10] \n";

   le = L[1];

   <<"%V$le \n";

   L.sort();

   <<"sort list \n";

   <<" $L \n";

   le = L[1];

   <<"%V$le \n";

   chkOut();

//===***===//
