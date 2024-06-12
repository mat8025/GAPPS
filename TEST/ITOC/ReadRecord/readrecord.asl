/* 
 *  @script readrecord.asl 
 * 
 *  @comment test readrecord SF 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.66 C-Li-Dy] 
 *  @date 12/12/2021 11:52:54          
 *  @cdate 1/1/2012 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 */ 
;//-----------------<v_&_v>--------------------------//;                                                               



<|Use=
 read a file into record
|>




#include "debug"



  if (_dblevel >0) {

  debugON();

  <<"$Use_\n";

  }


allowErrors(-1) ; // keep going

filterFileDebug(REJECT_,"array_","exp","store","tok","args")

chkIn()


/*
 read an record (all ascii fileds) to a RECORD variable

R=ReadRecord("record.txt",@del,',',@comment,"")

R=ReadRecord("record.txt",@del,',',@comment,"#",@pickstr,"@=",0,"must")

R=ReadRecord("record_sp.txt")
*/

R=ReadRecord("record_sp.txt",@del,32)


<<"%V $(typeof(R)) $(cab(R))\n"

nb = Cab(R);


<<"%V$nb $(typeof(nb))\n"

<<"%V$R[0][0] \n"
chkStr(R[0][0],"1")



   ws=R[0][1]

<<"%V$R[0][1] $ws\n"


chkStr(ws,"2")

<<"<|$R[0][2]|>\n"

<<"$R[1]\n"

<<"%V$R[0][2]\n"

chkStr(R[0][2],"3")


 for (i= 0; i < 3; i++) {
<<"%V$R[2][i] \n"
 }


<<"================\n"


<<"$R[::]\n"


R=ReadRecord("record.csv",@del,',');

nb = Cab(R);


<<"%V$nb $(typeof(nb))\n"
<<"%V$R[0][0] \n"
chkStr(R[0][0],"47")
<<"%V$R[0][0] \n"

//<<"%V$R[0][1] \n"
chkStr(R[0][1],"79")
chkStr(R[0][2],"80")
<<"%V$R[0][1]\n"

<<"<|$R[0][2]|>\n"

<<"$R[1]\n"
chkStr(R[1][2],"6")




 for (i= 0; i < 3; i++) {
<<"%V$R[2][i] \n"
 }


<<"================\n"


<<"$R[::]\n"


chkOut()
exit();


bd = Cab(R)
<<"sz $(Caz(R)) bounds %V$bd\n"
<<"================\n"
<<"%(1,=>, || ,<=\n)$R[::]\n"


I = igen(20,0,1)

<<"$I\n"

int vec[]= {2,-1,3};

S = sgen(INT_,20,vec,10)

//pre = "==>"
pre = 4;

<<"%(2,==>, || ,<=\n)$S\n"