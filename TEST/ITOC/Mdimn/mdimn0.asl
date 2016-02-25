CheckIn()

setdebug(1)


int V[4] = {1,2,3,4}

W = V

W->reverse()

<<"%V$V \n"

<<"%v $W \n"

// list by two's
<<"V is %(2,, ,\n) $V \n"

T = W[1:-1]

<<"%V $T \n"

T->reverse()
<<"%v $T \n"

//W[1:-1] = T

<<"%v $W \n"

int MI[10][4]

MI[0][2] = 66
MI[1][2] = 47
MI[7][2] = 79

CheckNum(MI[1][2],47)

CheckNum(MI[0][2],66)
<<"$MI\n"

MI[1][2] = 77


CheckNum(MI[1][2],77)

MI[2][0:2] = 68

CheckNum(MI[2][1],68)

<<"$MI\n"




MI[3][0:3] = V

MI[5][0:-1] = W

<<"%(4,, ,\n)$MI \n"


MI[4][0:3] = W

Z = W[1:-1]

<<"%V $Z \n"

MI[7:9][0:2] = Z

<<"%(4,, ,\n)$MI \n"



// FIXME--- FIXED

MI[7:9][0:2] = W[1:-1]


<<"%(4,[, ,]\n)$MI \n"

//CheckNum(MI[7][1],2)
//CheckNum(MI[8][1],2)
//CheckNum(MI[9][1],2)


//MI[5][*] = W

<<"%(4,\t<, ,>\n)$MI \n"

//<<"  $MI[0][0:-1] \n"

 CheckOut()

;