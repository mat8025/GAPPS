CheckIn()

// test array indexing

N = 20


 YV = Igen(N,21,1)

<<" $YV \n"

#define ROWS 10
#define COLS 20


int M[ROWS][COLS]

<<"$M\n"


    M[1][::] = YV


<<"$M\n"



    M[3][0:19:] = YV

CheckNum(M[3][1],YV[1])
CheckNum(M[3][19],YV[19])

    M[4][0:10:] = YV

    M[5][9:19:] = YV

    M[6][9:18:] = YV

    j = 7

    M[j][5:12:] = YV

CheckNum(M[7][6],YV[1])

<<"$M\n"

    M[::][::] = 0
    for (j = 0; j < 5; j++) {

       M[j][::] = YV
       CheckNum(M[j][1],YV[1])
       <<"$M\n"
    }


CheckOut()

