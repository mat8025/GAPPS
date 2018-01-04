///
/// 
///

setdebug(1)



// read an record (all ascii fileds) to a RECORD variable



//R=ReadRecord("record.txt",@del,',',@comment,"")

//R=ReadRecord("record.txt",@del,',',@comment,"#",@pickstr,"@=",0,"must")

//R=ReadRecord("record_sp.txt")

R=ReadRecord("record_sp.txt",@del,32)


<<"%V $(typeof(R)) $(cab(R))\n"

nb = Cab(R);


<<"%V$nb $(typeof(nb))\n"

<<"%V$R[0][0] \n"

<<"%V$R[0][1]\n"

<<"%V$R[0][2]\n"

<<"$R[1]\n"

 for (i= 0; i < 3; i++) {
<<"%V$R[2][i] \n"
 }


<<"================\n"


<<"$R[::]\n"


R=ReadRecord("record.csv",@del,',');

nb = Cab(R);


<<"%V$nb $(typeof(nb))\n"

<<"%V$R[0][0] \n"

<<"%V$R[0][1]\n"

<<"%V$R[0][2]\n"

<<"$R[1]\n"

 for (i= 0; i < 3; i++) {
<<"%V$R[2][i] \n"
 }


<<"================\n"


<<"$R[::]\n"



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