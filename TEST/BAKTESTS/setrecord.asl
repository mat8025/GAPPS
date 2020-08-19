setdebug(1,"pline")


 

record R[10+];

sw = statusOf(R)

<<"\n status $sw \n"
<<"X %x $sw[2] \n"
b=dec2bin(sw[2])
<<"$b   $(dec2bin(sw[2]))\n"
<<" $(infoOf(R))) \n"
iread();
R[0][0] = "deb0";

 R[0][1] = "seguir";


 R[1][0] = "never";
  R[1][1] = "give";
   R[1][2] = "up";

<<"sz $(Caz(R))\n"

<<"%(1,=>, || ,<=\n)$R[::]\n"


sw = statusOf(R)
<<"\n status $sw \n"
<<"X %x $sw[2] \n"
b=dec2bin(sw[2])
<<"$(dec2bin(sw[2]))\n"



 R[15][0] = "never";
  R[15][1] = "give";
   R[15][2] = "up";
      R[15][3] = "ever";

<<" $(Caz(R))\n"
<<"%(1,>>, || ,<<\n)$R[::]\n"

<<" $(infoOf(R))) \n"

R=ReadRecord("record.txt",@del,',',@comment,"",@pickstr,"@!=",0,"must")
<<"$(dec2bin(sw[2]))\n"
<<"$(typeof(R)) $(cab(R))\n"
sw = statusOf(R)
<<"\n status $sw \n"
<<"bin %x $sw[2] \n"

<<"$(dec2bin(sw[2]))\n"
<<"after ReadRecord $(infoOf(R))) \n"
iread()


<<"$R[0]\n"
<<"$R[1]\n"
<<"$R[2]\n"


<<"================\n"
<<"$R[0:4]\n"



bd = Cab(R)
<<"sz $(Caz(R)) bounds %V$bd\n"
<<"================\n"
 R[15][0] = "never";
  R[15][1] = "give";
   R[15][2] = "up";
      R[15][3] = "ever";


 R[1][0] = "never";


<<" $(Caz(R))\n"
<<"%(1,>>, || ,<<\n)$R[::]\n"


sw = statusOf(R)
<<"\n status $sw \n"
<<"X %x $sw[2] \n"
<<"$(dec2bin(sw[2]))\n"
<<" $(infoOf(R))) \n"


 T = R

sw = statusOf(T)
<<"\n status $sw \n"
<<"X %x $sw[2] \n"
<<"$(dec2bin(sw[2]))\n"
<<" $(infoOf(T))) \n"


<<"%(1,>>, || ,<<\n)$T[::]\n"


 W= R[0:3];

sw = statusOf(W)
<<"\n status $sw \n"
<<"X %x $sw[2] \n"
<<"$(dec2bin(sw[2]))\n"
<<" $(infoOf(W))) \n"
 