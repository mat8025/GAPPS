///
///
///

setDebug(1,@level,2,@pline,@step,@~stderr,@trace)
setDebug(1,@filter,0,@filterfile,ALLOW_,"ds_svar.cpp","ds_storesvar.cpp");

//filterDebug(0)
checkIn()

svar R = Split("como,llegamos,aqui",',');

<<"type $(typeof(R)) size $(Caz(R))\n"
<<"$R[::]\n"


r00 = R[0];

 r01 = R[1];

 r02 = R[2];
 
<<"%V $r00 $r01 $r02\n"


  CheckStr(r00,"como")
  CheckStr(r01,"llegamos")
  CheckStr(r02,"aqui")

checkStage()



T = Split("bebi  cerveza ayer");

 r00 = T[0];

 r01 = T[1];

 r02 = T[2];
 
<<"%V $r00 $r01 $r02\n"
<<"$T[::]\n"

  CheckStr(r00,"bebi")
  CheckStr(r01,"cerveza")
  CheckStr(r02,"ayer")

checkStage()






checkOut()