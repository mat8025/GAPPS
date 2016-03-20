
setdebug(1,"trace")

int A[5][3];


A[0][1] = 47
A[3][0] = 79

<<"%V$A[3][0]\n"

Svar  T[5][5];

sz = Caz(T)
<<"%V$sz \n"
nd = Cab(T)
<<"%V$nd \n"

T[3][1] = "brown "

sz = Caz(T)
<<"%V$sz \n"
nd = Cab(T)
<<"%V$nd \n"


T[0][0] = "slightly"
T[1][0] = "really"
T[2][0] = "heavily"
T[3][0] = "very"
T[4][0] = "mildly"

ke =1


T[4][ke] = "angry "
T[3][ke] = "mad "
T[2][ke] = "sad "
T[1][ke] = "bad "
T[0][ke] = "glad"

ke =2 

T[0][ke] = "golden"
T[1][ke] = "grey"
T[2][ke] = "brown"
T[3][ke] = "striped"
T[4][ke] = "black "

ke = 3


T[0][ke] = "running"
T[1][ke] = "swimming"
T[2][ke] = "crouching"
T[3][ke] = "sleeping"
T[4][ke] = "charging"

ke = 4

T[0][ke] = "bears"
T[1][ke] = "dogs"
T[2][ke] = "tigers"
T[3][ke] = "cats"
T[4][ke] = "birds"




// almost
//T[6][0:3] =  Split("happy pink standing flamingos")









<<"$T\n"


<<"[4][1] $T[4][1] \n"
<<"[4][0] $T[4][0] \n"
<<"[3][0] $T[3][0] \n"
<<"[0][1] $T[0][1] \n"

nrows = 5; ncols = 5;
  for (r = 0; r < nrows; r++) {
<<"$r "
    for (c = 0; c < ncols; c++) {

<<" $T[r][c] "

    }
<<"\n"  
  }

//T[25] = "maganese"
//T[26] = "iron"
//T[27] = "cobalt"

<<"$T\n"

<<"[0][0] $T[0][0] \n"

<<"[1][0] $T[1][0] \n"

<<"[2][3] $T[2][3] \n"


<<"%(4,<, , >\n)$T\n"


W= T;

sz = Caz(W)
<<"w%V$sz \n"
nd = Cab(W)
<<"w%V$nd \n"

<<"W= $W\n"





<<"//////////////\n"
// svar transpose


V= stran(T)

<<"$V := \n"




sz = Caz(V)
<<"v%V$sz \n"
nd = Cab(V)
<<"v%V$nd \n"


<<"$V\n"

nrows = 5; ncols = 5;
  for (r = 0; r < nrows; r++) {
<<"$r "
    for (c = 0; c < ncols; c++) {

<<" $V[r][c] "

    }
<<"\n"  
  }



<<"%(7,, ,\n)$V\n"


/{
P=msortcol(T,0)

<<"Psort $P\n"
/}


exit();


Svar S[10];

sz = Caz(S)
<<"%V$sz \n"
nd = Cab(S)
<<"%V$nd \n"
S[1] = "hey buddy"

S[2] = "hey man"

<<"[1] $S[1] \n"

<<"[2] $S[2] \n"


exit()




//svar M[10][4];

str M[10][4];

M[5][2] = " a fast plane "

M[0][1] = " a fish "

M[1][3] = " a bird "

M[0][2] = " a man "


<<"$M[0][1] \n"

<<"$M[0][2] \n"


<<"$M[1][3] \n"


<<"$M[5][2] \n"

<<"$M[5][3] \n"


<<"$(Cab(M))\n"


