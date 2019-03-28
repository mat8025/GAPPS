///
///
///

// check is a known func

A=ofr("funcs_list.csv")

S=readfile(A);
sz= Caz(S)

<<"fname,table_id, libname,info,test,desc\n"
 for (i= 0; i < 90; i++) {

 C= Split(S[i],',');
 foo = C[0];
 index = findfunc(foo)
 
 <<"$foo, $index, $C[1] ,Y, N, '${C[2::]}', \n"

}

