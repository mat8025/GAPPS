//%*********************************************** 
//*  @script rr.asl 
//* 
//*  @comment test readrecord  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Mon Feb 17 08:14:36 2020 
//*  @cdate Mon Feb 17 08:14:36 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

include "debug"
debugON()
setdebug(1,@pline,@~trace,@keep)

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");

setDebug(1,@pline)

M2D = vgen(INT_,20,0,1)

M2D->redimn(5,4)

<<"$M2D\n"
 CV= M2D[::][1]
 <<"%V$(Caz(CV)) $(Cab(CV))\n"
<<"$CV\n"

CV= M2D[::][2]
 
<<"$CV\n"

CM= M2D[::][2:3]

<<"%V$(Caz(CM)) $(Cab(CM))\n"

<<"$CM\n"


CM= M2D[1:3:][2:3]

<<"%V$(Caz(CM)) $(Cab(CM))\n"
<<"$CM\n"

M2D->info(1)

//============================

checkin()

fname = "bpp.tsv"


    A=ofr(fname)
    R= readRecord(A)
    R->info(1)
    cf(A);

    sz = Caz(R);
    rows = sz;
    Rn = rows;  //global count of rows
<<"$R\n"

      R[0][4] = "JULDAY"
   

      R->info(1)

      cols = Caz(R,0);
      nd=Cab(R)

<<"%V $R[0][4]\n"


   day= R[1][3]

<<"%V$day \n"

   i = 2
   day= R[i][3]

<<"$i $day \n"

    R->info(1)

   i++
   day= R[i][3]

<<"$i $day \n"




for (i= 1; i <sz; i++) {
   day= R[i][3]
<<"<$i> $day \n"
   R[i][4] = day
}
<<"%V$rows $cols $nd  $(typeof(R)) $(Caz(R))\n"

<<"$R\n"
  R->info(1)

  R[9:10][2] = "55"

     <<"$R\n"
  R->info(1)


      WV=  R[1:5:][2]  // one col of subset record

cb = Cab(WV)
<<"%V$(typeof(WV)) $(Caz(WV)) $(Cab(WV))\n"

<<"%V$WV \n"

WV->info(1)

<<"%V$cb \n"

checkNum(cb[0],5)
checkNum(cb[1],1)





      WV=  R[1:5:][1:2]  // one two cols of entire record

<<"%V$(typeof(WV)) $(Caz(WV)) $(Cab(WV))\n"

<<"%V$WV \n"

cb = Cab(WV)
<<"%V$cb \n"
checkNum(cb[0],5)
checkNum(cb[1],2)



      SE=  R[1][2];   // single element

<<"%V$SE $R[1][2]\n"
      checkStr(SE, R[1][2])
      checkStr(SE, "90")      






<<"$(typeof(WV)) $(Caz(WV)) \n"
<<"$R\n"
<<"%V$WV \n"

<<"%V$WV[0][0] \n"
<<"%V$R[1][1] \n"
WV->info(1)
val = WV[0][0];
<<"%V$val \n"
val->info(1)
checkStr(WV[0][0], R[1][1])


//checkOut()


WV=  R[1:5:][1]  // rows 1 thru 5 - one col
WV->info(1)
<<"%V$WV \n"
<<"%V$WV[0][0] \n"
WV->info(1)
val = WV[0][0];
<<"%V$val \n"
checkStr(WV[0][0], "74")

WV=  R[1:5:][1:2]  // rows 1 thru 5 - cols 1 thru 2


WV->info(1)
<<"%V$WV \n"
<<"%V$WV[1][0] \n"
checkStr(WV[1][0], "79")
WV->info(1)


val = "hey"
val->info(1)
<<"%V$val \n"
val = WV[1][0];
NWV= WV

WV->info(1)
<<"%V$WV \n"
<<"%V$NWV \n"
NWV->info(1)
WV->info(1)
<<"%V$val \n"

val->info(1)

checkStr(val, "79")

val = WV[0][1];
<<"0 %V$val \n"

val = WV[1][1];
<<"1 %V$val \n"

val = WV[2][1];
<<"2 %V$val \n"


val = WV[3][1];
<<"3 %V$val \n"

val = WV[4][1];
<<"4 1 %V$val \n"

val = WV[4][0];
<<"4 0 %V$val \n"


val = WV[0][0];
<<"0 0 %V$val \n"

val = WV[0][2];
<<"0 2 %V$val \n"

checkOut()


val = "hay"
<<"%V$val \n"


  //   R[2::1][4] = itoa(julian(R[2::1][3]))

<<"$R[::][::]\n"

<<"$R[::][1:3:]\n"


<<"$R\n"

<<"$R[::]\n"


<<"$R[3] \n"
R->info(1)
SR = R[3]
R->info(1)
<<"%V $SR \n"
SR->info(1)
<<"$R[3][1] \n"
SRSC = R[3][1]

<<"%V $SRSC \n"
SRSC->info(1)

  checkStage()
  checkProgress("How Good")
  checkOut()






