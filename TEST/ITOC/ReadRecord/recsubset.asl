setdebug(1,"pline")

A=igen(12,0,1)
 <<"%(3,=>, || ,<=\n)$A[::]\n"

 B= A[1:3]

 <<"$B\n"




record R[10+];

sw = statusOf(R)


 R[0][0] = "deb0";
 R[0][1] = "seguir";

 R[1][0] = "never";
 R[1][1] = "give";
 R[1][2] = "up";


 R[2][0] = "must";
 R[2][1] = "keep";
 R[2][2] = "going";

 R[3][0] = "not";
 R[3][1] = "much";
 R[3][2] = "time";
 R[3][3] = "left";


<<"%(1,=>, || ,<=\n)$R[::]\n"
<<"////////////\n"

iread()

<<"%(1,=>, || ,<=\n)$R[1:2:]\n"


  W = R;

<<"after  $(infoOf(W))) \n"


<<"%(1,=>, || ,<=\n)$W[::]\n"


  T = R[0:1];

<<"after  $(infoOf(T))) \n"


<<"%(1,=>, || ,<=\n)$T[::]\n"

  frw= T[0][0]
  srw= T[1][0]

<<"%V$frw  $srw\n"

<<"$T[::]\n"

<<"%(1,=>, || ,<=\n)$T[::]\n"