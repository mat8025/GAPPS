setdebug(0)

wf = _argv[1] 

A=ofr(wf)


S=readfile(A)


S->join()

C = Split(S[0])


C->Sort()

K=C->findVal("trap.h",0,1,1)

<<" $K \n"

C->cut(K)


K=C->findVal('\',0,1,1)
//K=C->findVal("\\",0,1,1)

//<<" $K \n"

C->cut(K)

<<"%7\t\t,\s\s\\\nR$C \n"


