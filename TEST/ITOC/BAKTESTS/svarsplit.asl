///
///
///

setDebug(1,@keep,@~pline,@~trace)
filterFuncDebug(ALLOWALL_);
filterFileDebug(ALLOWALL_,"xxx");

checkIn(0)

Svar Opts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,",",");

<<"$Opts \n"


checkStr("all",Opts[0]);

checkStr("matrix",Opts[2]);

str S ="all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help";

len = slen(S);

<<"%V $len\n"

<<"%V $S\n"

Svar Mopts[] = Split(S,",");

<<"%V %(5,, ,\n)$Mopts[::] \n"

checkStr("all",Mopts[0]);

checkStr("matrix",Mopts[2]);


Svar Sopts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,",",");


<<"%V $Sopts \n"


checkStr("bops",Sopts[4]);

checkStr("class",Sopts[8]);


Svar Popts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help",",");


<<"%V $Popts \n"

checkStr("array",Popts[1]);


checkOut();
