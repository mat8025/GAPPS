//%*********************************************** 
//*  @script mdimn.asl 
//* 
//*  @comment test MD range assignment
//*  @release CARBON 
//*  @vers 1.16 S Sulfur                                                  
//*  @date Sat Mar  9 16:54:34 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


chkIn(_dblevel)


int MI[4][5];

//M[2][3] = 36 // crashes TBF -should just warn


MI[1][3] = 35
val = MI[1][3]

<<"$val\n"
chkN(val,35)


 i =2;
MI[i][3] = 36
val = MI[i][3]
<<"$val\n"
chkN(val,36)


 k =1;
MI[i][k] = 77
val = MI[i][k]
<<"$val\n"
chkN(val,77)


k =2;
i= 3;
val2 = 88;
MI[i][k] = val2
val = MI[i][k]
<<"$val\n"
chkN(val,88)






MI[0][3] = 34
MI[2][3] = 36
MI[3][3] = 37


MI[1][1] = 79
MI[2][1] = 47



<<"$MI \n"



chkN(MI[2][3],36)

for ( i= 0; i<4; i++) {
val = MI[i][3]
<<"$MI[i][3] $val\n"
<<"$MI[i][::] \n"

}
 

chkOut()


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

chkN(MI[1][2],47)

chkN(MI[0][2],66)

MI->info(1)
<<"$MI\n"
<<"%(4,, ,\n)$MI \n"
MI[1][2] = 77


chkN(MI[1][2],77)

MI[3][3] = 47
MI[4][3] = 79

MI[2:4][1:3] = 68

chkN(MI[2][1],68)
MI->info(1)
<<"$MI\n"
<<"%(4,, ,\n)$MI \n"



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

//chkN(MI[7][1],2)
//chkN(MI[8][1],2)
//chkN(MI[9][1],2)


//MI[5][*] = W

<<"%(4,\t<, ,>\n)$MI \n"

//<<"  $MI[0][0:-1] \n"

 N = 8
 M = 3

 float Re[N];

 float ReStg[M][N];


 Re = vgen(FLOAT_,N,0,1)

<<"%6.1f$Re \n"


 ReStg[1][::] = Re

<<"$ReStg \n"

 ReStg[0][::] = (Re *2 );

<<"%6.1f$ReStg \n"

 ReStg[1][::] = ReStg[1][::] *  Re ;  // works

<<"%6.1f$ReStg \n"

 cmplx CS[N];

 cmplx CStg[M][N];

 CS->setReal(Re)


<<"%6.1f $CS\n"


 CStg[1][::] = CS

<<"%6.1f$CStg\n"

 CStg[0][::] = CS

<<"%6.1f$CStg\n"

 CStg[1][::] = CStg[1][::] *  CS ;  //  works


<<"%6.1f$CStg\n"


 ReStg[1][::]  *= Re    // does not work  -- no self ops??

<<"%6.1f$ReStg \n"

 ReStg[1][::] = ReStg[1][::] *  Re   // works

<<"%6.1f$ReStg \n"


 ReStg[::][::] = Re

<<"%6.1f$ReStg \n"

 ReStg[1][::] = 3

<<"$ReStg \n"


 ReStg[2][::] *= 3

<<"%6.1f$ReStg \n"

  Re *= 3
  
<<"$Re \n"

// this crashes

ReStg[::][::] *= -5

<<"%6.1f$ReStg \n"


chkOut()



