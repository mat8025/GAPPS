///
///
///

setdebug(1,@keep);
filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");

proc howlong (r,c, val)
{

  R[r][c] = val;
  rval = R[r][c];
<<"$val $r $c $rval $R[r][c]\n"

}


chkIn()


  Record R[10];

  R[0] = Split("0,1,2,3,4,5,6,7,8,9",",");


sz = Caz(R)

cols = Caz(R,0)

<<"%V $sz $cols \n"
 for (i= 1; i< 10;i++) {
  R[i] = R[0];
 }

  sr02 = R[0][2]

<<"%V $sr02\n"


  R[1][3] = "47"



<<"$R[::][::]\n"

 wr=3
 wc=4

  R[wr][wc] = "79"



chkStr(R[wr][wc],"79")
chkStr(R[1][3],"47")

str lmans = "80"

 wr=4
 R[wr][wc] = lmans;
 
chkStr(R[wr][wc],lmans)

chkStr(R[wr][wc],"80")

sr00 = R[0][0];

R[0][0] = "67"

<<"$R[::][::]\n"

//<<"%(1,, ,\n)$R\n"


  howlong(4,5,"4.5")

  howlong(5,4,"5.4")


  howlong(wr,wc,"5.4")

  wr++; wc++;
  howlong(wr,wc,"5.4")
wr++; wc++;
 howlong(wr,wc,"5.4")




chkOut();