A= popen("ls ","r")
<2>  1 [  1] CREATEV :
<2>  2 [  4] LOADRS :<2>  3 [  4] LOADRS :<2>  4 [ 14] CALLF : 546 na 2
<2>  5 [  5] STORER : _R  => A  65
<2>  6 [  7] ENDIC :
while
<3>  1 [  7] ENDIC : -> <16> 
(1)
<4>  1 [  9] LOADRN : 1 
<4>  2 [  7] ENDIC : -> <17> 
{
<5>  1 [  7] ENDIC : -> <16> 
nwr = r_words(A,Wd)
<6>  1 [  1] CREATEV :
<6>  2 [ 12] PUSH_SIV :  65 -1  A 
<6>  3 [  1] CREATEV :
<6>  4 [ 12] PUSH_SIV :  187 -1  Wd 
<6>  5 [ 14] CALLF : 673 na 2
<6>  6 [  5] STORER : _R  => nwr  343
<6>  7 [  7] ENDIC :
if
<7>  1 [  7] ENDIC :
(nwr > 0)
<8>  1 [ 12] PUSH_SIV :  343 -1  nwr 
<8>  2 [  9] LOADRN : 0 
<8>  3 [  6] OPERA :  GT
<8>  4 [  7] ENDIC : -> <14> 
{
<<" ${Wd[0]} \n"
<10>  1 [  9] LOADRN : 0 
<10>  2 [  7] ENDIC :
fn = Wd[0]
<11>  1 [  1] CREATEV :
<11>  2 [  9] LOADRN : 0 
<11>  3 [ 17] PUSH_SIVELE :  -2
<11>  4 [  5] STORER : _R  => fn  212
<11>  5 [  7] ENDIC :
!!" cp $fn ${fn}.xxx"
<12>  1 [  7] ENDIC :
}
<13>  1 [  7] ENDIC :
else
break
<15>  1 [  7] ENDIC :
} 
<16>  1 [  7] ENDIC :
<<"DONE \n"
<17>  1 [  7] ENDIC :
STOP!
<18>  1 [ 14] CALLF : 454 na 0
<18>  2 [  7] ENDIC :
