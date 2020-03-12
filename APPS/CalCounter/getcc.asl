//%*********************************************** 
//*  @script getcc.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Sun Apr  7 15:12:32 2019 
//*  @cdate Sun Jan  6 19:13:55 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///

!!"rclup"
!!"grep Totals `ls -tr DD/dd*` > cc.log"

A=ofr("cc.log")

S=readfile(A)
cf(A)
nlines = Caz(S);

<<"$S\n"


float CCN[>300][3]
// have to sort via date before file write
int n= 0;
for (i = 0; i< nlines;i++) {

 L= Split(S[i],',');
  dt= spat(L[0],":",-1)
  dt= spat(dt,"dd_",1)
  dt= ssub(dt,"-","/",0)
  jd= julian(dt)
 <<"$jd  $L[3]  $L[4]\n"
  CCN[n][0] = jd;
  CCN[n][1] = atof(L[3])
  CCN[n][2] = atof(L[4])
  n++;
}
//cf(A)
 CCF=msortCol(CCN[0:n-1][::],0)

A=ofw("jcc.tsv")
<<[A]"%5.2f%(3,, ,\n)$CCF[0:n-1][::] \n"
cf(A)

// cals on julian date   jcc

!!"cp jcc.tsv ~/gapps/DEMOS/Wex"

//======================================//