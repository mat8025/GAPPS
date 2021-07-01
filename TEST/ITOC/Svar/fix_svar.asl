
///
///
///

#include "debug"

if (_dblevel >0) {
   debugON()
}

   chkIn(_dblevel);


IV = vgen(INT_,10,1,-1)


<<"$IV[0] $IV[9]\n"

<<" %(2,->,:,<-\n)$IV[::] \n"


!e


Svar Mo[] = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }

chkStr(Mo[0],"JAN")

chkStr(Mo[11],"DEC")


//<<"%V %(5,, ,\n)$Mopts[::] \n"



 k= IV[-1];

<<"%V$k\n"

<<"%V$IV[1]\n"
<<"%V$IV[-1]\n"

chkN(IV[1],2)

chkN(IV[-1],10)





str Sr ="all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help";


//str Sr ="all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,help";



len = slen(Sr);

<<"%V $len\n"

<<"%V $Sr\n"




svar Mopts[] = Split(Sr,",");



//<<"%V %(5,, ,\n)$Mopts[::] \n"
<<" %(5,, ,\n)$Mopts[::] \n"

chkStr("all",Mopts[0]);

chkStr("matrix",Mopts[2]);
!e

svar Sopts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,",",");



chkStr("all",Sopts[0]);

<<"$Sopts[0] \n"

<<"%V $Sopts \n"

chkStr("matrix",Sopts[2]);

<<"$Sopts[2] $Sopts[3] \n"






<<"%V $Sopts \n"


svar Popts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help",",");



<<"%V $Popts \n"
sz=Caz(Popts)

chkStr("array",Popts[1]);

for (i= 0;i < sz; i++) {
<<"[${i}] $Popts[i] \n"
}

chkOut()

