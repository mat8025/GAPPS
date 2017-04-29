setdebug(1)



// read an record (all ascii fileds) to a RECORD variable



//R=ReadRecord("record.txt",@del,',',@comment,"")
R=ReadRecord("record.txt",@del,',',@comment,"",@pickstr,"@=",0,"must")


<<"$(typeof(R)) $(cab(R))\n"


<<"$R[0]\n"
<<"$R[1]\n"
<<"$R[2]\n"


<<"================\n"
<<"$R[0:4]\n"



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