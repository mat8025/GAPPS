/* 
 *  @script array-subsrange.asl 
 * 
 *  @comment test array range subscript 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.28 C-Li-Ni]                                
 *  @date 02/27/2021 13:39:27 
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
<|Use_=
Demo  of subsrange
///////////////////////
|>

// TBF -- #include "debug"  // will crash during ic_rw of exe
// but not for other scripts?? - mem corruption? 7/10/21


#include "debug.asl"

if (_dblevel >0) {
   debugON()
     <<"$Use_\n"
}

//filterFileDebug(REJECT_,"scopesindex_e","scope_e","scope_findvar","exp_e","exp_lhs_e","ds_sivmem");
filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar","#array_parse","#array_subset")



chkIn(_dblevel)


do_circ = 1;

// test array indexing

 N = 20

 YV = Igen(N,20,1)

 ok=chkN(YV[0],20)


YV<-pinfo()


 <<"%V$YV \n"

 S = YV[0:-3:]

 <<"%V$S \n"


  chkN(S[0],20)
  chkN(S[5],25)



 e = S[-1]

<<"$S\n"
<<"$e $S[-1]\n"
 e= S[0]
<<"$e $S[0]\n"

 e = S[-2]
<<"$e $S[-2]\n"

 e= YV[-3]

ok =chkN(e,YV[17])

<<" $YV \n"
 AV = YV[6:16:2] 

<<" $AV \n"
AV<-pinfo()
 AV = YV[4:14:2]
AV<-pinfo()


 e= AV[0]

<<"$e\n"



 e = YV[-1];

<<"%V$e $YV[19]\n"

YV<-pinfo()


// ok=chkN(e,YV[19])

 chkN(e,YV[19])


if (!ok) {
   <<"FAIL 2\n"
 }

 e = YV[-2]

<<"$e $YV[18] $YV[-2]\n"

 ok=chkN(e,YV[18])

 if (!ok) {
   <<"FAIL 3 \n"
 }

 e = YV[-3]

<<"$e $YV[17] $YV[-3]\n"

 ok=chkN(e,YV[17])

 if (!ok) {
   <<"FAIL 4\n"
 }

 e = YV[-20]

<<" %V$e  is $YV[0] $YV[-20]\n"

 ok=chkN(e,YV[0])
 if (!ok) {
   <<"FAIL 5\n"

 }

 e = YV[-21]

<<" %V$e \n"

 e = YV[-22]

<<" %V$e \n"

 <<"%V$S \n"

 ok=chkN(S[0],20)
 if (!ok) {
   <<"FAIL 6\n"
 }

 ok=chkN(S[10],30)
 if (!ok) {
   <<"FAIL 7\n"

 }
 ok=chkN(S[17],37)
 if (!ok) {
   <<"FAIL 8\n"

 }
 ok=chkN(S[-1],37)
 if (!ok) {
   <<"FAIL 9\n"

 }

<<" %V$YV \n"


<<" %V$YV[2:-10:2] \n"

// testargs(YV[2:-10:2])
//iread()
<<" \n"


if (do_circ) {





 AVN = YV[-16:-6:2]

<<"[-16:-6:2]  $AVN\n"

<<"%V$YV[-16:-10:2] \n"
<<"%V$YV[-16:-6:2] \n"


chkN(AVN[0],24)



// testargs(YV[-16:-10:2])
//iread()

<<" \n"
}


AVC = YV[-16:-15:-1]
<<"[-16:-15:-1]  $AVC\n"
AVC<-pinfo()

//<<"%V$YV[-16:-10:-2] \n"

// testargs(YV[-16:-10:2],YV[1:-1:3])


<<"YVC $(YV[-16:-15:-1])\n"

//iread()
 chkOut()
 

# list of files where debug is filtered out
