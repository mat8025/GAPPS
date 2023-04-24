///
///
///

// check is a known func

S=functions();

 S.sort();

A=ofw("funcs_list.csv")
<<[A]"%(1,,,\n)$S\n"
cf(A);
//exit()
A=ofr("funcs_list.csv")
if (A != -1) {
S=readfile(A);
sz= Caz(S)

<<"fname,table_id, libname,info,test,desc\n"
 for (i= 0; i < 240; i++) {

 C= Split(S[i],',');
 foo = C[0];
 index = findfunc(foo)
 
 <<"$foo, $index, $C[1] ,Y, N, '${C[2::]}', \n"

}

}
