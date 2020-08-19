#  

setdebug(1,@pline,@~step,@trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc","opera_ic");
filterFileDebug(ALLOWALL_,"ic_","array_subset");


chkIn(1)

str le;
str le12;

Mol = ( "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" ) ;

<<"List is $Mol \n"

sz = caz(Mol)
<<" %V $sz \n";

<<"$(typeof(Mol)) size $(caz(Mol)) $sz \n"

chkN(sz,12)


<<"first month $Mol[0]\n"

<<"second month $Mol[1]\n"

<<"twelveth month $Mol[11]\n"

le4 = Mol[3];

<<"$(typeof(le4)) %V$le4\n"

<<"le4[0] $le4[0] \n"


chkStr(le4,"APR")

le12 = Mol[11];

<<"$(typeof(le12)) %V$le12\n"

le = Mol[0]

<<"$(typeof(le)) %V$le\n"

chkStr(le,"JAN")

<<"le checked\n"

chkStr(Mol[0],"JAN")

<<"Mol[0] checked\n"

le = Mol[1]

chkStr(le,"FEB")

<<"$(typeof(le)) %V$le\n"

chkStr("FEB",Mol[1])

<<"$Mol[1] Mol[1] checked\n"

chkStr(Mol[1],"FEB")



checkProgress()

<<" DONE Lists \n"
//////////////////////////////////
